<template>
  <div>
    <img
      :src="background"
      class="absolute inset-0 w-full object-cover object-top h-full"
      alt="Mountains and forests with two cabins"
    />
    <div
      data-state="open"
      class="fixed inset-0 bg-black/30"
      data-aria-hidden="true"
      aria-hidden="true"
    />

    <Card
      class="fixed left-1/2 top-1/2 z-50 grid w-full shadow-lg -translate-x-1/2 -translate-y-1/2 bg-primary-950 text-primary-100 sm:max-w-md grid-rows-[auto_minmax(0,1fr)_auto] p-0 max-h-[90dvh] font-josefin border-primary-800"
    >
      <CardHeader class="space-y-1">
        <CardTitle class="text-3xl text-accent-400 font-medium">
          Create an account
        </CardTitle>
        <CardDescription class="text-md">
          Enter the details to create your account.
        </CardDescription>
      </CardHeader>
      <CardContent class="overflow-y-auto">
        <RegistrationForm ref="registrationForm" :onSubmit="onSubmit" />
      </CardContent>
      <CardFooter class="flex flex-col gap-6 items-start">
        <Button
          @click="submitForm"
          :disabled="isPending"
          class="w-full bg-accent-500 px-4 py-4 text-primary-800 text-md hover:bg-accent-600 transition-all"
        >
          Sign up
        </Button>
        <p>
          Already have an account?
          <RouterLink
            to="/login"
            class="font-medium text-primary-600 hover:underline"
          >
            Login here
          </RouterLink>
        </p>
      </CardFooter>
    </Card>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";

import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

import RegistrationForm from "@/features/auth/RegistrationForm.vue";
import background from "@/assets/bg.png";

import { formatAuthErrors } from "@/lib/utils";

import { useRegistration } from "@/features/auth/composables/useRegistration";

const registrationForm = ref(null);

const { isPending, register } = useRegistration();

async function onSubmit(values, { setErrors }) {
  try {
    await register({
      email: values.email,
      password: values.password,
      profile_attributes: { fullName: values.fullName },
    });
  } catch (err) {
    const formatedErrors = formatAuthErrors(err.errors);
    console.log(formatedErrors);
    err?.errors && setErrors(formatedErrors);
  }
}

function submitForm() {
  registrationForm.value.submit();
}
</script>
