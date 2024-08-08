import { useMutation } from "@tanstack/vue-query";
import { useRouter } from "vue-router";

import { register as registerApi } from "@/services/apiAuth";
import { useToast } from "@/components/toast/useToast";

export function useRegistration() {
  const router = useRouter();
  const { show: showToast } = useToast();

  const { mutateAsync: register, isPending } = useMutation({
    mutationFn: registerApi,
    onSuccess: () => {
      showToast("Registration successfull!");
      router.push({ name: "login" });
    },
    onError: (err) => {
      console.error(err);
    },
  });

  return { register, isPending };
}
