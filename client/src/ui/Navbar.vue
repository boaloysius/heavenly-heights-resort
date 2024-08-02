<template>
  <nav class="z-10 text-xl">
    <ul class="flex gap-16 items-center">
      <li>
        <RouterLink
          to="/cabins"
          class="hover:text-accent-400 transition-colors"
        >
          Cabins
        </RouterLink>
      </li>
      <li>
        <RouterLink to="/about" class="hover:text-accent-400 transition-colors">
          About
        </RouterLink>
      </li>

      <li>
        <RouterLink
          to="/dashboard"
          class="hover:text-accent-400 transition-colors"
        >
          Guest area
        </RouterLink>
      </li>
    </ul>
  </nav>
</template>

<script setup>
import { RouterLink } from "vue-router";
</script>
