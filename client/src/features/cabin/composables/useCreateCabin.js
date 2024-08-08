import { StatusCodes, getReasonPhrase } from "http-status-codes";
import { useMutation, useQueryClient } from "@tanstack/vue-query";

import { createCabin as createCabinApi } from "@/services/apiCabins";
import { useToast } from "@/components/toast/useToast";

export function useCreateCabin() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { mutateAsync: createCabin, isPending: isCreating } = useMutation({
    mutationFn: createCabinApi,
    onSuccess: () => {
      showToast("Cabin successfully created");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (err) => {
      const { status } = err;
      if (status == StatusCodes.UNAUTHORIZED) {
        console.error(getReasonPhrase(StatusCodes.UNAUTHORIZED));
      }
    },
  });

  return { isCreating, createCabin };
}
