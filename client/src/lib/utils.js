import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import * as lodash from "lodash";

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
