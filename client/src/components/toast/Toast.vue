<!-- src/components/toast/Toast.vue -->
<template>
  <div class="toast-container">
    <div
      v-for="toast in toastState.toasts"
      :key="toast.id"
      :class="toastClasses(toast)"
      @click="hide(toast.id)"
    >
      {{ toast.message }}
    </div>
  </div>
</template>

<script setup>
import { useToast } from "@/components/toast/useToast";

const { toastState, hide } = useToast();

const toastClasses = (toast) => [
  "toast",
  {
    "bg-accent-600 text-accent-50": toast.type === "success",
    "bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90":
      toast.type === "error",
  },
];
</script>

<style scoped>
.toast-container {
  position: fixed;
  bottom: 4px;
  right: 4px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.toast {
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: opacity 0.3s;
  margin-bottom: 4px;
  margin-right: 4px;
}
</style>
