<template>
  <div class="flex flex-col">
    <h2 className="font-semibold text-2xl text-accent-400 mb-7">
      Your reservations
    </h2>
    <div v-if="isAdmin" class="py-2 px-4 bg-accent-600 rounded-sm mb-4">
      As admin, you see all user reservations.
    </div>
    <div v-if="isPending" class="flex flex-grow justify-center items-center">
      <Spinner />
    </div>
    <div v-else>
      <ul v-if="reservations.length" className="space-y-6">
        <ReservationCard
          v-for="reservation in reservations"
          :key="reservation.id"
          :reservation="reservation"
        />
      </ul>

      <p v-else className="text-lg">
        You have no reservations yet. Check out our{{ " " }}
        <RouterLink className="underline text-accent-500" to="/cabins">
          luxury cabins &rarr;
        </RouterLink>
      </p>
    </div>
  </div>
</template>
<script setup>
import ReservationCard from "@/features/reservation/ReservationCard.vue";
import { useReservations } from "@/features/reservation/composables/useReservations";
import Spinner from "@/ui/Spinner.vue";
import { RouterLink } from "vue-router";
import { useAuth } from "@/features/auth/composables/useAuth";

const { isPending, reservations } = useReservations();
const { isAdmin } = useAuth();
</script>
