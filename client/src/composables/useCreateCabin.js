import { createCabin as createCabinApi } from "@/services/apiCabins";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useCreateCabin() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const {
    mutate: createCabin,
    isPending: isCreating,
    isSuccess,
  } = useMutation({
    mutationFn: createCabinApi,
    onSuccess: () => {
      showToast("Cabin successfully created");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });

  return { isCreating, createCabin, isSuccess };
}
