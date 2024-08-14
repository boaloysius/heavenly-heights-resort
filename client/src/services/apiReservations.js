import rails from "@/axios/rails";
const RESERVATIONS_PATH = "/api/v1/bookings";

export async function getReservations() {
  const url = RESERVATIONS_PATH;
  const { data } = await rails.get(url);
  return data;
}

export async function getReservation(id) {
  const url = `${RESERVATIONS_PATH}/${id}`;
  const { data } = await rails.get(url);
  return data;
}

export async function createReservation(newBooking) {
  const url = RESERVATIONS_PATH;
  const body = { booking: newBooking };

  const { data } = await rails.post(url, body);
  return data;
}

export async function editReservation(newBooking, id) {
  const url = `${RESERVATIONS_PATH}/${id}`;
  const body = { booking: newBooking };

  const { data } = await rails.put(url, body);
  return data;
}

export async function deleteReservation(id) {
  const url = `${RESERVATIONS_PATH}/${id}`;
  const { data } = await rails.delete(url);
  return data;
}
