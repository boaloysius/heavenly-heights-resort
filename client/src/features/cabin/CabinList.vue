<template>
  <div class="grid sm:grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12 xl:gap-14">
    <CabinCard v-for="cabin of cabins" :cabin="cabin" :key="cabin.id" />
  </div>
</template>
<script setup>
import { ref } from "vue";
import CabinCard from "@/features/cabin/CabinCard.vue";

const cabins = [
  {
    id: "b33e68a9-76cb-4611-a276-70bd5593912d",
    name: "11",
    maxCapacity: 4,
    regularPrice: 200,
    discount: null,
    description: "A lovely cabin",
    imageUrl: null,
  },
  {
    id: "323f421c-c687-4acc-8aa8-995e9dc2055f",
    name: "010",
    maxCapacity: 2,
    regularPrice: 680,
    discount: 20,
    description: "Facere at quia. Ex at mollitia.",
    imageUrl:
      "http://localhost:5000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTAsInB1ciI6ImJsb2JfaWQifX0=--c11f066278e12842184cbf078e1134f7e3b795d4/sample_cabin_image.jpg",
  },
  {
    id: "e9f5066e-4b79-49d0-be6c-11170d052ed3",
    name: "009",
    maxCapacity: 4,
    regularPrice: 1260,
    discount: 17,
    description: "Ad voluptate laborum. Ut labore voluptas.",
    imageUrl: null,
  },
  {
    id: "c21c9003-645b-4032-8c3a-ff57c9316bc6",
    name: "008",
    maxCapacity: 8,
    regularPrice: 2420,
    discount: 40,
    description: "Fugiat distinctio sit. Eius et quis.",
    imageUrl: null,
  },
  {
    id: "4263b5c3-4033-491b-891e-3905a27801e3",
    name: "007",
    maxCapacity: 8,
    regularPrice: 2420,
    discount: 42,
    description: "Dolor magni optio. Aut occaecati quia.",
    imageUrl:
      "http://localhost:5000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NywicHVyIjoiYmxvYl9pZCJ9fQ==--1687bc1866d5c9feb66b11858805737d408d8c7d/sample_cabin_image.jpg",
  },
  {
    id: "1797f78d-4087-4f47-8e53-7b1f86366c29",
    name: "006",
    maxCapacity: 1,
    regularPrice: 390,
    discount: 29,
    description: "Nihil repellendus in. Et autem magni.",
    imageUrl:
      "http://localhost:5000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NiwicHVyIjoiYmxvYl9pZCJ9fQ==--0bcfbf628994c26a0bbe79fd1de9d769c15bbace/sample_cabin_image.jpg",
  },
  {
    id: "cbea5e76-cbbd-46d7-9adc-bfcf1f986460",
    name: "005",
    maxCapacity: 9,
    regularPrice: 2710,
    discount: 15,
    description: "Consequatur alias ratione. Est et neque.",
    imageUrl: null,
  },
  {
    id: "d8f693f9-2823-4818-a99e-25bf9a27acf7",
    name: "004",
    maxCapacity: 8,
    regularPrice: 2420,
    discount: 23,
    description: "Atque deserunt cumque. Ad quasi rerum.",
    imageUrl: null,
  },
  {
    id: "8accc02f-0ad1-47c6-98fa-cdc3290c5a37",
    name: "003",
    maxCapacity: 8,
    regularPrice: 2420,
    discount: 31,
    description: "Dolores dicta reprehenderit. Velit eos doloribus.",
    imageUrl:
      "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MywicHVyIjoiYmxvYl9pZCJ9fQ==--b12640926e8ad3a924803a7d2a46135b6dbb5677/sample_cabin_image.jpg",
  },
  {
    id: "61d9f03a-adc8-4830-b84e-a4df006d187e",
    name: "002",
    maxCapacity: 4,
    regularPrice: 1260,
    discount: 13,
    description: "Quas iste voluptas. Amet perferendis est.",
    imageUrl:
      "http://localhost:5000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MiwicHVyIjoiYmxvYl9pZCJ9fQ==--3b34956d833e095bcde44096b442a5ae62d7f4d2/sample_cabin_image.jpg",
  },
  {
    id: "c0382815-228a-4b7e-9d96-e2d41769332c",
    name: "001",
    maxCapacity: 8,
    regularPrice: 2420,
    discount: 19,
    description: "Vero vel qui. Laudantium earum aut.",
    imageUrl: null,
  },
];

const displayedCabins = ref(cabins);
</script>
