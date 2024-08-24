import { useMutation, useQueryClient } from "@tanstack/vue-query";
import { useRouter } from "vue-router";
import { useLocalStorage, useSessionStorage } from "@vueuse/core";

import { logout as logoutApi } from "@/services/apiAuth";
import { useToast } from "@/components/toast/useToast";

export function useLogout() {
  const queryClient = useQueryClient();
  const router = useRouter();
  const { show: showToast } = useToast();
  const tokenLS = useLocalStorage("token", null);
  const userLS = useLocalStorage("user", null);
  const tokenSS = useSessionStorage("token", null);
  const userSS = useSessionStorage("user", null);

  const { mutateAsync: logout, isPending } = useMutation({
    mutationFn: logoutApi,
    onSuccess: () => {
      showToast("Logout successfull!");
      queryClient.invalidateQueries();
    },
    onSettled: () => {
      tokenLS.value = null;
      userLS.value = null;
      tokenSS.value = null;
      userSS.value = null;
      router.push({ name: "login" });
    },
  });

  return { logout, isPending };
}
