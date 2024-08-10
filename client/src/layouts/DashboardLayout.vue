<template>
  <div className="grid grid-cols-[16rem_1fr] h-full gap-12">
    <SidebarNav />
    <RouterView />
  </div>
</template>
<script setup>
import { RouterView } from "vue-router";
import SidebarNav from "@/features/dashboard/SidebarNav.vue";
</script>
