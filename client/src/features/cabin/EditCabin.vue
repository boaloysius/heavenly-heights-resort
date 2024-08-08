<template>
  <Dialog v-model:open="open">
    <DialogTrigger as-child>
      <button class="hover:text-accent-600">
        <PencilIcon class="h-5 w-5" />
      </button>
    </DialogTrigger>
    <DialogContent
      class="bg-primary-950 text-primary-100 sm:max-w-[700px] grid-rows-[auto_minmax(0,1fr)_auto] p-0 max-h-[90dvh] font-josefin border-primary-800 border"
    >
      <DialogHeader class="p-6 pb-0 mb-4">
        <DialogTitle class="text-3xl text-accent-400 font-medium">
          <span>Edit Cabin</span>
        </DialogTitle>
        <DialogDescription class="text-md">
          <span>
            Make changes to your cabin here. Click save when you're done.
          </span>
        </DialogDescription>
      </DialogHeader>
      <CabinForm ref="cabinForm" :cabin="cabin" :onSubmit="onSubmit" />
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
import { defineProps, ref } from "vue";
import { PencilIcon } from "@heroicons/vue/24/solid";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

import CabinForm from "./CabinForm.vue";
import { useEditCabin } from "./composables/useEditCabin";

import { formatErrors } from "@/lib/utils";

const { cabin } = defineProps({
  cabin: {
    type: Object,
    required: true,
  },
});

const cabinForm = ref(null);

const open = ref(false);

const { isEditing, editCabin } = useEditCabin();

function submitForm() {
  cabinForm.value.submit();
}

async function onSubmit(values, { setErrors }) {
  try {
    await editCabin({ newCabinData: values, id: cabin.id });
    console.log("Done");
    closeDialog();
  } catch (err) {
    err?.errors && setErrors(formatErrors(err.errors));
  }
}

function closeDialog() {
  open.value = false;
}
</script>
