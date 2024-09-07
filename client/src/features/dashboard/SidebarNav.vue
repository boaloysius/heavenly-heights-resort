<script setup>
import { CalendarDaysIcon, UserIcon, UsersIcon } from "@heroicons/vue/24/solid";
import { RouterLink, useRoute } from "vue-router";
import SignOutButton from "./SignoutButton.vue";
import { useAuth } from "@/features/auth/composables/useAuth";

const route = useRoute();
const { isAdmin } = useAuth();

const sidebarNavItems = [
  {
    title: "My Profile",
    href: "/dashboard/profile",
    icon: UserIcon,
  },
  {
    title: "Reservations",
    href: "/dashboard/reservations",
    icon: CalendarDaysIcon,
  },
  ...(isAdmin.value
    ? [
        {
          title: "Users",
          href: "/dashboard/users",
          icon: UsersIcon,
        },
      ]
    : []),
];
</script>

<template>
  <nav class="lg:border-r border-primary-900">
    <ul class="flex flex-col gap-2 h-full text-lg">
      <li>
        <RouterLink
          v-for="item in sidebarNavItems"
          :key="item.title"
          :to="item.href"
          class="py-3 px-5 hover:bg-primary-900 hover:text-primary-100 transition-colors flex items-center gap-4 font-semibold text-primary-200"
          active-class="bg-primary-900"
        >
          <component :is="item.icon" class="h-5 w-5 text-primary-600" />
          <span>{{ item.title }}</span>
        </RouterLink>
      </li>
      <li className="mt-auto">
        <SignOutButton />
      </li>
    </ul>
  </nav>
</template>
