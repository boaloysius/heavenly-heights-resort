<template>
  <CloudinaryImage
    publicId="heavenly-heights/core/bg"
    :attrs="{
      class: 'absolute inset-0 w-full object-cover object-top h-full',
      alt: 'Mountains and forests with two cabins',
    }"
  />
  <router-view />
</template>
<script setup>
import { CloudinaryImage } from "@/components/cloudinary-image";
import { RouterView } from "vue-router";
</script>
