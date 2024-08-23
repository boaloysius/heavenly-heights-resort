<template>
  <div class="border border-primary-800 rounded w-full">
    <div
      v-if="isAuthenticated"
      className="flex flex-col text-primary-300 justify-end items-center"
    >
      <div
        class="w-full flex justify-end gap-4 px-12 py-2 items-center bg-primary-800"
      >
        <p>Logged in as</p>
        <div className="flex gap-4 items-center">
          <Avatar class="h-8 w-8">
            <AvatarImage :src="profileAvatarURL" :alt="shortName" />
            <AvatarFallback>{{ shortName }}</AvatarFallback>
          </Avatar>
          <p>{{ user.fullName }}</p>
        </div>
      </div>

      <ReservationForm :onSubmit="onSubmit" :cabin="cabin" class="w-full" />
    </div>
    <LoginMessage v-else />
  </div>
</template>

<script setup>
import { useRouter } from "vue-router";
import { fill } from "@cloudinary/url-gen/actions/resize";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import LoginMessage from "@/components/LoginMessage.vue";
import ReservationForm from "./ReservationForm.vue";

import { useAuth } from "../auth/composables/useAuth";
import { useCreateReservation } from "./composables/useCreateReservation";
import { formatErrors } from "@/lib/utils";
import { cld } from "@/components/cloudinary-image";

const { cabin } = defineProps({
  cabin: {
    type: Object,
    required: true,
  },
});

const { user, shortName, isAuthenticated } = useAuth();
const { createReservation } = useCreateReservation();
const router = useRouter();

async function onSubmit(values, { setErrors }) {
  try {
    const { days, ...otherValues } = values;
    const newReservation = {
      ...otherValues,
      start_date: days.start.toString(),
      end_date: days.end.toString(),
    };
    await createReservation(newReservation);
    router.push({ name: "reservations" });
  } catch (err) {
    console.log(err);
    err?.errors && setErrors(formatErrors(err.errors));
  }
}

const profileAvatarURL = cld
  .image(user.value.imagePublicId)
  .resize(fill().width(32).height(32))
  .toURL();
</script>
