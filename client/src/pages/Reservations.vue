<template>
  <div class="flex flex-col">
    <div class="flex justify-between align-baseline mb-7">
      <h2 className="font-semibold text-2xl text-accent-400">
        {{ isAdmin ? "Platform Reservations" : "Your reservations" }}
      </h2>
      <div class="flex justify-end gap-4">
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
    </div>
    <div v-if="isAdmin" class="py-2 px-4 bg-accent-600 rounded-sm mb-4">
      As admin, you see all user reservations.
    </div>
    <div v-if="isPending" class="flex flex-grow justify-center items-center">
      <Spinner />
    </div>
    <div v-else>
      <ul className="space-y-6">
        <ReservationCard
          v-for="reservation in reservations.data"
          :key="reservation.id"
          :reservation="reservation"
        />
        <div class="flex justify-center mt-4">
          <Pagination
            v-if="isShowPagination"
            v-model="selectedPage"
            :total="total"
            :itemsPerPage="itemsPerPage"
            :siblingCount="3"
          />
        </div>
      </ul>

      <p v-if="!isPending && !reservations.data.length" className="text-lg">
        You have no reservations yet. Check out our{{ " " }}
        <RouterLink className="underline text-accent-500" to="/cabins">
          luxury cabins &rarr;
        </RouterLink>
      </p>
    </div>
  </div>
</template>
<script setup>
import { ref, watch, computed } from "vue";
import Select from "@/components/StyledSelect.vue";
import Pagination from "@/components/StyledPagination.vue";
import ReservationCard from "@/features/reservation/ReservationCard.vue";
import { useReservations } from "@/features/reservation/composables/useReservations";
import Spinner from "@/components/Spinner.vue";
import { RouterLink } from "vue-router";
import { useAuth } from "@/features/auth/composables/useAuth";
import { useUrlSearchParams } from "@vueuse/core";

const searchParams = useUrlSearchParams("history", {
  initialValue: { status: "all", paid: "all", page: 1 },
});

const { isPending, reservations } = useReservations(searchParams);
const { isAdmin } = useAuth();

const selectedStatus = ref(searchParams?.status || "all");
const selectedPaid = ref(searchParams?.paid || "all");
const selectedPage = ref(parseInt(searchParams?.page) || 1);
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

watch(selectedStatus, (newStatus) => {
  updateSearchTerm("status", newStatus);
  updateSearchTerm("page", 1);
});
watch(selectedPaid, (newPaid) => {
  updateSearchTerm("paid", newPaid);
  updateSearchTerm("page", 1);
});

watch(selectedPage, (newPage) => updateSearchTerm("page", newPage));

watch(searchParams, (newParam) => {
  selectedPage.value = newParam.page;
});

const itemsPerPage = computed(() => reservations.value?.pagy.limit || 1);
const total = computed(() => reservations.value?.pagy.count || 1);

const isShowPagination = computed(
  () => reservations.value?.data.length > 0 && total.value > itemsPerPage.value
);
</script>
