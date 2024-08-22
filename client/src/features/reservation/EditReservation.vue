<template>
  <Dialog v-model:open="open">
    <DialogTrigger as-child>
      <Button
        class="group flex items-center gap-2 text-primary-300 flex-grow hover:bg-accent-600 transition-colors hover:text-primary-900 h-auto rounded-none bg-transparent py-0"
      >
        <span
          class="flex items-center gap-2 uppercase text-xs font-bold flex-grow"
        >
          <PencilSquareIcon
            class="h-5 w-5 text-primary-600 group-hover:text-primary-800 transition-colors"
          />
          <span class="mt-1">Edit</span>
        </span>
      </Button>
    </DialogTrigger>
    <DialogContent
      class="bg-primary-950 text-primary-100 sm:max-w-[700px] grid-rows-[auto_minmax(0,1fr)_auto] p-0 max-h-[90dvh] font-josefin border-primary-800 border"
    >
      <DialogHeader class="p-6 pb-0 mb-4">
        <DialogTitle class="text-3xl text-accent-400 font-medium">
          <span>Edit Reservation</span>
        </DialogTitle>
        <DialogDescription class="text-md">
          <span>
            Make changes to your reservation details here. Click save when
            you're done.
          </span>
        </DialogDescription>
      </DialogHeader>
      <EditReservationForm
        ref="reservationForm"
        :reservation="reservation"
        :onSubmit="onSubmit"
      />
      <DialogFooter class="p-6 pt-0">
        <Button
          type="button"
          @click="submitForm"
          class="bg-accent-500 px-4 py-4 text-primary-800 text-md hover:bg-accent-600 transition-all"
          :disabled="isEditing"
        >
          Save changes
        </Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>

<script setup>
import { ref } from "vue";
import { Button } from "@/components/ui/button";
import { PencilSquareIcon } from "@heroicons/vue/24/solid";
import { useEditReservation } from "./composables/useEditReservation";

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import EditReservationForm from "./EditReservationForm.vue";

const { isEditing, editReservation } = useEditReservation();

const { reservation } = defineProps({
  reservation: {
    type: Object,
    required: true,
  },
});

const open = ref(false);
const reservationForm = ref(null);

function submitForm() {
  reservationForm.value.submit();
}

async function onSubmit(values, { setErrors }) {
  if (Object.keys(values).includes("is_paid")) {
    values["is_paid"] = JSON.parse(values["is_paid"]);
  }
  try {
    await editReservation({ newReservationData: values, id: reservation.id });
    closeDialog();
  } catch (err) {
    err?.errors && setErrors(formatErrors(err.errors));
  }
}

function closeDialog() {
  open.value = false;
}
</script>
