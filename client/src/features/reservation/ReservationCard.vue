<template>
  <div class="flex border border-primary-800 rounded-md overflow-hidden">
    <div class="relative flex-1 h-32">
      <img
        :src="imageUrl || DummyCabinImage"
        :alt="`Cabin ${name}`"
        class="border-r border-primary-800 object-cover w-full h-full"
      />
    </div>

    <div class="flex-grow px-6 py-3 flex flex-col">
      <div class="flex items-center justify-between">
        <h3 class="text-xl font-semibold">
          {{ num_dates }} days in Cabin {{ name }}
        </h3>

        <div class="flex gap-2">
          <span
            v-if="status == 'paid'"
            class="bg-green-800 text-green-200 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            {{ status }}
          </span>
          <span
            v-if="isPastReservation"
            class="bg-yellow-800 text-yellow-200 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            past
          </span>

          <span
            v-else
            class="bg-green-800 text-green-200 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            upcoming
          </span>
        </div>
      </div>

      <p class="text-lg text-primary-300">
        {{ format(new Date(start_date), "EEE, MMM dd yyyy") }} (
        {{
          isToday(new Date(start_date))
            ? "Today"
            : formatDistanceFromNow(start_date)
        }}
        ) &mdash; {{ format(new Date(end_date), "EEE, MMM dd yyyy") }}
      </p>

      <div class="flex gap-5 mt-auto items-baseline">
        <p class="text-xl font-semibold text-accent-400">${{ total_price }}</p>
        <p class="text-primary-300">&bull;</p>
        <p class="text-lg text-primary-300">
          {{ num_guests }} guest{{ num_guests > 1 && "s" }}
        </p>
        <p class="ml-auto text-sm text-primary-400">
          Booked {{ format(new Date(created_at), "EEE, MMM dd yyyy, p") }}
        </p>
      </div>
    </div>

    <div class="flex flex-col border-l border-primary-800 w-[100px]">
      <EditReservation v-if="!isPastReservation" :reservation="reservation" />
      <DeleteReservation v-if="!isPastReservation" :reservation="reservation" />
    </div>
  </div>
</template>
<script setup>
import { computed } from "vue";
import { format, formatDistance, isPast, isToday, parseISO } from "date-fns";

import DummyCabinImage from "@/assets/dummy_cabin.jpg";
import DeleteReservation from "./DeleteReservation.vue";
import EditReservation from "./EditReservation.vue";

const { reservation } = defineProps({
  reservation: {
    type: Object,
    required: true,
  },
});

function formatDistanceFromNow(dateStr) {
  return formatDistance(parseISO(dateStr), new Date(), {
    addSuffix: true,
  }).replace("about ", "");
}

const {
  id,
  num_dates,
  num_guests,
  cabin_price,
  extras_price,
  total_price,
  has_breakfast,
  is_paid,
  status,
  observations,
  start_date,
  end_date,
  created_at,
  cabin: { id: cabinId, name, maxCapacity, regularPrice, discount, imageUrl },
} = reservation;

const isPastReservation = computed(() => isPast(new Date(start_date)));
</script>
