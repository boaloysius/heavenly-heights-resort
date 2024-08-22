import { useQuery } from "@tanstack/vue-query";
import { getProfiles } from "@/services/apiProfile.js";

export function useProfiles() {
  const {
    isPending,
    data: profiles,
    error,
  } = useQuery({
    queryKey: ["profile"],
    queryFn: getProfiles,
  });

  return { isPending, profiles, error };
}
