import rails from "@/axios/rails";
const CABINS_PATH = "/api/v1/cabins";

export async function getCabins() {
  const url = CABINS_PATH;
  const { data } = await rails.get(url);
  return data;
}

export async function getCabin(id) {
  const url = `${CABINS_PATH}/${id}`;
  const { data } = await rails.get(url);
  return data;
}

export async function createCabin(newCabin) {
  const url = CABINS_PATH;
  const body = { cabin: newCabin };

  const { data } = await rails.post(url, body);
  return data;
}

export async function editCabin(newCabin, id) {
  const url = `${CABINS_PATH}/${id}`;
  const body = { cabin: newCabin };

  const { data } = await rails.put(url, body);
  return data;
}

export async function deleteCabin(id) {
  const url = `${CABINS_PATH}/${id}`;
  const { data } = await rails.delete(url);
  return data;
}
