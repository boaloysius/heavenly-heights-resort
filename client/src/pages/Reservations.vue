<template>These are my reservations</template>
<script setup>
const { cabin } = defineProps({
  cabin: {
    type: Object,
    default: () => ({}),
  },
});
</script>
