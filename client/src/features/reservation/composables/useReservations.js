import { toRefs, computed, watch } from "vue";
import { useQuery, useQueryClient } from "@tanstack/vue-query";
import { getReservations } from "@/services/apiReservations.js";

export function useReservations(searchParams) {
  const queryClient = useQueryClient();
  const { status, paid, page: pageNumber } = toRefs(searchParams);

  // Filter
  const filter = computed(() => {
    const obj = {};
    if (status?.value && status.value !== "all") {
      obj.status = status.value;
    }
    if (paid?.value && paid.value !== "all") {
      obj.is_paid = paid.value;
    }
    return obj;
  });

  // Pagination
  const page = computed(() =>
    !pageNumber?.value ? 1 : Number(pageNumber.value)
  );

  const {
    isPending,
    data: reservations,
    error,
  } = useQuery({
    queryKey: computed(() => ["reservations", filter.value, page.value]),
    queryFn: () => getReservations({ filter: filter.value, page: page.value }),
    staleTime: 300000,
  });

  // Watch for page changes and prefetch next/previous pages if they are stale
  watch([page, reservations], ([newPage, newReservations]) => {
    // Get the total page count from reservations.pagy.pages
    const pageCount = newReservations?.pagy?.pages ?? 1;

    // Prefetch next page if stale
    if (newPage < pageCount) {
      const nextPageQueryKey = ["reservations", filter.value, newPage + 1];
      const nextPageQueryState = queryClient.getQueryState(nextPageQueryKey);

      if (!nextPageQueryState || nextPageQueryState.isStale) {
        queryClient.prefetchQuery({
          queryKey: nextPageQueryKey,
          queryFn: () =>
            getReservations({ filter: filter.value, page: newPage + 1 }),
        });
      }
    }

    // Prefetch previous page if stale
    if (newPage > 1) {
      const prevPageQueryKey = ["reservations", filter.value, newPage - 1];
      const prevPageQueryState = queryClient.getQueryState(prevPageQueryKey);

      if (!prevPageQueryState || prevPageQueryState.isStale) {
        queryClient.prefetchQuery({
          queryKey: prevPageQueryKey,
          queryFn: () =>
            getReservations({ filter: filter.value, page: newPage - 1 }),
        });
      }
    }
  });

  return { isPending, reservations, error };
}
