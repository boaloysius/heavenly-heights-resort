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

  const formData = new FormData();
  formData.append("cabin[name]", newCabin.name);
  formData.append("cabin[description]", newCabin.description);
  formData.append("cabin[discount]", newCabin.discount);
  formData.append("cabin[maxCapacity]", newCabin.maxCapacity);
  formData.append("cabin[regularPrice]", newCabin.regularPrice);

  if (newCabin.imageFile) {
    formData.append("cabin[imageFile]", newCabin.imageFile);
  }

  const { data } = await rails.post(url, formData);
  return data;
}

export async function editCabin(newCabin, id) {
  const url = `${CABINS_PATH}/${id}`;

  const formData = new FormData();
  formData.append("cabin[name]", newCabin.name);
  formData.append("cabin[description]", newCabin.description);
  formData.append("cabin[discount]", newCabin.discount);
  formData.append("cabin[maxCapacity]", newCabin.maxCapacity);
  formData.append("cabin[regularPrice]", newCabin.regularPrice);

  if (newCabin.imageFile) {
    formData.append("cabin[imageFile]", newCabin.imageFile);
  }

  const { data } = await rails.put(url, formData);
  return data;
}

export async function deleteCabin(id) {
  const url = `${CABINS_PATH}/${id}`;
  const { data } = await rails.delete(url);
  return data;
}
