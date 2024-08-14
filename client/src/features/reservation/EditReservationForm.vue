<template>
  <Form
    :validationSchema="reservationSchema"
    :validateOnMount="false"
    :initialValues="initialValues"
    :onSubmit="onSubmit"
    class="flex flex-col overflow-y-auto"
  >
    <div
      className="text-lg flex flex-col flex-grow justify-between space-y-8 px-6"
    >
      <FormField v-slot="{ componentField }" name="observations">
        <FormItem className="flex flex-col space-y-4 grow">
          <FormLabel>Anything we should know about your stay?</FormLabel>
          <FormControl>
            <Textarea
              v-bind="componentField"
              placeholder="Any pets, allergies, special requirements, etc.?"
              class="px-5 py-3 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm grow min-h-64"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>

      <!-- Hidden submit button -->
      <button type="submit" ref="submitButton" class="hidden">Submit</button>
    </div>
  </Form>
</template>

<script setup>
import { ref } from "vue";
import { toTypedSchema } from "@vee-validate/zod";
import { z } from "zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";

import Textarea from "@/components/ui/textarea/Textarea.vue";

const { onSubmit, reservation } = defineProps({
  onSubmit: {
    type: Function,
    default: () => {},
  },
  reservation: {
    type: Object,
    required: true,
  },
});

const { observations } = reservation;

const reservationSchema = toTypedSchema(
  z.object({
    observations: z.string().max(500, { message: "Max 500 chars" }).optional(),
  })
);

const submitButton = ref(null);

const initialValues = {
  observations: observations || "",
};

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
