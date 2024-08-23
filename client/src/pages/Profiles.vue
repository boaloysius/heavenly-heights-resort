<template>
  <div class="flex flex-col">
    <h2 className="font-semibold text-2xl text-accent-400 mb-7">
      Platform users
    </h2>
    <div v-if="isPending" class="flex flex-grow justify-center items-center">
      <Spinner />
    </div>

    <ul className="space-y-6">
      <ProfileCard
        v-for="profile in profiles"
        :key="profile.id"
        :profile="profile"
      />
    </ul>
  </div>
</template>
<script setup>
import ProfileCard from "@/features/profile/ProfileCard.vue";
import { useProfiles } from "@/features/profile/composables/useProfiles";
import Spinner from "@/ui/Spinner.vue";

const { isPending, profiles } = useProfiles();
</script>
