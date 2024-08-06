<template>
  <Dialog>
    <DialogTrigger as-child>
      <Button
        class="bg-accent-500 text-primary-800 text-md font-semibold hover:bg-accent-600 transition-all"
      >
        Create Cabin
      </Button>
    </DialogTrigger>
    <DialogContent
      class="bg-primary-950 text-primary-100 sm:max-w-[700px] grid-rows-[auto_minmax(0,1fr)_auto] p-0 max-h-[90dvh] font-josefin border-primary-800 border"
    >
      <DialogHeader class="p-6 pb-0 mb-4">
        <DialogTitle class="text-3xl text-accent-400 font-medium">
          <span>Create Cabin</span>
        </DialogTitle>
        <DialogDescription class="text-md">
          <span> Add cabin details here. Click save when you're done. </span>
        </DialogDescription>
      </DialogHeader>
      <CabinForm ref="cabinForm" :onSubmit="onSubmit" />
      <DialogFooter class="p-6 pt-0">
        <Button
          type="button"
          @click="submitForm"
          class="bg-accent-500 px-4 py-4 text-primary-800 text-md hover:bg-accent-600 transition-all"
        >
          Save changes
        </Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>

<script setup lang="ts">
import { computed, defineProps, ref } from "vue";
import { PencilIcon, PlusIcon } from "@heroicons/vue/24/solid";

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
import CabinForm from "@/features/cabin/CabinForm.vue";

const cabinForm = ref(null);

function submitForm() {
  cabinForm.value.submit();
}

function onSubmit(values) {
  console.log("Create cabin", values);
}
</script>
