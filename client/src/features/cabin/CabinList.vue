<template>
  <Spinner v-if="isPending" />
  <div
    v-else
    class="grid sm:grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12 xl:gap-14"
  >
    <CabinCard v-for="cabin of cabins" :cabin="cabin" :key="cabin.id" />
  </div>
</template>
<script setup>
import Spinner from "@/ui/Spinner.vue";

import CabinCard from "./CabinCard.vue";
import { useCabins } from "./composables/useCabins";

const { isPending, cabins } = useCabins();
</script>
