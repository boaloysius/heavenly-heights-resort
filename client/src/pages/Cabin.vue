<template>
  <div class="max-w-6xl mx-auto mt-8">
    <Spinner v-if="isPending" />
    <CabinDetails v-else :cabin="cabin" />
    <div>
      <h2 className="text-5xl font-semibold text-center mb-10 text-accent-400">
        Reserve {{ cabin.name }} today. Pay on arrival.
      </h2>
      <CreateReservation :cabin="cabin" />
    </div>
  </div>
</template>

<script setup>
import { useQuery } from "@tanstack/vue-query";
import { ref, watch } from "vue";
import { useRoute } from "vue-router";

import { getCabin } from "@/services/apiCabins.js";
import CabinDetails from "@/features/cabin/CabinDetails.vue";
import Spinner from "@/components/Spinner.vue";
import CreateReservation from "@/features/reservation/CreateReservation.vue";

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
