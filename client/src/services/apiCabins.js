const BASE_URL = "http://127.0.0.1:5000";

export async function getCabins() {
  const PATH = "/api/v1/cabins";
  const url = `${BASE_URL}${PATH}`;
  let { data, error } = await fetch(url).then((response) => response.json());

  if (error) {
    console.error(error);
    throw new Error("Cabins could not be loaded");
  }

  return data;
}

export async function getCabin(id) {
  const PATH = `/api/v1/cabins/${id}`;
  const url = `${BASE_URL}${PATH}`;
  let { data, error } = await fetch(url).then((response) => response.json());

  if (error) {
    console.error(error);
    throw new Error("Cabin could not be loaded");
  }

  return data;
}

export async function createEditCabin(newCabin, id) {
  let PATH, method;
  if (!id) {
    PATH = "/api/v1/cabins/";
    method = "POST";
  } else {
    PATH = `/api/v1/cabins/${id}`;
    method = "POST";
  }

  const url = `${BASE_URL}${PATH}`;

  const { data, error } = await fetch(url, {
    method,
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer your-token",
    },
    body: JSON.stringify(newCabin),
  }).then((response) => response.json());

  if (error) {
    throw new Error(error);
  }

  return data;
}

export async function deleteCabin(id) {
  const PATH = `/api/v1/cabins/${id}`;
  const url = `${BASE_URL}${PATH}`;

  let { error } = await fetch(url, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => response.json());

  if (error) {
    console.error(error);
    throw new Error("Cabin could not be deleted");
  }
}
