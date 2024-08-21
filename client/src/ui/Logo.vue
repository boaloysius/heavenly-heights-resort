<template>
  <RouterLink to="/" class="flex items-center gap-4 z-10">
    <CloudinaryImage
      publicId="heavenly-heights/core/logo"
      :attrs="{
        class: 'object-cover',
        alt: 'Logo',
        height: '60',
        width: '60',
      }"
    />
    <span class="text-xl font-semibold text-primary-100">
      Heavenly Heights
    </span>
  </RouterLink>
</template>

<script setup>
import { CloudinaryImage } from "@/components/cloudinary-image";
import { RouterLink } from "vue-router";
</script>
