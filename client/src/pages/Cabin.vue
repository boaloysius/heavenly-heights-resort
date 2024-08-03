<template>
  <div class="max-w-6xl mx-auto mt-8">
    <Spinner v-if="isPending" />
    <CabinDetails v-else :cabin="cabin" />
  </div>
</template>

<script setup>
import { useQuery } from "@tanstack/vue-query";
import { ref, watch } from "vue";
import { useRoute } from "vue-router";

import { getCabin } from "@/services/apiCabins.js";
import CabinDetails from "@/features/cabin/CabinDetails.vue";
import Spinner from "@/ui/Spinner.vue";

const route = useRoute();
const cabinId = ref(route.params.cabinId);

const { isPending, data: cabin } = useQuery({
  queryKey: ["cabins", cabinId.value],
  queryFn: () => getCabin(cabinId.value),
  retry: false,
});

watch(
  () => route.params.cabinId,
  (newId) => {
    cabinId.value = newId;
  }
);
</script>
