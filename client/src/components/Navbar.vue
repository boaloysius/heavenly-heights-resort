<template>
  <nav className="z-10 text-xl">
    <ul className="flex gap-16 items-center">
      <li>
        <RouterLink
          to="/cabins"
          className="hover:text-accent-400 transition-colors"
        >
          Cabins
        </RouterLink>
      </li>
      <li>
        <RouterLink
          to="/about"
          className="hover:text-accent-400 transition-colors"
        >
          About
        </RouterLink>
      </li>
      <li>
        <RouterLink
          to="/account"
          className="hover:text-accent-400 transition-colors"
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
