<template>
  <router-view />
  <Toast />
</template>

<script setup>
import { RouterView } from "vue-router";
import Toast from "@/components/toast/Toast.vue";
</script>
