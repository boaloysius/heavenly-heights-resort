import { useMutation, useQueryClient } from "@tanstack/vue-query";

import { createReservation as createReservationApi } from "@/services/apiReservations";
import { useToast } from "@/components/toast/useToast";

export function useCreateReservation() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { mutateAsync: createReservation, isPending: isCreating } = useMutation(
    {
      mutationFn: createReservationApi,
      onSuccess: () => {
        showToast("Reservation successfull!");
        queryClient.invalidateQueries({ queryKey: ["reservations"] });
      },
    }
  );

  return { isCreating, createReservation };
}
