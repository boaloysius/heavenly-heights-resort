const BASE_URL = "http://127.0.0.1:5000";
const CABINS_PATH = `${BASE_URL}/api/v1/cabins`;

export async function getCabins() {
  const url = CABINS_PATH;
  let { data, errors } = await fetch(url).then((response) => response.json());

  if (errors) {
    console.error(errors);
    throw new Error("Cabins could not be loaded");
  }

  return data;
}

export async function getCabin(id) {
  const url = `${CABINS_PATH}/${id}`;
  let { data, errors } = await fetch(url).then((response) => response.json());

  if (errors) {
    console.error(errors);
    throw new Error("Cabin could not be loaded");
  }

  return data;
}

export async function createCabin(newCabin) {
  const url = CABINS_PATH;
  const body = JSON.stringify({ cabin: newCabin });

  const { data, errors } = await fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer your-token",
    },
    body,
  }).then((response) => response.json());

  if (errors) {
    throw new Error(errors);
  }

  return data;
}

export async function editCabin(newCabin, id) {
  const url = `${CABINS_PATH}/${id}`;
  const body = JSON.stringify({ cabin: newCabin });

  const { data, errors } = await fetch(url, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer your-token",
    },
    body,
  }).then((response) => response.json());

  if (errors) {
    throw new Error(errors);
  }

  return data;
}

export async function deleteCabin(id) {
  const url = `${CABINS_PATH}/${id}`;

  let { errors } = await fetch(url, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => response.json());

  if (errors) {
    console.error(errors);
    throw new Error("Cabin could not be deleted");
  }
}
