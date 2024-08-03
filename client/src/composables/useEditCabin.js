import { useMutation, useQueryClient } from "@tanstack/vue-query";
import { createEditCabin } from "@/services/apiCabins";

export function useEditCabin() {
  const queryClient = useQueryClient();

  const { mutate: editCabin, isPending: isEditing } = useMutation({
    mutationFn: ({ newCabinData, id }) => createEditCabin(newCabinData, id),
    onSuccess: () => {
      console.log("Cabin successfully edited");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (error) => {
      console.error(error.message);
    },
  });
  return { isEditing, editCabin };
}
