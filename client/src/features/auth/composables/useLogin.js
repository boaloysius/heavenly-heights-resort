import { useMutation } from "@tanstack/vue-query";
import { useRouter } from "vue-router";
import { useLocalStorage, useSessionStorage } from "@vueuse/core";

import { login as loginApi } from "@/services/apiAuth";
import { useToast } from "@/components/toast/useToast";

export function useLogin() {
  const router = useRouter();
  const { show: showToast } = useToast();
  const tokenSS = useSessionStorage("token", null);
  const userSS = useSessionStorage("user", null);
  const tokenLS = useLocalStorage("token", null);
  const userLS = useLocalStorage("user", null);

  tokenLS.value = null;
  userLS.value = null;

  tokenSS.value = null;
  userSS.value = null;

  const { mutateAsync: login, isPending } = useMutation({
    mutationFn: loginApi,
    onSuccess: ({ token: apiToken, data: apiUser, isRememberUser }) => {
      if (!isRememberUser) {
        tokenSS.value = apiToken;
        userSS.value = JSON.stringify(apiUser);
      } else {
        tokenLS.value = apiToken;
        userLS.value = JSON.stringify(apiUser);
      }
      showToast("Login successfull!");
      router.push({ name: "home" });
    },
  });

  return { login, isPending };
}
