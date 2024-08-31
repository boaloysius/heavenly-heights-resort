import rails from "@/axios/rails";
const PROFILE_PATH = "/api/v1/profile";

export async function getProfile() {
  const url = PROFILE_PATH;
  const { data } = await rails.get(url);
  return data;
}

export async function getProfiles({ filter, page }) {
  const url = `${PROFILE_PATH}/all`;
  const { data, pagy } = await rails.get(url, { params: { ...filter, page } });
  return { data, pagy };
}

export async function editProfile(newProfile) {
  const formData = new FormData();
  formData.append("profile[country]", newProfile.country);
  formData.append("profile[email]", newProfile.email);
  formData.append("profile[fullName]", newProfile.fullName);
  formData.append("profile[nationalID]", newProfile.nationalID);

  if (newProfile.imageFile) {
    formData.append("profile[imageFile]", newProfile.imageFile);
  }

  const url = PROFILE_PATH;

  const { data } = await rails.put(url, formData);
  return data;
}

export async function getAllProfiles() {
  const url = `${PROFILE_PATH}/all`;
  const { data } = await rails.get(url);
  return data;
}

export async function getUserReservations(user_id) {
  const url = `${PROFILE_PATH}/${user_id}/bookings`;
  const { data } = await rails.get(url);
  return data;
}
