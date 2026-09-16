// Canonical SY0-701 domain definitions.
// Single source of truth for the Home page, About page, and the quiz flow.
// Weights come from the official CompTIA exam objectives.

import lock from '../../assets/home page/lock.png';
import warning from '../../assets/home page/warning.png';
import locked from '../../assets/home page/locked.png';
import database from '../../assets/home page/database.png';
import clipboard from '../../assets/home page/clipboard.png';
import { quizQuestions } from './quizData';

const definitions = [
  {
    id: 'domain1',
    chartColor: '#7E22CE',
    number: '1.0',
    weight: '12%',
    title: 'General Security Concepts',
    quizLabel: 'Domain 1: General Security Concepts',
    topics: 'CIA Triad, Authentication, Cryptography Basics, Security Controls',
    description: 'Understanding security controls, principles, and foundational concepts',
    icon: lock,
    ringColor: 'border-purple-600',
    badgeColor: 'text-purple-700 bg-purple-100 border-purple-200',
    hoverBorder: 'hover:border-purple-600',
  },
  {
    id: 'domain2',
    chartColor: '#C8102E',
    number: '2.0',
    weight: '22%',
    title: 'Threats, Vulnerabilities, and Mitigations',
    quizLabel: 'Domain 2: Threats & Vulnerabilities',
    topics: 'Malware, Attacks, Vulnerability Management, Threat Intelligence',
    description: 'Identifying threat actors, attack vectors, and security measures',
    icon: warning,
    ringColor: 'border-red-600',
    badgeColor: 'text-red-700 bg-red-100 border-red-200',
    hoverBorder: 'hover:border-red-600',
  },
  {
    id: 'domain3',
    chartColor: '#0369A1',
    number: '3.0',
    weight: '18%',
    title: 'Security Architecture',
    quizLabel: 'Domain 3: Architecture & Design',
    topics: 'Network Security, Cloud Security, Infrastructure Security',
    description: 'Designing secure network architectures and implementing controls',
    icon: locked,
    ringColor: 'border-sky-400',
    badgeColor: 'text-sky-600 bg-sky-100 border-sky-200',
    hoverBorder: 'hover:border-sky-400',
  },
  {
    id: 'domain4',
    chartColor: '#B45309',
    number: '4.0',
    weight: '28%',
    title: 'Security Operations',
    quizLabel: 'Domain 4: Security Operations',
    topics: 'Monitoring, Incident Response, Digital Forensics, SIEM',
    description: 'Monitoring, incident response, digital forensics, and security tooling',
    icon: database,
    ringColor: 'border-yellow-500',
    badgeColor: 'text-yellow-800 bg-yellow-200 border-yellow-300',
    hoverBorder: 'hover:border-yellow-500',
  },
  {
    id: 'domain5',
    chartColor: '#15803D',
    number: '5.0',
    weight: '20%',
    title: 'Security Program Management and Oversight',
    quizLabel: 'Domain 5: Security Program Management and Oversight',
    topics: 'Governance, Risk Management, Compliance, Privacy',
    description: 'Governance, risk management, compliance, and security policy',
    icon: clipboard,
    ringColor: 'border-green-600',
    badgeColor: 'text-green-700 bg-green-100 border-green-200',
    hoverBorder: 'hover:border-green-600',
  },
];

// numberedTitle ("1.0 General Security Concepts") and questionCount are derived
// so they can never drift from the definitions above or from quizData.
export const securityDomains = definitions.map((domain) => ({
  ...domain,
  numberedTitle: `${domain.number} ${domain.title}`,
  questionCount: (quizQuestions[domain.id] || []).length,
}));

export const getDomainById = (id) =>
  securityDomains.find((domain) => domain.id === id);

/**
 * Look up a domain by the label stored on each question in quizData.
 *
 * Those labels ("Domain 3: Architecture & Design") predate this module and do
 * not match the titles here ("Security Architecture"), so anything joining
 * quiz results back to domain metadata has to go through `quizLabel`.
 */
export const getDomainByQuizLabel = (label) =>
  securityDomains.find((domain) => domain.quizLabel === label);
