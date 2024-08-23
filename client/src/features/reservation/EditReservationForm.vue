<template>
  <Form
    :validationSchema="reservationSchema"
    :validateOnMount="false"
    :initialValues="initialValues"
    :onSubmit="onSubmit"
    class="flex flex-col overflow-y-auto"
  >
    <div
      className="text-lg flex flex-col flex-grow justify-between space-y-4 px-6"
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

      <div v-if="isAdmin" class="flex w-full gap-2">
        <FormField v-slot="{ componentField }" name="is_paid">
          <FormItem class="grow">
            <FormLabel> Is paid </FormLabel>
            <Select v-bind="componentField">
              <FormControl>
                <SelectTrigger
                  class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100 hover:bg-primary-100 hover:text-primary-800"
                >
                  <SelectValue placeholder="Is paid" />
                </SelectTrigger>
              </FormControl>
              <SelectContent class="bg-primary-200">
                <SelectGroup>
                  <SelectItem value="true" class="focus:bg-primary-100">
                    Yes
                  </SelectItem>
                  <SelectItem value="false" class="focus:bg-primary-100">
                    No
                  </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <FormMessage />
          </FormItem>
        </FormField>

        <FormField v-slot="{ componentField }" name="status">
          <FormItem class="grow">
            <FormLabel> Status </FormLabel>
            <Select v-bind="componentField">
              <FormControl>
                <SelectTrigger
                  class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100 hover:bg-primary-100 hover:text-primary-800"
                >
                  <SelectValue placeholder="Status" />
                </SelectTrigger>
              </FormControl>
              <SelectContent class="bg-primary-200">
                <SelectGroup>
                  <SelectItem value="booked" class="focus:bg-primary-100">
                    Booked
                  </SelectItem>
                  <SelectItem value="confirmed" class="focus:bg-primary-100">
                    Confirmed
                  </SelectItem>
                  <SelectItem value="checkedin" class="focus:bg-primary-100">
                    Checked in
                  </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <FormMessage />
          </FormItem>
        </FormField>
      </div>
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

import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

import Textarea from "@/components/ui/textarea/Textarea.vue";
import { useAuth } from "@/features/auth/composables/useAuth";

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

const { isAdmin } = useAuth();

const { observations } = reservation;

const schemaObject = {
  observations: z.string().max(500, { message: "Max 500 chars" }).optional(),
};

if (isAdmin) {
  schemaObject["is_paid"] = z.string();
  schemaObject["status"] = z.string();
}

const reservationSchema = toTypedSchema(z.object(schemaObject));

const initialValues = {
  observations: observations || "",
};

if (isAdmin) {
  initialValues["is_paid"] = `${reservation.is_paid}`;
  initialValues["status"] = reservation.status;
}

const submitButton = ref(null);

const submit = () => {
  submitButton.value.click();
};

defineExpose({ submit });
</script>
