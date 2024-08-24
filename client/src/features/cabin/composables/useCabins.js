import { useQuery } from "@tanstack/vue-query";
import { getCabins } from "@/services/apiCabins.js";

export function useCabins() {
  const {
    isPending,
    data: cabins,
    error,
  } = useQuery({
    queryKey: ["cabins"],
    queryFn: getCabins,
    staleTime: 300000,
  });

  return { isPending, cabins, error };
}
