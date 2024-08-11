import axios from "axios";
import { StatusCodes } from "http-status-codes";

const railsFetch = axios.create({
  baseURL: "http://127.0.0.1:5000",
  timeout: 10000,
  headers: {
    Accept: "application/json",
  },
});

railsFetch.interceptors.request.use((config) => {
  const token =
    sessionStorage.getItem("token") || localStorage.getItem("token");
  if (config.url != "/login" && token) {
    config.headers.Authorization = token;
  }
  return config;
});

railsFetch.interceptors.response.use(
  (response) => {
    const { data, config } = response;
    if (config.url == "/login") {
      const { isRememberUser } = response?.config?.metadata;
      return {
        token: response.headers["authorization"],
        ...data,
        isRememberUser,
      };
    }
    return { ...data };
  },
  (error) => {
    if (!error.response) {
      Promise.reject({ error: "Network error", status: 0 });
    }
    if (
      error?.response?.config?.url == "/logout" &&
      error?.response?.status == StatusCodes.UNAUTHORIZED
    ) {
      return {};
    }
    return Promise.reject({
      ...error?.response?.data,
      status: error.response.status,
    });
  }
);

export default railsFetch;
