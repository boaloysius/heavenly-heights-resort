<template>
  <div class="flex flex-col">
    <div v-if="isPending" class="flex flex-grow justify-center items-center">
      <Spinner />
    </div>
    <div v-else>
      <h2 className="font-semibold text-2xl text-accent-400 mb-7">
        {{ profile.fullName }}'s reservations
      </h2>
      <ul v-if="reservations.length" className="space-y-6">
        <ReservationCard
          v-for="reservation in reservations"
          :key="reservation.id"
          :reservation="reservation"
        />
      </ul>

      <p v-else className="text-lg">No reservation yet!</p>
    </div>
  </div>
</template>
<script setup>
import { useQuery } from "@tanstack/vue-query";
import { useRoute } from "vue-router";
import { ref, watch, computed } from "vue";

import Spinner from "@/ui/Spinner.vue";
import ReservationCard from "@/features/reservation/ReservationCard.vue";
import { getUserReservations } from "@/services/apiProfile.js";

const route = useRoute();
const userId = ref(route.params.userId);

const { isPending, data } = useQuery({
  queryKey: ["profiles", userId.value],
  queryFn: () => getUserReservations(userId.value),
  retry: false,
});

const profile = computed(() => data.value?.profile);
const reservations = computed(() => data.value?.bookings);

watch(
  () => route.params.userId,
  (newId) => {
    userId.value = newId;
  }
);
</script>
