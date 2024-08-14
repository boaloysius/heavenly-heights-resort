import { deleteReservation as deleteReservationApi } from "@/services/apiReservations.js";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useDeleteReservation() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { isLoading: isDeleting, mutate: deleteReservation } = useMutation({
    mutationFn: deleteReservationApi,
    onSuccess: () => {
      showToast("Reservation successfully deleted");
      queryClient.invalidateQueries({ queryKey: ["reservations"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });

  return { isDeleting, deleteReservation };
}
