<template>Logout page</template>
<script setup>
import { onMounted } from "vue";
import { useLogout } from "@/features/auth/composables/useLogout";

const { logout } = useLogout();

onMounted(() => {
  logout();
});
</script>
