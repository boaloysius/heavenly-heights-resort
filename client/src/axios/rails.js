import axios from "axios";

const railsFetch = axios.create({
  baseURL: "http://127.0.0.1:5000",
  timeout: 10000,
  headers: {
    Accept: "application/json",
  },
});

railsFetch.interceptors.response.use(
  (response) => {
    return { ...response.data };
  },
  (error) => {
    if (!error.response) {
      Promise.reject({ error: "Network error", status: 0 });
    }
    return Promise.reject({
      ...error?.response?.data,
      status: error.response.status,
    });
  }
);

export default railsFetch;
