import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";

// Used for merging class names (shadcn utility)
export function cn(...inputs) {
  return twMerge(clsx(inputs));
}

// Helper for building URLs with query params
export function createPageUrl(base, params = {}) {
  const searchParams = new URLSearchParams(params).toString();
  return searchParams ? `${base}?${searchParams}` : base;
}
