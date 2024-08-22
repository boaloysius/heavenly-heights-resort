<template>
  <DropdownMenu>
    <DropdownMenuTrigger as-child>
      <Button variant="ghost" class="relative h-9 w-9 rounded-full">
        <Avatar class="h-8 w-8">
          <AvatarImage :src="profileAvatarURL" :alt="shortName" />
          <AvatarFallback>{{ shortName }}</AvatarFallback>
        </Avatar>
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent
      align="end"
      class="w-56 mt-2 bg-primary-950 text-primary-100 border-primary-800"
    >
      <DropdownMenuLabel class="font-normal flex p-3">
        <div class="flex flex-col space-y-3">
          <p class="text-accent-400 text-md font-medium leading-none">
            {{ user.fullName }} <span>({{ user.role }})</span>
          </p>
          <p class="text-sm leading-none">
            {{ user.email }}
          </p>
        </div>
      </DropdownMenuLabel>
      <DropdownMenuSeparator class="bg-primary-800" />
      <DropdownMenuGroup>
        <DropdownMenuItem
          :as="RouterLink"
          to="/dashboard/profile"
          class="focus:bg-primary-900 focus:text-primary-200 p-3 text-md flex justify-between cursor-pointer"
        >
          <span>Profile</span><UserIcon class="h-5 w-5 text-primary-600" />
        </DropdownMenuItem>
        <DropdownMenuItem
          :as="RouterLink"
          to="/dashboard/reservations"
          class="focus:bg-primary-900 focus:text-primary-200 p-3 text-md flex justify-between cursor-pointer"
        >
          <span>Reservations</span
          ><CalendarDaysIcon class="h-5 w-5 text-primary-600" />
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuItem
        :as="RouterLink"
        to="/logout"
        class="focus:bg-primary-900 focus:text-primary-200 p-3 text-md flex justify-between cursor-pointer"
      >
        <span>Logout</span
        ><ArrowRightEndOnRectangleIcon class="h-5 w-5 text-primary-600" />
      </DropdownMenuItem>
    </DropdownMenuContent>
  </DropdownMenu>
</template>

<script setup>
import { fill } from "@cloudinary/url-gen/actions/resize";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

import { useAuth } from "@/features/auth/composables/useAuth";
import { RouterLink } from "vue-router";
import {
  UserIcon,
  CalendarDaysIcon,
  ArrowRightEndOnRectangleIcon,
} from "@heroicons/vue/24/solid";

import { cld } from "@/components/cloudinary-image";

const { user, shortName } = useAuth();

const profileAvatarURL = cld
  .image(user.value.imagePublicId)
  .resize(fill().width(32).height(32))
  .toURL();
</script>
