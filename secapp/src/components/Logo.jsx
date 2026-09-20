import React from "react";

/**
 * Certucation brand mark.
 *
 * An original certification seal: a solid brand-red disc, a thin inset ring
 * that reads as an official stamp, and a mortarboard at the centre. The name
 * is "certification" + "education", so the mark carries both — the seal is the
 * certification half, the cap is the education half.
 *
 * Deliberately built from four flat shapes with no gradients, no strokes on
 * the silhouette and no fine detail, so it survives being rendered at 20px in
 * a nav bar or a browser tab. Nothing here derives from CompTIA's own marks.
 *
 * Geometry note: the cap body and the board share an edge and are both filled
 * white, so they union into a single silhouette rather than showing a seam.
 */

const RED = "#C8102E";

export function LogoMark({ className = "w-12 h-12", tone = "red", title = "Certucation" }) {
  // On a red or charcoal surface the disc drops out and the cap inverts to
  // the surface colour, which keeps the mark legible without a second asset.
  const onDark = tone === "onDark";
  const disc = onDark ? "#FFFFFF" : RED;
  const figure = onDark ? RED : "#FFFFFF";

  return (
    <svg
      viewBox="0 0 48 48"
      className={className}
      role="img"
      aria-label={title}
      xmlns="http://www.w3.org/2000/svg"
    >
      <circle cx="24" cy="24" r="24" fill={disc} />
      <circle
        cx="24"
        cy="24"
        r="20"
        fill="none"
        stroke={figure}
        strokeOpacity="0.3"
        strokeWidth="1.25"
      />

      {/* The cap, drawn first so the board overlaps it. Held slightly back from
          full white so the two planes separate without needing an outline —
          at favicon size the tones merge into one silhouette anyway. */}
      <path
        d="M16.5 23.5 L31.5 23.5 L29.8 31 C28.5 33.3 19.5 33.3 18.2 31 Z"
        fill={figure}
        fillOpacity="0.82"
      />

      {/* the flat board on top, in three-quarter perspective */}
      <path d="M24 14.3 L39 21.1 L24 28 L9 21.1 Z" fill={figure} />

      {/* tassel, dropped from the board's right corner */}
      <path
        d="M36.5 22.1 L36.5 28.6"
        stroke={figure}
        strokeWidth="1.8"
        strokeLinecap="round"
      />
      <circle cx="36.5" cy="30.8" r="2.3" fill={figure} />
    </svg>
  );
}

/**
 * Full horizontal lockup: mark + wordmark. This is the nav-bar brand block.
 * `subtitle` is the exam line under the name; pass null to drop it.
 */
export default function Logo({
  className = "",
  markClassName = "w-12 h-12",
  subtitle = "SECURITY+",
  tone = "red",
}) {
  const onDark = tone === "onDark";

  return (
    <span className={`flex items-center gap-3 ${className}`}>
      <LogoMark tone={tone} className={`${markClassName} shrink-0`} />
      <span className="leading-tight">
        <span
          className={`block text-xl font-bold tracking-tight ${
            onDark ? "text-white" : "text-slate-900"
          }`}
        >
          Certucation
        </span>
        {subtitle && (
          <span
            className={`block text-xs font-bold tracking-[0.18em] -mt-0.5 ${
              onDark ? "text-white/70" : "text-red-600"
            }`}
          >
            {subtitle}
          </span>
        )}
      </span>
    </span>
  );
}
