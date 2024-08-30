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
      <ul className="space-y-6">
        <div class="my-4 flex justify-end gap-4">
          <Select
            v-model="selectedStatus"
            :options="statusOptions"
            placeholder="Select a status"
            label="Status"
            width="160px"
          />
          <Select
            v-model="selectedPaid"
            :options="paidOptions"
            placeholder="Payment"
            label="Payment"
            width="160px"
          />
        </div>
        <ReservationCard
          v-for="reservation in reservations"
          :key="reservation.id"
          :reservation="reservation"
        />
      </ul>

      <p v-if="!isPending && !reservations.length" className="text-lg">
        You have no reservations yet. Check out our{{ " " }}
        <RouterLink className="underline text-accent-500" to="/cabins">
          luxury cabins &rarr;
        </RouterLink>
      </p>
    </div>
  </div>
</template>
<script setup>
import { ref, watch } from "vue";
import Select from "@/components/StyledSelect.vue";
import ReservationCard from "@/features/reservation/ReservationCard.vue";
import { useReservations } from "@/features/reservation/composables/useReservations";
import Spinner from "@/components/Spinner.vue";
import { RouterLink } from "vue-router";
import { useAuth } from "@/features/auth/composables/useAuth";
import { useUrlSearchParams } from "@vueuse/core";

const searchParams = useUrlSearchParams("history", {
  initialValue: { status: "all", paid: "all" },
});

const { isPending, reservations } = useReservations(searchParams);
const { isAdmin } = useAuth();

const selectedStatus = ref(searchParams?.status || "all");
const selectedPaid = ref(searchParams?.paid || "all");
const statusOptions = ref([
  {
    label: "All",
    value: "all",
  },
  {
    label: "Booked",
    value: "booked",
  },
  {
    label: "Confirmed",
    value: "confirmed",
  },
  {
    label: "Checked in",
    value: "checkedin",
  },
  {
    label: "Checked out",
    value: "checkedout",
  },
]);
const paidOptions = ref([
  {
    label: "All",
    value: "all",
  },
  {
    label: "Done",
    value: "true",
  },
  {
    label: "Pending",
    value: "false",
  },
]);

function updateSearchTerm(key, value) {
  searchParams[key] = value;
}

watch(selectedStatus, (newStatus) => updateSearchTerm("status", newStatus));
watch(selectedPaid, (newPaid) => updateSearchTerm("paid", newPaid));
</script>
