import { editProfile as editProfileApi } from "@/services/apiProfile";
import { useToast } from "@/components/toast/useToast";

import { useMutation, useQueryClient } from "@tanstack/vue-query";

export function useEditProfile() {
  const queryClient = useQueryClient();
  const { show: showToast } = useToast();

  const { mutateAsync: editProfile, isPending: isEditing } = useMutation({
    mutationFn: editProfileApi,
    onSuccess: () => {
      showToast("Profile successfully edited");
      queryClient.invalidateQueries({ queryKey: ["profile"] });
    },
    onError: (err) => showToast(err.message, "error"),
  });
  return { isEditing, editProfile };
}
