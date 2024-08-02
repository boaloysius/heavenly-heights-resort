<template>
  <header class="border-b border-primary-900 px-8 py-5">
    <div class="flex justify-between items-center max-w-7xl mx-auto">
      <Logo />
      <Navbar />
    </div>
  </header>
</template>

<script setup>
import Navbar from "@/ui/Navbar.vue";
import Logo from "@/ui/Logo.vue";
</script>
