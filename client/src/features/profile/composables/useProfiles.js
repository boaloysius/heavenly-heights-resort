import { toRefs, computed, watch } from "vue";
import { useQuery, useQueryClient } from "@tanstack/vue-query";
import { getProfiles } from "@/services/apiProfile.js";

export function useProfiles(searchParams) {
  const queryClient = useQueryClient();
  const { role, page: pageNumber } = toRefs(searchParams);

  // Filters
  const filter = computed(() => {
    const obj = {};
    if (role?.value && role.value !== "all") {
      obj.role = role.value;
    }
    return obj;
  });

  // Pagination
  const page = computed(() =>
    !pageNumber?.value ? 1 : Number(pageNumber.value)
  );

  const {
    isPending,
    data: profiles,
    error,
  } = useQuery({
    queryKey: computed(() => ["profile", filter.value, page.value]),
    queryFn: () => getProfiles({ filter: filter.value, page: page.value }),
    staleTime: 300000,
  });

  // Watch for page changes and prefetch next/previous pages if they are stale
  watch([page, profiles], ([newPage, newProfiles]) => {
    // Get the total page count from profiles.pagy.pages
    const pageCount = newProfiles?.pagy?.pages ?? 1;

    // Prefetch next page if stale
    if (newPage < pageCount) {
      const nextPageQueryKey = ["profile", filter.value, newPage + 1];
      const nextPageQueryState = queryClient.getQueryState(nextPageQueryKey);

      if (!nextPageQueryState || nextPageQueryState.isStale) {
        queryClient.prefetchQuery({
          queryKey: nextPageQueryKey,
          queryFn: () =>
            getProfiles({ filter: filter.value, page: newPage + 1 }),
        });
      }
    }

    // Prefetch previous page if stale
    if (newPage > 1) {
      const prevPageQueryKey = ["profile", filter.value, newPage - 1];
      const prevPageQueryState = queryClient.getQueryState(prevPageQueryKey);

      if (!prevPageQueryState || prevPageQueryState.isStale) {
        queryClient.prefetchQuery({
          queryKey: prevPageQueryKey,
          queryFn: () =>
            getProfiles({ filter: filter.value, page: newPage - 1 }),
        });
      }
    }
  });

  return { isPending, profiles, error };
}
