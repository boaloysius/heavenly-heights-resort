<template>
  <RouterLink to="/" class="flex items-center gap-4 z-10">
    <img :src="logo" height="60" width="60" alt="Heavenly Heights logo" />
    <span class="text-xl font-semibold text-primary-100">
      Heavenly Heights
    </span>
  </RouterLink>
</template>

<script setup>
import logo from "@/assets/logo.png";
import { RouterLink } from "vue-router";
</script>
