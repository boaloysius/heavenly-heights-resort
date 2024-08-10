import rails from "@/axios/rails";
const PROFILE_PATH = "/api/v1/profile";

export async function getProfile() {
  const url = PROFILE_PATH;
  const { data } = await rails.get(url);
  return data;
}

export async function editProfile(newProfile) {
  const url = PROFILE_PATH;
  const body = { profile: newProfile };

  const { data } = await rails.put(url, body);
  return data;
}

export async function getAllProfiles() {
  const url = `${PROFILE_PATH}/all`;
  const { data } = await rails.get(url);
  return data;
}
