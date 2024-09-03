<template>
  <CloudinaryImage
    publicId="heavenly-heights/core/common/bg-6"
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

<!-- <a href="https://www.freepik.com/free-ai-image/photorealistic-wooden-house-with-timber-structure_152575641.htm#fromView=image_search_similar&page=1&position=6&uuid=f61e9406-1df2-45aa-a574-e8920c40bf08">Image by freepik</a> -->
