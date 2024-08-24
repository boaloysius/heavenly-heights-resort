<template>
  <span>
    {{ displayText }}{{ " " }}
    <button
      class="text-primary-700 border-b border-primary-700 leading-3 pb-1"
      @click="toggleExpanded"
    >
      {{ isExpanded ? "Show less" : "Show more" }}
    </button>
  </span>
</template>
<script setup>
import { ref, computed } from "vue";

const { text } = defineProps({
  text: { type: String, required: true },
});

const isExpanded = ref(false);

const displayText = computed(() => {
  return isExpanded.value
    ? text
    : text.split(" ").slice(0, 40).join(" ") + "...";
});

function toggleExpanded() {
  console.log(isExpanded.value);
  isExpanded.value = !isExpanded.value;
}
</script>
