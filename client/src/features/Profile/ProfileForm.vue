<template>
  <Form
    :validationSchema="profileFormSchema"
    :initialValues="profile"
    :validateOnMount="false"
    :onSubmit="onSubmit"
    class="grid gap-5"
  >
    <div class="flex flex-col gap-2">
      <FormField v-slot="{ componentField }" name="fullName">
        <FormItem>
          <FormLabel>Full Name</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="text"
              class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:bg-gray-600 disabled:border-0 disabled:text-gray-400"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>

    <div class="flex flex-col gap-2">
      <FormField v-slot="{ componentField }" name="email">
        <FormItem>
          <FormLabel>Email</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="text"
              disabled
              class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>

    <div class="flex flex-col gap-2">
      <FormField v-slot="{ componentField, value }" name="country">
        <FormItem>
          <div className="flex items-center justify-between">
            <FormLabel> Country </FormLabel>
            <img
              :src="countriesMap[value]"
              alt="Country flag"
              className="h-5 rounded-sm"
            />
          </div>
          <Select v-bind="componentField">
            <FormControl>
              <SelectTrigger
                class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100"
              >
                <SelectValue placeholder="Select country" />
              </SelectTrigger>
            </FormControl>
            <SelectContent>
              <SelectGroup>
                <SelectItem
                  v-for="country in countries"
                  :key="country"
                  :value="country"
                >
                  {{ country }}
                </SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>

    <div class="flex flex-col gap-2">
      <FormField v-slot="{ componentField }" name="nationalID">
        <FormItem>
          <FormLabel>National ID</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              type="text"
              class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100"
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
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

import Input from "@/components/ui/input/Input.vue";
import { countries, countriesMap } from "@/lib/utils";

const { onSubmit, profile } = defineProps({
  profile: {
    type: Object,
    required: true,
  },
  onSubmit: {
    type: Function,
    default: () => {},
  },
});

const submitButton = ref(null);

const profileFormSchema = toTypedSchema(
  z.object({
    fullName: z
      .string()
      .min(3, { message: "Name must be at least 3 characters long." })
      .max(20, { message: "Name must be at most 20 characters long." })
      .regex(/^[a-zA-Z\s]+$/, {
        message: "Name can only contain letters and spaces.",
      }),
    email: z.string().email({ message: "Invalid email address." }),
    country: z.string(),
    nationalID: z
      .string()
      .regex(
        /^[a-zA-Z0-9]+$/,
        "National ID must contain only alphanumeric characters"
      ),
  })
);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
