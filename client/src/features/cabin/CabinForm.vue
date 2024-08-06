<template>
  <Form
    :validationSchema="cabinFormSchema"
    :initialValues="initialValues"
    :validateOnMount="false"
    :onSubmit="onSubmit"
    class="flex flex-col gap-8 py-4 overflow-y-auto px-6"
  >
    <div class="flex flex-col w-full max-w-sm gap-2">
      <FormField v-slot="{ componentField }" name="name">
        <FormItem>
          <FormLabel>Cabin name</FormLabel>
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
    <div class="flex justify-between">
      <FormField v-slot="{ componentField }" name="maxCapacity">
        <FormItem>
          <FormLabel>Maximum Capacity</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              :default-value="0"
              type="number"
              :min="0"
              :max="50"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
      <FormField v-slot="{ componentField }" name="regularPrice">
        <FormItem>
          <FormLabel>Regular Price</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              :default-value="0"
              type="number"
              :min="0"
              :max="50"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
      <FormField v-slot="{ componentField }" name="discount">
        <FormItem>
          <FormLabel>Discount</FormLabel>
          <FormControl>
            <Input
              v-bind="componentField"
              :default-value="0"
              type="number"
              :min="0"
              :max="50"
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none pl-0"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
    </div>
    <div class="grid w-full max-w-[95%] items-center gap-2">
      <FormField v-slot="{ componentField }" name="description">
        <FormItem>
          <FormLabel>Description</FormLabel>
          <FormControl>
            <Textarea
              v-bind="componentField"
              placeholder="Please add the cabin description here."
              class="text-lg text-primary-300 bg-transparent focus-visible:ring-0 border-0 border-b border-primary-800 rounded-none min-h-60 pl-0"
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
import { defineProps, defineExpose, ref } from "vue";
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
  Form,
} from "@/components/ui/form";

import { toTypedSchema } from "@vee-validate/zod";
import { z } from "zod";

import Input from "@/components/ui/input/Input.vue";
import Textarea from "@/components/ui/textarea/Textarea.vue";

const { cabin, onSubmit } = defineProps({
  cabin: {
    type: Object,
    default: () => null,
  },
  onSubmit: {
    type: Function,
    default: () => {},
  },
});

const submitButton = ref(null);

const initialValues = {
  name: cabin?.name || "Boby cabin 1",
  maxCapacity: cabin?.maxCapacity || 10,
  regularPrice: cabin?.regularPrice || 100,
  discount: cabin?.discount || 10,
  description: cabin?.description || "Loremy ipsum setum happy being",
};

const preprocessNumber = (value) => {
  if (typeof value === "string" && value.trim() === "") return undefined;
  return Number(value);
};

const cabinFormSchema = toTypedSchema(
  z
    .object({
      name: z
        .string()
        .min(3, { message: "Name must be at least 3 characters long." })
        .max(20, { message: "Name must be at most 20 characters long." }),

      maxCapacity: z.preprocess(
        preprocessNumber,
        z
          .number()
          .min(1, { message: "Max capacity must be at least 1." })
          .max(99, { message: "Max capacity must be less than 100." })
      ),

      regularPrice: z.preprocess(
        preprocessNumber,
        z.number().nonnegative({
          message: "Regular price must be a non-negative number.",
        })
      ),

      discount: z.preprocess(
        preprocessNumber,
        z
          .number()
          .nonnegative({ message: "Discount must be a non-negative number." })
      ),

      description: z
        .string()
        .min(10, {
          message: "Description must be at least 10 characters long.",
        })
        .max(1000, {
          message: "Description must be at most 1000 characters long.",
        }),
    })
    .refine((data) => data.discount <= data.regularPrice, {
      message: "Discount cannot be more than regular price",
      path: ["discount"],
    })
);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
