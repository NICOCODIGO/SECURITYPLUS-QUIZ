import React from 'react';
import { ExternalLink } from 'lucide-react';
import { references, hostOf } from './data/references';

/**
 * A small "Source: CompTIA" link that sits under the claim it backs.
 *
 * References are attached to the component making the claim rather than
 * collected in a list at the bottom of the page — a reader checking a line
 * shouldn't have to go hunting for which link belongs to it.
 *
 * `id` is a key from data/references.js; an unknown id renders nothing rather
 * than a broken link.
 */
export default function SourceLink({ id, label, className = '' }) {
  const reference = references.find((entry) => entry.id === id);
  if (!reference) return null;

  return (
    <a
      href={reference.url}
      target="_blank"
      rel="noopener noreferrer"
      className={`inline-flex items-center gap-1.5 text-[11px] font-bold text-slate-400 hover:text-red-600 transition-colors ${className}`}
    >
      <ExternalLink className="w-3 h-3 flex-shrink-0" />
      Source: {label || reference.source}
      <span className="sr-only">
        {' '}
        — {reference.title}, {hostOf(reference.url)} (opens in a new tab)
      </span>
    </a>
  );
}
