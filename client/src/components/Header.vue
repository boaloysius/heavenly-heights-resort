<template>
  <header class="px-8 py-5 z-10">
    <div class="flex justify-between items-center max-w-7xl mx-auto">
      <Logo />
      <Navbar />
    </div>
  </header>
</template>

<script setup>
import Navbar from "@/components/Navbar.vue";
import Logo from "@/components/Logo.vue";
</script>
