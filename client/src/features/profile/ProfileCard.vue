<template>
  <li
    class="flex flex-col lg:flex-row border border-primary-800 rounded-md overflow-hidden"
  >
    <div class="relative flex h-32">
      <CloudinaryImage
        :key="profile.imagePublicId"
        :publicId="profile.imagePublicId"
        :attrs="{
          class: 'border-r border-primary-800 object-cover w-full h-full',
          alt: `User ${profile.fullName}`,
          height: '400',
          width: '400',
        }"
      />
    </div>
    <div class="flex-grow px-6 py-3 flex flex-col">
      <div class="flex items-center justify-between">
        <h3 class="text-xl font-semibold">
          {{ profile.fullName }}
        </h3>
        <div class="flex gap-2">
          <span
            v-if="isAdminProfile"
            class="bg-red-800 text-red-200 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            Admin
          </span>
          <span
            v-if="profile.profile_complete"
            class="bg-green-800 text-green-200 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            Profile complete
          </span>
          <span
            v-else
            class="bg-gray-200 text-gray-800 h-7 px-3 uppercase text-xs font-bold flex items-center rounded-sm"
          >
            Profile incomplete
          </span>
        </div>
      </div>

      <p class="text-lg text-primary-300">
        {{ profile.email }}
      </p>

      <div class="flex flex-col lg:flex-row gap-5 mt-auto items-start">
        <p v-if="profile.country" class="text-xl font-semibold text-accent-400">
          {{ profile.country }}
        </p>
        <p class="text-primary-300 hidden lg:block">&bull;</p>

        <img
          v-if="profile.country"
          :src="profile.countryFlag"
          alt="Country flag"
          className="h-5 rounded-sm"
        />

        <p v-if="profile.nationalID" class="text-primary-300 hidden lg:block">
          &bull;
        </p>
        <p v-if="profile.nationalID" class="text-lg text-primary-300">
          {{ profile.nationalID }}
        </p>

        <p class="ml-auto text-sm text-primary-400">
          Created
          {{ format(new Date(profile.created_at), "EEE, MMM dd yyyy, p") }}
        </p>
      </div>
    </div>
    <div
      class="p-4 lg:p-0 flex border-l border-primary-800 lg:w-[120px] justify-center items-center underline underline-offset-4"
    >
      <RouterLink
        v-if="!isAdminProfile"
        :to="`/dashboard/users/${profile.user_id}/bookings`"
        class="text-gray-400 hover:text-gray-200 text-center"
        >View reservations</RouterLink
      >
    </div>
  </li>
</template>

<script setup>
import { computed, toRefs } from "vue";
import { RouterLink } from "vue-router";
import { format } from "date-fns";
import { CloudinaryImage } from "@/components/cloudinary-image";

const props = defineProps({
  profile: {
    type: Object,
    required: true,
  },
});

const { profile } = toRefs(props);

const isAdminProfile = computed(() => profile.value.role === "admin");
</script>
