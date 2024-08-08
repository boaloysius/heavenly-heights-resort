import { useMutation } from "@tanstack/vue-query";
import { useRouter } from "vue-router";

import { login as loginApi } from "@/services/apiAuth";
import { useToast } from "@/components/toast/useToast";

export function useLogin() {
  const router = useRouter();
  const { show: showToast } = useToast();

  const { mutateAsync: login, isPending } = useMutation({
    mutationFn: loginApi,
    onSuccess: () => {
      showToast("Login successfull!");
      router.push({ name: "home" });
    },
    onError: (err) => {
      console.error(err);
    },
  });

  return { login, isPending };
}
