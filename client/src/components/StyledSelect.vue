<template>
  <div class="flex gap-2 items-baseline">
    <div>
      {{ label }}
    </div>
    <Select
      v-model="selectedValue"
      @update="onSelectChange"
      class="focus:ring-2"
    >
      <SelectTrigger
        :class="`w-[${width}] bg-accent-600 rounded-sm text-lg text-primary-100 border-none p-4`"
      >
        <SelectValue :placeholder="placeholder" />
      </SelectTrigger>
      <SelectContent>
        <SelectGroup>
          <SelectLabel v-if="label">{{ label }}</SelectLabel>
          <SelectItem
            v-for="option in options"
            :key="option.value"
            :value="option.value"
          >
            {{ option.label }}
          </SelectItem>
        </SelectGroup>
      </SelectContent>
    </Select>
  </div>
</template>
<script setup>
import { ref, watch } from "vue";

import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

const props = defineProps({
  modelValue: String,
  options: {
    type: Array,
    required: true,
    default: () => [],
  },
  placeholder: {
    type: String,
    default: "Select an option",
  },
  label: {
    type: String,
    default: "",
  },
  width: {
    type: String,
    default: "180px",
  },
});

const emit = defineEmits(["update:modelValue"]);
const selectedValue = ref(props.modelValue);

watch(selectedValue, (newValue) => {
  emit("update:modelValue", newValue);
});

watch(
  () => props.modelValue,
  (newValue) => {
    selectedValue.value = newValue;
  }
);

function onSelectChange(newValue) {
  selectedValue.value = newValue;
}
</script>
