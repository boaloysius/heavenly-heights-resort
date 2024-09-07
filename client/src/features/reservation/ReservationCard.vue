<template>
  <li
    class="flex flex-col lg:flex-row border border-primary-800 rounded-md overflow-hidden"
  >
    <div class="relative flex-1 h-32">
      <CloudinaryImage
        :publicId="cabin.imagePublicId"
        :attrs="{
          class: 'border-r border-primary-800 object-cover w-full h-full',
          alt: `Cabin ${cabin.name}`,
          height: '400',
          width: '400',
        }"
      />
    </div>

    <div class="flex-grow px-6 py-3 flex flex-col">
      <div class="flex items-center justify-between">
        <h3 class="text-xl font-semibold">
          {{ reservation.num_dates }} days in Cabin {{ cabin.name }}
        </h3>

        <div class="flex gap-2">
          <span
            :class="
              cn(
                'h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm',
                {
                  'bg-green-800 text-green-200': reservation.is_paid,
                  'bg-gray-200 text-gray-800': !reservation.is_paid,
                }
              )
            "
          >
            {{ reservation.is_paid ? "Paid" : "Pending payment" }}
          </span>
          <span
            :class="
              cn(
                'h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm',
                {
                  'bg-gray-200 text-gray-800': reservation.status == 'booked',
                  'bg-green-800 text-green-200':
                    reservation.status == 'confirmed',
                  'bg-yellow-800 text-yellow-200':
                    reservation.status == 'checkedin',
                  'bg-orange-800 text-orange-200':
                    reservation.status == 'checkedout',
                }
              )
            "
          >
            {{ reservation.status }}
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

      <p class="text-lg text-primary-300 mt-2">
        {{ format(new Date(reservation.start_date), "EEE, MMM dd yyyy") }} (
        {{
          isToday(new Date(reservation.start_date))
            ? "Today"
            : formatDistanceFromNow(reservation.start_date)
        }}
        ) &mdash;
        {{ format(new Date(reservation.end_date), "EEE, MMM dd yyyy") }}
      </p>

      <div class="flex gap-5 mt-auto items-baseline">
        <p class="text-xl font-semibold text-accent-400">
          ${{ reservation.total_price }}
        </p>
        <p class="text-primary-300">&bull;</p>
        <p class="text-lg text-primary-300">
          {{ reservation.num_guests }} guest{{
            reservation.num_guests > 1 && "s"
          }}
        </p>
        <p v-if="isAdmin" class="text-primary-300">&bull;</p>
        <p v-if="isAdmin" class="text-lg text-primary-300">{{ displayName }}</p>

        <p class="ml-auto text-sm text-primary-400">
          Booked
          {{ format(new Date(reservation.created_at), "EEE, MMM dd yyyy, p") }}
        </p>
      </div>
    </div>

    <div
      class="p-4 lg:p-0 flex flex-row lg:flex-col border-l border-primary-800 w-[100px]"
    >
      <EditReservation v-if="!isPastReservation" :reservation="reservation" />
      <DeleteReservation v-if="!isPastReservation" :reservation="reservation" />
    </div>
  </li>
</template>
<script setup>
import { computed, toRefs } from "vue";
import { format, formatDistance, isPast, isToday, parseISO } from "date-fns";

import { cn } from "@/lib/utils";
import { CloudinaryImage } from "@/components/cloudinary-image";
import DeleteReservation from "./DeleteReservation.vue";
import EditReservation from "./EditReservation.vue";

const props = defineProps({
  reservation: {
    type: Object,
    required: true,
  },
});

const { reservation } = toRefs(props);

const { cabin, user_profile } = toRefs(reservation.value);

function formatDistanceFromNow(dateStr) {
  return formatDistance(parseISO(dateStr), new Date(), {
    addSuffix: true,
  }).replace("about ", "");
}

import { useAuth } from "@/features/auth/composables/useAuth";

const isPastReservation = computed(() =>
  isPast(new Date(reservation.value.start_date))
);
const displayName = computed(() =>
  user_profile.value.fullName.substring(0, 20)
);

const { isAdmin } = useAuth();
</script>
