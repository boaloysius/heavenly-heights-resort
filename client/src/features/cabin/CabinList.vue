<template>
  <Spinner v-if="isPending" />
  <div v-else>
    <div class="mb-4">
      <ToggleGroup
        v-model="selectedFilter"
        type="single"
        class="border border-none gap-2 items-end justify-end"
      >
        <ToggleGroupItem
          v-for="filter of filters"
          class="px-5 py-2 bg-primary-900 rounded-sm text-lg hover:bg-accent-600 hover:text-primary-100 data-[state=on]:bg-accent-600 data-[state=on]:text-primary-100"
          :value="filter.value"
        >
          {{ filter.name }}
        </ToggleGroupItem>
      </ToggleGroup>
    </div>
    <div class="grid sm:grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12 xl:gap-14">
      <CabinCard v-for="cabin of filteredCabins" :cabin="cabin" :key="cabin" />
    </div>
  </div>
</template>
<script setup>
import { ref, computed } from "vue";
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group";

import Spinner from "@/components/Spinner.vue";

import CabinCard from "./CabinCard.vue";
import { useCabins } from "./composables/useCabins";

const selectedFilter = ref("all");
const filters = ref([
  {
    name: "All cabins",
    value: "all",
  },
  {
    name: "1-3 guests",
    value: "1-3",
  },
  {
    name: "4-7 guests",
    value: "4-7",
  },
  {
    name: "8-12 guests",
    value: "8-12",
  },
]);

const filterRanges = {
  "1-3": [1, 3],
  "4-7": [4, 7],
  "8-12": [8, 12],
};

const { isPending, cabins } = useCabins();

const filteredCabins = computed(() => {
  if (!cabins.value) return [];

  if (selectedFilter.value === "all") {
    return cabins.value;
  }

  const range = filterRanges[selectedFilter.value];
  if (range) {
    const [min, max] = range;
    return cabins.value.filter(
      (item) => item.maxCapacity >= min && item.maxCapacity <= max
    );
  }

  return cabins.value;
});
</script>
