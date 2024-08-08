import rails from "@/axios/rails";

export async function register(user) {
  const url = "/signup";
  const body = { user };

  const { data } = await rails.post(url, body);
  return data;
}

export async function login(user) {
  const url = "/login";
  const body = { user };

  const { data } = await rails.post(url, body);
  return data;
}
