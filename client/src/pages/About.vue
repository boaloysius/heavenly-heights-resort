<template>
  <div class="grid grid-cols-5 gap-x-24 gap-y-32 text-lg items-center">
    <div class="col-span-3">
      <h1 class="text-4xl mb-10 text-accent-400 font-medium">
        Welcome to The Heavenly Heights
      </h1>

      <div class="space-y-8">
        <p>
          Where natures beauty and comfortable living blend seamlessly. Hidden
          away in the heart of the Italian Dolomites, this is your paradise away
          from home. But it&apos;s not just about the luxury cabins. It&apos;s
          about the experience of reconnecting with nature and enjoying simple
          pleasures with family.
        </p>
        <p>
          Our {{ numCabins }} luxury cabins provide a cozy base, but the real
          freedom and peace you&apos;ll find in the surrounding mountains.
          Wander through lush forests, breathe in the fresh air, and watch the
          stars twinkle above from the warmth of a campfire or your hot tub.
        </p>
        <p>
          This is where memorable moments are made, surrounded by nature&apos;s
          splendor. It&apos;s a place to slow down, relax, and feel the joy of
          being together in a beautiful setting.
        </p>
      </div>
    </div>

    <div class="col-span-2 relative aspect-square">
      <img
        :src="img1"
        class="object-cover"
        alt="Family sitting around a fire pit in front of cabin"
      />
    </div>

    <div class="col-span-2 relative aspect-square">
      <img
        :src="img2"
        class="object-cover"
        alt="Family that manages The Heavenly Heights"
      />
    </div>

    <div class="col-span-3">
      <h1 class="text-4xl mb-10 text-accent-400 font-medium">
        Managed by our family since 1962
      </h1>

      <div class="space-y-8">
        <p>
          Since 1962, The Heavenly Heights has been a cherished family-run
          retreat. Started by our grandparents, this haven has been nurtured
          with love and care, passing down through our family as a testament to
          our dedication to creating a warm, welcoming environment.
        </p>
        <p>
          Over the years, we&apos;ve maintained the essence of The Heavenly
          Heights, blending the timeless beauty of the mountains with the
          personal touch only a family business can offer. Here, you&apos;re not
          just a guest; you&apos;re part of our extended family. So join us at
          The Heavenly Heights soon, where tradition meets tranquility, and
          every visit is like coming home.
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
import img1 from "@/assets/about-1.jpg";
import img2 from "@/assets/about-2.jpg";

// TODO make numCabins dynamic
const numCabins = 10;
</script>
