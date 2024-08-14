<template>
  <div class="flex border-primary-800 border">
    <div class="relative flex-1">
      <img
        :src="imageUrl || DummyCabinImage"
        :alt="`Cabin ${name}`"
        class="border-r border-primary-800 object-cover w-full h-full"
      />
    </div>

    <div class="flex-grow">
      <div class="pt-5 pb-4 px-7 bg-primary-950">
        <h3 class="text-accent-500 font-semibold text-2xl mb-3">
          Cabin {{ name }}
        </h3>

        <div class="flex gap-3 items-center mb-2">
          <UsersIcon class="h-5 w-5 text-primary-600" />
          <p class="text-lg text-primary-200">
            For up to <span class="font-bold">{{ maxCapacity }}</span> guests
          </p>
        </div>

        <p class="flex gap-3 justify-end items-baseline">
          <span v-if="discount > 0">
            <span class="text-3xl font-[350]">
              {{ regularPrice - discount }}
            </span>
            <span class="line-through font-semibold text-primary-600">
              {{ regularPrice }}
            </span>
          </span>

          <span v-else class="text-3xl font-[350]">{{ regularPrice }}</span>

          <span class="text-primary-200">/ night</span>
        </p>
      </div>

      <div class="bg-primary-950 border-t border-t-primary-800 text-right">
        <div class="flex">
          <div class="flex justify-end flex-grow px-6 content-center gap-3">
            <EditCabin :cabin="cabin" />
            <button class="hover:text-accent-600" @click="onDelete">
              <TrashIcon class="h-5 w-5" />
            </button>
          </div>
          <RouterLink
            :to="`/cabins/${id}`"
            class="border-l border-primary-800 py-4 px-6 inline-block hover:bg-accent-600 transition-all hover:text-primary-900"
          >
            Details & reservation &rarr;
          </RouterLink>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { defineProps } from "vue";
import { RouterLink } from "vue-router";
import { UsersIcon, TrashIcon } from "@heroicons/vue/24/solid";

import DummyCabinImage from "@/assets/dummy_cabin.jpg";

import EditCabin from "./EditCabin.vue";
import { useDeleteCabin } from "./composables/useDeleteCabin";

const { cabin } = defineProps({
  cabin: {
    type: Object,
    required: true,
  },
});

const { id, name, maxCapacity, regularPrice, discount, imageUrl } = cabin;
const { isDeleting, deleteCabin } = useDeleteCabin();

const onDelete = () => {
  if (confirm("Are you sure you want to delete this cabin?")) {
    deleteCabin(id);
  }
};
</script>
