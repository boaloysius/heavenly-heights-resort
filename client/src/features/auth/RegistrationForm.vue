<template>
  <Form
    :validationSchema="registrationFormSchema"
    :initialValues="initialValues"
    :validateOnMount="false"
    :onSubmit="onSubmit"
    class="grid gap-5"
  >
    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ componentField }" name="fullName">
        <FormItem>
          <FormLabel>Name</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="text"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>
    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ componentField }" name="email">
        <FormItem>
          <FormLabel>Email</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="email"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>
    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ componentField }" name="password">
        <FormItem>
          <FormLabel>Password</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="password"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>
    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ componentField }" name="confirmPassword">
        <FormItem>
          <FormLabel>Confirm Password</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="password"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>
    <!-- Hidden submit button -->
    <button type="submit" ref="submitButton" class="hidden">Submit</button>
  </Form>
</template>
<script setup>
import { ref } from "vue";
import { toTypedSchema } from "@vee-validate/zod";
import { z } from "zod";

import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
  Form,
} from "@/components/ui/form";
import Input from "@/components/ui/input/Input.vue";

const { onSubmit } = defineProps({
  onSubmit: {
    type: Function,
    default: () => {},
  },
});

const submitButton = ref(null);

const initialValues = {
  fullName: "Client one",
  email: "client-1@gmail.com",
  password: "Password@123",
  confirmPassword: "Password@123",
};

const registrationFormSchema = toTypedSchema(
  z
    .object({
      fullName: z
        .string()
        .min(3, { message: "Name must be at least 3 characters long." })
        .max(20, { message: "Name must be at most 20 characters long." })
        .regex(/^[a-zA-Z\s]+$/, {
          message: "Name can only contain letters and spaces.",
        }),

      email: z.string().email({ message: "Invalid email address." }),

      password: z
        .string()
        .min(8, { message: "Password must be at least 8 characters long." })
        .regex(/[a-z]/, {
          message: "Password must contain at least one lowercase letter.",
        })
        .regex(/[A-Z]/, {
          message: "Password must contain at least one uppercase letter.",
        })
        .regex(/[0-9]/, {
          message: "Password must contain at least one number.",
        })
        .regex(/[\W_]/, {
          message: "Password must contain at least one special character.",
        }),

      confirmPassword: z.string().min(8, {
        message: "Confirm password must be at least 8 characters long.",
      }),
    })
    .refine((data) => data.password === data.confirmPassword, {
      message: "Passwords do not match.",
      path: ["confirmPassword"],
    })
);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
