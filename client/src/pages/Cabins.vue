<template>
  <div>
    <h1 class="text-4xl mb-5 text-accent-400 font-medium">Our Luxury Cabins</h1>
    <p class="text-primary-200 text-lg mb-10">
      Experience the perfect blend of comfort and luxury in our cabins nestled
      in the heart of the Italian Dolomites. Wake up to breathtaking mountain
      vistas, spend your days wandering through serene forests, or unwind in
      your private hot tub beneath a canopy of stars. Immerse yourself in
      nature’s splendor in your own secluded retreat. It's the ideal destination
      for a tranquil, rejuvenating getaway. Welcome to your paradise.
    </p>

    <div class="flex flex-col gap-4">
      <div v-if="isAdmin" class="flex justify-end"><CreateCabin /></div>
      <CabinList />
    </div>
  </div>
</template>

<script setup>
// TODO: Add filter
// TODO: Add reservation reminder
import CabinList from "@/features/cabin/CabinList.vue";
import CreateCabin from "@/features/cabin/CreateCabin.vue";
import { useAuth } from "@/features/auth/composables/useAuth";
const { isAdmin } = useAuth();
</script>
