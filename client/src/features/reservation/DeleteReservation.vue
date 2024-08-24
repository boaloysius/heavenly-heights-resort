<template>
  <Button
    class="group flex items-center gap-2 text-primary-300 flex-grow hover:bg-accent-600 transition-colors hover:text-primary-900 h-auto rounded-none bg-transparent py-0"
    @click="onDelete"
  >
    <SpinnerMini v-if="isDeleting" />
    <span
      v-else
      class="flex items-center gap-2 uppercase text-xs font-bold flex-grow"
    >
      <TrashIcon
        class="h-5 w-5 text-primary-600 group-hover:text-primary-800 transition-colors"
      />
      <span class="mt-1">Delete</span>
    </span>
  </Button>
</template>

<script setup>
import { Button } from "@/components/ui/button";
import { TrashIcon } from "@heroicons/vue/24/solid";
import SpinnerMini from "@/components/SpinnerMini.vue";
import { useDeleteReservation } from "./composables/useDeleteReservation";

const { isDeleting, deleteReservation } = useDeleteReservation();

const { reservation } = defineProps({
  reservation: {
    type: Object,
    required: true,
  },
});

const { id } = reservation;

const onDelete = () => {
  if (confirm("Are you sure you want to delete this reservation?")) {
    deleteReservation(id);
  }
};
</script>
