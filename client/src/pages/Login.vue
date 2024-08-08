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
      class="fixed left-1/2 top-1/2 z-50 grid w-full shadow-lg -translate-x-1/2 -translate-y-1/2 bg-primary-950 text-primary-100 sm:max-w-sm grid-rows-[auto_minmax(0,1fr)_auto] p-0 max-h-[90dvh] font-josefin border-primary-800"
    >
      <CardHeader class="space-y-1">
        <CardTitle class="text-3xl text-accent-400 font-medium">
          Login
        </CardTitle>
        <CardDescription class="text-md">
          Please enter the credentials.
        </CardDescription>
      </CardHeader>
      <CardContent class="grid gap-5 overflow-y-auto">
        <LoginForm ref="loginForm" :onSubmit="onSubmit" />
      </CardContent>
      <CardFooter class="flex flex-col gap-6 items-start">
        <Button
          class="w-full bg-accent-500 px-4 py-4 text-primary-800 text-md hover:bg-accent-600 transition-all"
          @click="submitForm"
          :disabled="isPending"
        >
          Sign in
        </Button>
        <p>
          Don&#39;t have an account yet?
          <RouterLink
            to="/register"
            class="font-medium text-primary-600 hover:underline"
          >
            Register
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
import background from "@/assets/bg.png";
import LoginForm from "@/features/auth/LoginForm.vue";

import { useLogin } from "@/features/auth/composables/useLogin";

const loginForm = ref(null);

const { isPending, login } = useLogin();

async function onSubmit(values, { setErrors }) {
  try {
    await login(values);
  } catch (err) {
    setErrors(err);
  }
}

function submitForm() {
  loginForm.value.submit();
}
</script>
