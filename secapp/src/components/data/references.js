// Outside sources cited on the About page.
//
// Each entry is rendered by <SourceLink id="..."> underneath the claim it
// backs, rather than collected into a list at the foot of the page. Keep the
// file to references something actually cites — an unused entry is a link
// nobody checked recently.
//
// Every URL here was fetched and confirmed to resolve when it was added. If
// one rots, fix or remove it rather than leaving a dead link on the page —
// the whole point of the section is that the claims can be checked.
//
// DoD 8140 (the successor to 8570, which About mentions) is deliberately
// absent: cyber.mil redirects to a military SSO login, so it is useless to a
// visitor.

export const references = [
  {
    id: 'comptia-security-plus',
    source: 'CompTIA',
    title: 'Security+ (SY0-701) exam page',
    description:
      'The official page behind the numbers used here: exam objectives, 90 minutes, up to 90 questions, and the 750/900 pass mark.',
    url: 'https://www.comptia.org/certifications/security',
  },
  {
    id: 'nice-career-pathways',
    source: 'NIST NICE',
    title: 'Cybersecurity career pathway resources',
    description:
      'How certifications fit into cybersecurity career paths, with Security+ named as the centrepiece of the entry-level track.',
    url: 'https://www.nist.gov/itl/applied-cybersecurity/nice/resources/career-pathways#CertificationPathways',
  },
  {
    id: 'cyberseek',
    source: 'CyberSeek',
    title: 'Cybersecurity career pathway map',
    description:
      'Live job-market data: which entry-level roles are hiring, what they pay, and the certifications employers actually ask for.',
    url: 'https://www.cyberseek.org/pathway.html',
  },
  {
    id: 'bls-infosec-analysts',
    source: 'US Bureau of Labor Statistics',
    title: 'Information security analysts: pay and job outlook',
    description:
      'Median annual wage, the 10th-to-90th percentile range, and the ten-year employment projection for the role Security+ opens the door to.',
    url: 'https://www.bls.gov/ooh/computer-and-information-technology/information-security-analysts.htm',
  },
];

/** "nist.gov" from a full URL, for showing where a link goes. */
export const hostOf = (url) => new URL(url).hostname.replace(/^www\./, '');
