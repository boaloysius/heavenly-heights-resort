<template>
  <main class="mt-24">
    <div class="relative z-10 text-center">
      <h1 class="text-8xl text-primary-50 mb-10 tracking-tight font-normal">
        Welcome to paradise.
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
