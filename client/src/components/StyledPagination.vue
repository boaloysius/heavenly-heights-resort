<template>
  <Pagination
    v-model:page="currentPage"
    v-slot="{ page }"
    :total="props.total"
    :itemsPerPage="props.itemsPerPage"
    :sibling-count="props.siblingCount"
  >
    <PaginationList v-slot="{ items }" class="flex items-center gap-1">
      <PaginationFirst
        class="bg-primary-900 hover:bg-accent-600 border-none hover:text-white rounded-xl"
      />
      <PaginationPrev
        class="bg-primary-900 hover:bg-accent-600 border-none hover:text-white rounded-xl"
      />

      <template v-for="(item, index) in items">
        <PaginationListItem
          v-if="item.type === 'page'"
          :key="index"
          :value="item.value"
          as-child
        >
          <!-- item.value === page -->
          <Button
            :class="
              cn('w-9 h-9 p-0 bg-primary-900 hover:bg-accent-600 rounded-xl', {
                'bg-accent-600': item.value === page,
              })
            "
          >
            {{ item.value }}
          </Button>
        </PaginationListItem>
      </template>

      <PaginationNext
        class="bg-primary-900 hover:bg-accent-600 hover:text-white border-none rounded-xl"
      />
      <PaginationLast
        class="bg-primary-900 hover:bg-accent-600 hover:text-white border-none rounded-xl"
      />
    </PaginationList>
  </Pagination>
</template>

<script setup>
import { ref, watch } from "vue";
import {
  Pagination,
  PaginationFirst,
  PaginationLast,
  PaginationList,
  PaginationListItem,
  PaginationNext,
  PaginationPrev,
} from "@/components/ui/pagination";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";

const props = defineProps({
  modelValue: Number,
  total: {
    type: Number,
    required: true,
  },
  itemsPerPage: { type: Number, default: 10 },
  siblingCount: {
    type: Number,
    default: 1,
  },
});

const emit = defineEmits(["update:modelValue"]);
const currentPage = ref(props.modelValue);

watch(currentPage, (newValue) => {
  emit("update:modelValue", newValue);
});

// watch(
//   () => props.modelValue,
//   (newValue) => {
//     currentPage.value = newValue;
//   }
// );
</script>
