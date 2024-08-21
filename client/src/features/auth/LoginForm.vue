<template>
  <Form
    :validationSchema="loginFormSchema"
    :initialValues="initialValues"
    :validateOnMount="false"
    :onSubmit="onSubmit"
    class="grid gap-5"
  >
    <div>
      <FormField name="error">
        <FormItem>
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
    <div>
      <FormField
        v-slot="{ value, handleChange }"
        type="checkbox"
        name="isRememberUser"
      >
        <FormItem>
          <div class="flex space-x-2 items-end space-y-0">
            <FormControl>
              <Checkbox
                :checked="value"
                @update:checked="handleChange"
                class="border-white"
              />
            </FormControl>
            <FormLabel
              class="leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 space-y-0"
            >
              Remember me
            </FormLabel>
          </div>
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
import { Checkbox } from "@/components/ui/checkbox";

const { onSubmit } = defineProps({
  onSubmit: {
    type: Function,
    default: () => {},
  },
});

const submitButton = ref(null);

const initialValues = {
  email: "client-1@gmail.com",
  password: "Password@123",
  isRememberUser: false,
};

const loginFormSchema = toTypedSchema(
  z.object({
    email: z.string().email({ message: "Invalid email address." }),
    password: z.string(),
    isRememberUser: z.boolean(),
  })
);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
