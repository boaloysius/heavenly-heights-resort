<template>
  <RouterLink to="/" class="flex items-center gap-4 z-10">
    <div class="border-transparent rounded-full overflow-hidden h-16 w-16">
      <CloudinaryImage
        publicId="heavenly-heights/core/logo-5"
        :attrs="{
          class: 'object-cover',
          alt: 'Logo',
          height: '400',
          width: '400',
        }"
      />
    </div>
  </RouterLink>
</template>

<script setup>
import { CloudinaryImage } from "@/components/cloudinary-image";
import { RouterLink } from "vue-router";
</script>
