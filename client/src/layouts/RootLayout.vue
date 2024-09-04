<template>
  <div
    class="antialiased bg-primary-950 text-primary-100 min-h-screen font-josefin flex flex-col relative"
  >
    <Header />
    <div class="flex-1 px-8 py-12 grid">
      <div class="max-w-7xl mx-auto w-full">
        <router-view />
      </div>
    </div>
    <!-- <div
      class="fixed bottom-0 z-10 p-2 w-full bg-accent-600 flex justify-center"
    >
      The website API is hosted on Render's free version, which may cause up to
      a 50-second delay during the initial load.
    </div> -->
  </div>
</template>

<script setup>
import Header from "@/components/Header.vue";
import { RouterView } from "vue-router";
</script>
