import rails from "@/axios/rails";

export async function register(user) {
  const url = "/signup";
  const body = { user };

  const { data } = await rails.post(url, body);
  return data;
}

export async function login(data) {
  const url = "/login";
  const body = { user: { email: data.email, password: data.password } };

  return await rails.post(url, body, {
    metadata: {
      isRememberUser: data.isRememberUser,
    },
  });
}

export async function logout() {
  const url = "/logout";

  const { data } = await rails.delete(url);
  return data;
}
