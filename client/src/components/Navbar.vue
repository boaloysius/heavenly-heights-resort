<template>
  <nav class="z-10 text-xl">
    <ul class="flex gap-4 items-center">
      <li>
        <RouterLink to="/about" :class="linkClass('/about')">
          About
        </RouterLink>
      </li>
      <li>
        <RouterLink to="/cabins" :class="linkClass('/cabins')">
          Cabins
        </RouterLink>
      </li>
      <li v-if="!isAuthenticated">
        <RouterLink to="/login" :class="linkClass('/login')">
          Login
        </RouterLink>
      </li>
      <li v-if="!isAuthenticated">
        <RouterLink to="/register" :class="linkClass('/register')">
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
import { RouterLink, useRoute } from "vue-router";
import { computed } from "vue";
import { cn } from "@/lib/utils";

import { useAuth } from "@/features/auth/composables/useAuth";
import UserNav from "@/components/UserNav.vue";

const { isAuthenticated } = useAuth();
const route = useRoute();

const linkClass = (path) => {
  return computed(() =>
    cn(
      "p-4 hover:text-accent-400 transition-colors", // Common classes
      {
        "bg-primary-900 bg-opacity-90 hover:bg-opacity-100": [
          "/",
          "/login",
          "/register",
        ].includes(route.path),
      }
    )
  ).value;
};
</script>
