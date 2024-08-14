<template>
  <Popover>
    <PopoverTrigger as-child>
      <Button
        variant="outline"
        :class="
          cn(
            'justify-start px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100 hover:bg-primary-100 hover:text-primary-800',
            !value && 'text-muted-foreground'
          )
        "
      >
        <CalendarIcon class="mr-2 h-4 w-4" />
        <template v-if="value.start">
          <template v-if="value.end">
            {{ df.format(value.start.toDate(getLocalTimeZone())) }} -
            {{ df.format(value.end.toDate(getLocalTimeZone())) }}
          </template>

          <template v-else>
            {{ df.format(value.start.toDate(getLocalTimeZone())) }}
          </template>
        </template>
        <template v-else> Pick a date </template>
      </Button>
    </PopoverTrigger>
    <PopoverContent class="w-auto p-0">
      <RangeCalendar v-model="value" initial-focus :number-of-months="2" />
    </PopoverContent>
  </Popover>
</template>

<script setup>
import { ref, watch } from "vue";
import {
  CalendarDate,
  DateFormatter,
  getLocalTimeZone,
} from "@internationalized/date";

import { CalendarIcon } from "@radix-icons/vue";
import { RangeCalendar } from "@/components/ui/range-calendar";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/lib/utils";

const props = defineProps({
  modelValue: {
    type: Object,
    required: true,
  },
});

const df = new DateFormatter("en-US", {
  dateStyle: "medium",
});

const value = ref({ ...props.modelValue });

const emit = defineEmits(["update:modelValue"]);

watch(value, (newValue) => {
  emit("update:modelValue", { ...newValue });
});
</script>
