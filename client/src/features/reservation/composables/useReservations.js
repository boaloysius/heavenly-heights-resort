import { useQuery } from "@tanstack/vue-query";
import { getReservations } from "@/services/apiReservations.js";

export function useReservations() {
  const {
    isPending,
    data: reservations,
    error,
  } = useQuery({
    queryKey: ["reservations"],
    queryFn: getReservations,
  });

  return { isPending, reservations, error };
}
