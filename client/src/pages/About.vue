<template>
  <div class="grid grid-cols-5 gap-x-24 gap-y-32 text-lg items-center">
    <div class="col-span-5 md:col-span-3">
      <h1 class="text-4xl mb-10 text-accent-400 font-medium">
        Welcome to The Heavenly Heights
      </h1>

      <div class="space-y-8">
        <p>
          Escape to a place where luxury harmonizes with nature. Nestled in the
          picturesque Italian Dolomites, our retreat offers a unique blend of
          comfort and wilderness. This isn’t just a getaway; it’s a chance to
          immerse yourself in the beauty of the natural world and rediscover
          life's simple joys.
        </p>
        <p>
          Our elegantly designed cabins serve as your cozy sanctuary, inviting
          you to relax and rejuvenate. Step outside to explore enchanting forest
          trails, breathe in the fresh mountain air, and marvel at the starry
          night sky from the warmth of a crackling campfire or your private hot
          tub.
        </p>
        <p>
          Here, every day is an adventure, and every evening is a chance to
          unwind in serene surroundings. It’s a place to slow down, reconnect,
          and create unforgettable memories with those who matter most.
        </p>
      </div>
    </div>

    <div class="col-span-5 md:col-span-2 relative aspect-square">
      <CloudinaryImage
        publicId="heavenly-heights/core/common/about-1"
        :attrs="{
          class: 'object-cover',
          alt: 'Family sitting around a fire pit in front of cabin',
          width: '600',
          height: '600',
        }"
      />
    </div>

    <div class="col-span-5 md:col-span-2 relative aspect-square">
      <CloudinaryImage
        publicId="heavenly-heights/core/common/about-2"
        :attrs="{
          class: 'object-cover',
          alt: 'Family that manages The Heavenly Heights',
          width: '600',
          height: '600',
        }"
      />
    </div>

    <div class="col-span-5 md:col-span-3">
      <h1 class="text-4xl mb-10 text-accent-400 font-medium">
        Managed by our family since 1962
      </h1>

      <div class="space-y-8">
        <p>
          Since 1991, The Heavenly Heights has been more than just a
          retreat—it’s been a labor of love passed down through generations.
          Founded by our grandparents, this sanctuary has thrived under the
          tender care of our family, who have poured their hearts into creating
          a place that feels like home.
        </p>
        <p>
          We’ve held onto the magic that makes The Heavenly Heights special,
          combining the timeless allure of the mountains with the warmth and
          charm that only a family-run business can provide. When you stay with
          us, you’re more than a guest; you become part of our story. Visit us
          at The Heavenly Heights, where tradition, peace, and a sense of
          belonging await you.
        </p>

        <div>
          <RouterLink
            to="/cabins"
            class="inline-block mt-4 bg-accent-500 px-8 py-5 text-primary-800 text-lg font-semibold hover:bg-accent-600 transition-all"
          >
            Explore our luxury cabins
          </RouterLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { RouterLink } from "vue-router";
import { CloudinaryImage } from "@/components/cloudinary-image";
</script>
