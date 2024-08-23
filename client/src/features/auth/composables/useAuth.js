import { useLocalStorage, useSessionStorage } from "@vueuse/core";
import { computed } from "vue";

export function useAuth() {
  const userStringLS = useLocalStorage("user", null);
  const userStringSS = useSessionStorage("user", null);

  const user = computed(() => {
    if (userStringSS.value) {
      return JSON.parse(userStringSS.value);
    } else if (userStringLS.value) {
      return JSON.parse(userStringLS.value);
    } else {
      return null;
    }
  });

  // Computed property to determine if the user is authenticated
  const isAuthenticated = computed(() => user.value !== null);

  // Computed property to determine if the user is an admin
  const isAdmin = computed(() => user.value.role == "admin");

  const shortName = computed(() => user.value?.fullName.split(" ")[0] || null);

  return {
    user,
    isAuthenticated,
    shortName,
    isAdmin,
  };
}
