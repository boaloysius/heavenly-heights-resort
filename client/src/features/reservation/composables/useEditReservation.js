import { editReservation as editReservationApi } from "@/services/apiReservations";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useEditReservation() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { mutateAsync: editReservation, isPending: isEditing } = useMutation({
    mutationFn: ({ newReservationData, id }) =>
      editReservationApi(newReservationData, id),
    onSuccess: () => {
      showToast("Reservation successfully edited");
      queryClient.invalidateQueries({ queryKey: ["reservations"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });
  return { isEditing, editReservation };
}
