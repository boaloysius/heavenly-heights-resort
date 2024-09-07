<template>
  <main class="mt-48">
    <div class="relative z-10 flex flex-col justify-center items-center">
      <h1
        class="text-5xl md:text-8xl text-primary-50 bg-primary-900 bg-opacity-30 mb-10 tracking-tight font-normal p-4"
      >
        Heavenly heights
      </h1>
      <RouterLink
        to="/cabins"
        class="bg-accent-500 px-8 py-6 text-primary-800 text-lg font-semibold hover:bg-accent-600 transition-all"
      >
        Explore luxury cabins
      </RouterLink>
    </div>
  </main>
</template>

<script setup>
import { RouterLink } from "vue-router";
</script>
