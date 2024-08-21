<template>
  <div
    class="grid grid-cols-[3fr_4fr] gap-20 border border-primary-800 py-3 px-10 mb-24"
  >
    <div class="relative scale-[1.15] -translate-x-3">
      <CloudinaryImage
        :publicId="imagePublicId"
        :attrs="{
          class: 'object-cover w-full h-full',
          alt: `Cabin ${name}`,
        }"
      />
    </div>

    <div>
      <h3
        class="text-accent-100 font-black text-7xl mb-5 translate-x-[-254px] bg-primary-950 p-6 pb-1 w-[150%]"
      >
        Cabin {{ name }}
      </h3>

      <p class="text-lg text-primary-300 mb-10">
        <TextExpander :text="description" />
      </p>

      <ul class="flex flex-col gap-4 mb-7">
        <li class="flex gap-3 items-center">
          <UsersIcon class="h-5 w-5 text-primary-600" />
          <span class="text-lg">
            For up to
            <span class="font-bold">{{ maxCapacity }}</span> guests
          </span>
        </li>
        <li class="flex gap-3 items-center">
          <MapPinIcon class="h-5 w-5 text-primary-600" />
          <span class="text-lg">
            Located in the heart of the{{ " " }}
            <span class="font-bold">Dolomites</span> (Italy)
          </span>
        </li>
        <li class="flex gap-3 items-center">
          <EyeSlashIcon class="h-5 w-5 text-primary-600" />
          <span class="text-lg">
            Privacy <span class="font-bold">100%</span> guaranteed
          </span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script setup>
import { UsersIcon, EyeSlashIcon, MapPinIcon } from "@heroicons/vue/24/solid";
import { CloudinaryImage } from "@/components/cloudinary-image";
import TextExpander from "@/ui/TextExpander.vue";

const { cabin } = defineProps({
  cabin: {
    type: Object,
    required: true,
  },
});

const {
  id,
  name,
  maxCapacity,
  regularPrice,
  discount,
  imagePublicId,
  description,
} = cabin;
</script>
