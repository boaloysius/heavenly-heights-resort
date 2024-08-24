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
      <li v-if="!isAuthenticated">
        <RouterLink to="/login" class="hover:text-accent-400 transition-colors">
          Login
        </RouterLink>
      </li>
      <li v-if="!isAuthenticated">
        <RouterLink
          to="/register"
          class="hover:text-accent-400 transition-colors"
        >
          Register
        </RouterLink>
      </li>
      <li v-if="isAuthenticated">
        <UserNav />
      </li>
    </ul>
  </nav>
</template>

<script setup>
import { RouterLink } from "vue-router";

import { useAuth } from "@/features/auth/composables/useAuth";
import UserNav from "@/components/UserNav.vue";

const { isAuthenticated } = useAuth();
</script>
