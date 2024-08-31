<template>
  <div class="flex flex-col">
    <div class="flex justify-between">
      <h2 className="font-semibold text-2xl text-accent-400 mb-7">
        Platform users
      </h2>
      <Select
        v-model="selectedRole"
        :options="roleOptions"
        placeholder="Select a role"
        label="Role"
        width="160px"
      />
    </div>
    <div v-if="isPending" class="flex flex-grow justify-center items-center">
      <Spinner />
    </div>

    <ul className="space-y-6">
      <ProfileCard
        v-for="profile in profiles.data"
        :key="profile.id"
        :profile="profile"
      />
      <div class="flex justify-center mt-4">
        <Pagination
          v-if="isShowPagination"
          v-model="selectedPage"
          :total="total"
          :itemsPerPage="itemsPerPage"
          :siblingCount="3"
        />
      </div>
    </ul>
  </div>
</template>
<script setup>
import { ref, watch, computed } from "vue";
import Select from "@/components/StyledSelect.vue";
import Pagination from "@/components/StyledPagination.vue";
import ProfileCard from "@/features/profile/ProfileCard.vue";
import { useProfiles } from "@/features/profile/composables/useProfiles";
import Spinner from "@/components/Spinner.vue";
import { useUrlSearchParams } from "@vueuse/core";

const searchParams = useUrlSearchParams("history", {
  initialValue: { role: "client", page: 1 },
});

console.log(searchParams);

const { isPending, profiles } = useProfiles(searchParams);

const selectedRole = ref(searchParams?.role || "all");
const selectedPage = ref(parseInt(searchParams?.page) || 1);

const roleOptions = ref([
  {
    label: "All",
    value: "all",
  },
  {
    label: "Admin",
    value: "admin",
  },
  {
    label: "Client",
    value: "client",
  },
]);

function updateSearchTerm(key, value) {
  searchParams[key] = value;
}

watch(selectedRole, (newRole) => {
  updateSearchTerm("role", newRole);
  updateSearchTerm("page", 1);
});

watch(selectedPage, (newPage) => updateSearchTerm("page", newPage));

watch(searchParams, (newParam) => {
  selectedPage.value = newParam.page;
});

const itemsPerPage = computed(() => profiles.value?.pagy.limit || 1);
const total = computed(() => profiles.value?.pagy.count || 1);

const isShowPagination = computed(
  () => profiles.value?.data.length > 0 && total.value > itemsPerPage.value
);
</script>
