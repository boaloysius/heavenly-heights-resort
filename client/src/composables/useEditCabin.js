import { editCabin as editCabinApi } from "@/services/apiCabins";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useEditCabin() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { mutate: editCabin, isPending: isEditing } = useMutation({
    mutationFn: ({ newCabinData, id }) => editCabinApi(newCabinData, id),
    onSuccess: () => {
      showToast("Cabin edited created");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });
  return { isEditing, editCabin };
}
