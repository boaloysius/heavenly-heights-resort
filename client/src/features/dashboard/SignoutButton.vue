<template>
  <RouterLink
    to="/logout"
    className="py-3 px-5 hover:bg-primary-900 hover:text-primary-100 transition-colors flex items-center gap-4 font-semibold text-primary-200"
  >
    <ArrowRightEndOnRectangleIcon class="h-5 w-5 text-primary-600" />
    <span>Sign out</span>
  </RouterLink>
</template>
<script setup>
import { ArrowRightEndOnRectangleIcon } from "@heroicons/vue/24/solid";
import { RouterLink } from "vue-router";
</script>
