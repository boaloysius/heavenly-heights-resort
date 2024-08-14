<template>
  <div className="grid bg-primary-800 ">
    <p className="text-center text-xl py-12 self-center">
      Please
      <RouterLink to="/login" className="underline text-accent-500">
        login
      </RouterLink>
      to reserve this <br />
      cabin right now
    </p>
  </div>
</template>
<script setup>
import { RouterLink } from "vue-router";
</script>
