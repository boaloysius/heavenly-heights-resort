import { useMutation, useQueryClient } from "@tanstack/vue-query";
import { createEditCabin } from "@/services/apiCabins";

export function useCreateCabin() {
  const queryClient = useQueryClient();
  const { mutate: createCabin, isPending: isCreating } = useMutation({
    mutationFn: createEditCabin,
    onSuccess: () => {
      console.log("New cabin successfully created");
      queryClient.invalidateQueries({ queryKey: ["cabins"] });
    },
    onError: (error) => {
      console.error(error.message);
    },
  });

  return { isCreating, createCabin };
}
