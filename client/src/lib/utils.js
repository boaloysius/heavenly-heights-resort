import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import * as lodash from "lodash";
import countriesJson from "./countries.json";

export function cn(...inputs) {
  return twMerge(clsx(inputs));
}

export function formatErrors(errors) {
  const formattedErrors = Object.entries(errors).reduce((acc, [key, value]) => {
    acc[key] = `${lodash.capitalize(key)} ${value.at(0)}`;
    return acc;
  }, {});

  return formattedErrors;
}

export function formatAuthErrors(errorMessages) {
  const formattedErrors = errorMessages.reduce((acc, message) => {
    if (typeof message === "string") {
      // Check if the value is a string
      // Strip "Profile " if it exists at the start of the message
      const cleanedMessage = message.startsWith("Profile ")
        ? message.replace("Profile ", "")
        : message;

      // Take the first word as the key, converted to lowercase
      let key = cleanedMessage.split(" ")[0].toLowerCase();

      if (key === "fullname") {
        key = "fullName";
      }

      acc[key] = lodash.capitalize(cleanedMessage);
    }
    return acc;
  }, {});

  return formattedErrors;
}

export const countries = Object.keys(countriesJson);

export const countriesMap = countriesJson;
