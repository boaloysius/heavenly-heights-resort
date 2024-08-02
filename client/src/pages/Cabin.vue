<template>
  <div class="max-w-6xl mx-auto mt-8">
    <CabinDetails :cabin="cabin" />
  </div>
</template>

<script setup>
import { ref, watch } from "vue";
import { useRoute } from "vue-router";
import CabinDetails from "@/features/cabin/CabinDetails.vue";

const route = useRoute();
const cabinId = ref(route.params.cabinId);

const cabin = {
  id: "323f421c-c687-4acc-8aa8-995e9dc2055f",
  name: "010",
  maxCapacity: 2,
  regularPrice: 680,
  discount: 20,
  description:
    "Discover the ultimate luxury getaway for couples in the cozy wooden cabin 001. Nestled in a picturesque forest, this stunning cabin offers a secluded and intimate retreat. Inside, enjoy modern high-quality wood interiors, a comfortable seating area, a fireplace and a fully-equipped kitchen. The plush king-size bed, dressed in fine linens guarantees a peaceful nights sleep. Relax in the spa-like shower and unwind on the private deck with hot tub.",
  imageUrl:
    "http://localhost:5000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTAsInB1ciI6ImJsb2JfaWQifX0=--c11f066278e12842184cbf078e1134f7e3b795d4/sample_cabin_image.jpg",
};

watch(
  () => route.params.cabinId,
  (newId) => {
    cabinId.value = newId;
  }
);
</script>
