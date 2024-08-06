<template>
  <div>
    <h1 class="text-4xl mb-5 text-accent-400 font-medium">Our Luxury Cabins</h1>
    <p class="text-primary-200 text-lg mb-10">
      Cozy yet luxurious cabins, located right in the heart of the Italian
      Dolomites. Imagine waking up to beautiful mountain views, spending your
      days exploring the dark forests around, or just relaxing in your private
      hot tub under the stars. Enjoy nature&apos;s beauty in your own little
      home away from home. The perfect spot for a peaceful, calm vacation.
      Welcome to paradise.
    </p>

    <div class="flex flex-col gap-4">
      <div class="flex justify-end"><CreateCabin /></div>
      <CabinList />
    </div>
  </div>
</template>

<script setup>
// TODO: Add filter
// TODO: Add reservation reminder
import CabinList from "@/features/cabin/CabinList.vue";
import CreateCabin from "@/features/cabin/CreateCabin.vue";
</script>
