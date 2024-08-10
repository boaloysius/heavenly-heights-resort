import { useQuery } from "@tanstack/vue-query";
import { getProfile } from "@/services/apiProfile.js";

export function useProfile() {
  const {
    isPending,
    data: profile,
    error,
    isError,
  } = useQuery({
    queryKey: ["profile"],
    queryFn: getProfile,
  });

  return { isPending, profile, error, isError };
}
