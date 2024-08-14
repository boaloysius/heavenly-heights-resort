<template>
  <Form
    :validationSchema="reservationSchema"
    :validateOnMount="false"
    :initialValues="initialValues"
    :onSubmit="onSubmit"
    v-slot="{ values: { has_breakfast } }"
    class="bg-primary-900"
  >
    <div class="flex gap-16 py-8 px-12">
      <div
        className="text-lg flex flex-col flex-grow justify-between space-y-8"
      >
        <div className="max-w-xs">
          <FormField v-slot="{ componentField, value }" name="days">
            <FormItem class="space-y-4 flex flex-col">
              <FormLabel>Please select dates</FormLabel>
              <FormControl class="flex flex-col">
                <DatePicket
                  v-bind="componentField"
                  @update:modelValue="onDatesUpdated"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>
        </div>
        <div className="max-w-xs">
          <FormField v-slot="{ componentField, value }" name="num_guests">
            <FormItem>
              <FormLabel> How many guests? </FormLabel>
              <Select v-bind="componentField">
                <FormControl>
                  <SelectTrigger
                    class="px-5 py-6 text-md bg-primary-200 text-primary-800 w-full shadow-sm rounded-sm disabled:cursor-not-allowed disabled:border-0 disabled:bg-gray-600 disabled:text-gray-100 hover:bg-primary-100 hover:text-primary-800"
                  >
                    <SelectValue placeholder="Select number of guests" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent class="bg-primary-200">
                  <SelectGroup>
                    <SelectItem
                      v-for="x in cabin.maxCapacity"
                      :key="x"
                      :value="`${x}`"
                      class="focus:bg-primary-100"
                    >
                      {{ x }} {{ x === 1 ? "guest" : "guests" }}
                    </SelectItem>
                  </SelectGroup>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          </FormField>
        </div>

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

        <FormField
          v-slot="{ value, handleChange }"
          type="checkbox"
          name="has_breakfast"
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
                Would you opt for breakfast?
              </FormLabel>
            </div>
          </FormItem>
        </FormField>
        <div
          className="flex items-center px-8 bg-accent-300 text-primary-800 h-[72px] w-full"
        >
          <div className="flex items-baseline gap-6 justify-between w-full">
            <div class="flex items-baseline gap-6">
              <p class="flex items-baseline">
                <span
                  v-if="cabin.discount > 0"
                  class="flex gap-2 items-baseline"
                >
                  <span className="text-2xl"
                    >Cabin ${{ cabin.regularPrice - cabin.discount }}</span
                  >
                  <span className="line-through font-semibold text-primary-700">
                    ${{ cabin.regularPrice }}
                  </span>
                </span>

                <span v-else className="text-2xl"
                  >Cabin ${{ cabin.regularPrice }}</span
                >

                <span>/day</span>
              </p>

              <p v-if="has_breakfast" class="flex items-baseline">
                <span class="flex gap-2 items-baseline">
                  <span className="text-2xl"
                    >& Breakfast ${{ booking_contants.BREAKFAST_PRICE }}</span
                  >
                </span>

                <span>/day</span>
              </p>
              <div class="flex items-baseline">
                <p v-if="numDays" className="bg-accent-600 px-3 py-2 text-2xl">
                  <span>&times;</span> <span>{{ numDays }}</span>
                </p>
              </div>
            </div>
            <div v-if="numDays" class="flex items-baseline gap-2">
              <p>
                <span className="text-lg font-bold uppercase">Total</span
                >{{ " " }}
                <span className="text-2xl font-semibold"
                  >${{ totalPrice }}</span
                >
              </p>
            </div>
          </div>
        </div>
        <div className="flex flex-col gap-6">
          <Button
            class="bg-accent-500 px-8 py-6 text-primary-800 text-lg font-semibold hover:bg-accent-600 transition-all"
          >
            Reserve now
          </Button>
        </div>
      </div>
    </div>
  </Form>
</template>

<script setup>
import { ref, computed } from "vue";
import { toTypedSchema } from "@vee-validate/zod";
import { CalendarDate } from "@internationalized/date";
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
import Button from "@/components/ui/button/Button.vue";
import DatePicket from "@/components/ui/date-picket/DatePicket.vue";
import { Checkbox } from "@/components/ui/checkbox";

import booking_contants_json from "./booking_constants.json";

const { onSubmit, cabin } = defineProps({
  onSubmit: {
    type: Function,
    default: () => {},
  },
  cabin: {
    type: Object,
    required: true,
  },
});

const numDays = ref(undefined);

const booking_contants = ref(booking_contants_json);

function onDatesUpdated(range) {
  if (!range.start || !range.end) {
    numDays.value = undefined;
  } else {
    const { start, end } = range;
    numDays.value = end.compare(start) + 1;
  }
}

const preprocessNumber = (value) => {
  if (typeof value === "string" && value.trim() === "") return undefined;
  return Number(value);
};

const dateRangeSchema = z
  .object({
    start: z.instanceof(CalendarDate).optional(),
    end: z.instanceof(CalendarDate).optional(),
  })
  .refine((data) => data.start && data.end, {
    message: "Date is required",
    path: ["days"],
  })
  .refine(
    ({ start, end }) => {
      const numDays = end.compare(start) + 1;
      return numDays >= booking_contants.value.MINIMUM_BOOKING_LENGTH;
    },
    {
      message: `The reservation must be for at least ${booking_contants.value.MINIMUM_BOOKING_LENGTH} days.`,
      path: ["days"],
    }
  )
  .refine(
    ({ start, end }) => {
      const numDays = end.compare(start) + 1;
      return numDays <= booking_contants.value.MAXIMUM_BOOKING_LENGTH;
    },
    {
      message: `The reservation cannot exceed ${booking_contants.value.MAXIMUM_BOOKING_LENGTH} days.`,
      path: ["days"],
    }
  );

const reservationSchema = toTypedSchema(
  z.object({
    observations: z.string().max(500, { message: "Max 500 chars" }).optional(),
    num_guests: z.preprocess(
      preprocessNumber,
      z.number({
        required_error: "Number of guests is required",
        invalid_type_error: "Number of guests is required",
      })
    ),
    days: dateRangeSchema,
    cabin_id: z.string(),
    has_breakfast: z.boolean(),
  })
);

const totalPrice = computed(() => {
  const cabinPrice = cabin.regularPrice - cabin.discount;
  return numDays.value * (cabinPrice + booking_contants.value.BREAKFAST_PRICE);
});

const initialValues = {
  cabin_id: cabin.id,
  has_breakfast: false,
};
</script>
