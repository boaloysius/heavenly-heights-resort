import { watch, toRefs, computed } from "vue";
import { useQuery } from "@tanstack/vue-query";
import { getReservations } from "@/services/apiReservations.js";

export function useReservations(searchParams) {
  const { status, paid } = toRefs(searchParams);

  const filter = computed(() => {
    const obj = {};
    if (status.value && status.value != "all") {
      obj.status = status.value;
    }
    if (paid.value && paid.value != "all") {
      obj.is_paid = paid.value;
    }
    return obj;
  });

  watch(filter, (newFilter) => console.log(newFilter));

  const {
    isPending,
    data: reservations,
    error,
  } = useQuery({
    queryKey: ["reservations", filter],
    queryFn: () => getReservations({ filter: filter.value }),
  });

  return { isPending, reservations, error };
}
