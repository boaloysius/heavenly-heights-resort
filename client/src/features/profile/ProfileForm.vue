<template>
  <Form
    :validationSchema="profileFormSchema"
    :initialValues="initialValues"
    :validateOnMount="false"
    :onSubmit="props.onSubmit"
    class="grid gap-5"
    :key="profile"
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
              v-if="value"
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

    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ handleChange }" name="imageFile">
        <FormItem>
          <FormLabel>Profile image</FormLabel>
          <FormControl>
            <Input
              @change="handleChange"
              type="file"
              class="text-md pt-1 text-gray-900 border border-gray-300 rounded-sm cursor-pointer bg-gray-100"
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
import { ref, toRefs, computed } from "vue";
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

const props = defineProps({
  profile: {
    type: Object,
    required: true,
  },
  onSubmit: {
    type: Function,
    default: () => {},
  },
});

const { profile } = toRefs(props);

const submitButton = ref(null);

const initialValues = computed(() => {
  return {
    fullName: profile.value.fullName || undefined,
    nationalID: profile.value.nationalID || undefined,
    country: profile.value.country || undefined,
    email: profile.value.email || undefined,
  };
});

const profileFormSchema = toTypedSchema(
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
      country: z.string(),
      nationalID: z
        .string()
        .regex(
          /^[a-zA-Z0-9]+$/,
          "National ID must contain only alphanumeric characters"
        ),
      imageFile: z.instanceof(File).optional(),
    })
    .refine(
      (data) => {
        if (!data.imageFile) return true;
        return ["image/jpg", "image/jpeg", "image/png", "image/avif"].includes(
          data.imageFile.type
        );
      },
      {
        message:
          "Invalid file type. Only JPG, JPEG, AVIF and PNG images are allowed.",
        path: ["imageFile"],
      }
    )
);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
