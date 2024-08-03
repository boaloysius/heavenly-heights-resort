import { useMutation, useQueryClient } from "@tanstack/vue-query";

import { deleteCabin as deleteCabinApi } from "@/services/apiCabins.js";

export function useDeleteCabin() {
  const queryClient = useQueryClient();

  const { isLoading: isDeleting, mutate: deleteCabin } = useMutation({
    mutationFn: deleteCabinApi,
    onSuccess: () => {
      alert("Cabin successfully deleted");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (err) => alert(err.message),
  });

  return { isDeleting, deleteCabin };
}
