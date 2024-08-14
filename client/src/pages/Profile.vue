<template>
  <div v-if="isPending" class="flex flex-grow justify-center items-center">
    <Spinner />
  </div>
  <Card
    v-else
    class="grid w-full shadow-lg bg-primary-900 text-primary-100 grid-rows-[auto_minmax(0,1fr)_auto] p-4 font-josefin border-primary-800"
  >
    <CardHeader class="space-y-1">
      <CardTitle class="text-3xl text-accent-400 font-medium">
        Update your profile
      </CardTitle>
      <CardDescription class="text-md">
        Providing the following information will make your check-in process
        faster and smoother. See you soon!
      </CardDescription>
    </CardHeader>
    <CardContent>
      <ProfileForm ref="profileForm" :profile="profile" :onSubmit="onSubmit" />
    </CardContent>
    <CardFooter class="flex flex-col gap-6 items-end">
      <Button
        @click="submitForm"
        :disabled="isEditing"
        class="bg-accent-500 px-4 py-4 text-primary-800 text-md hover:bg-accent-600 transition-all p-6"
      >
        Update Profile
      </Button>
    </CardFooter>
  </Card>
</template>

<script setup>
import { ref } from "vue";
import {
  Card,
  CardHeader,
  CardContent,
  CardFooter,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";

import ProfileForm from "@/features/profile/ProfileForm.vue";
import Button from "@/components/ui/button/Button.vue";

import { useProfile } from "@/features/profile//composables/useProfile";
import { useEditProfile } from "@/features/profile//composables/useEditProfile";

import { formatErrors } from "@/lib/utils";
import Spinner from "@/ui/Spinner.vue";

const { isPending, profile } = useProfile();
const { isEditing, editProfile } = useEditProfile();

const profileForm = ref(null);

function submitForm() {
  profileForm.value.submit();
}

async function onSubmit(values, { setErrors }) {
  try {
    await editProfile(values);
  } catch (err) {
    err?.errors && setErrors(formatErrors(err.errors));
  }
}
</script>
