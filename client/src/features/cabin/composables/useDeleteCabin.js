import { deleteCabin as deleteCabinApi } from "@/services/apiCabins.js";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useDeleteCabin() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { isLoading: isDeleting, mutate: deleteCabin } = useMutation({
    mutationFn: deleteCabinApi,
    onSuccess: () => {
      showToast("Cabin successfully deleted");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });

  return { isDeleting, deleteCabin };
}
