export const lessons = [
  {
    id: 'lesson-1',
    title: 'Introduction to Security Concepts',
    description: 'Learn the fundamental security concepts including CIA triad, AAA framework, and security principles.',
    content: `# Introduction to Security Concepts

## The CIA Triad

The CIA Triad is the foundation of information security:

### Confidentiality
Ensuring that information is accessible only to authorized individuals. Methods include:
- Encryption
- Access controls
- Authentication mechanisms

### Integrity
Maintaining accuracy and completeness of data. Achieved through:
- Hashing algorithms
- Digital signatures
- Checksums

### Availability
Ensuring authorized users have reliable access to information. Protected by:
- Redundancy
- Backup systems
- Disaster recovery plans

## AAA Framework

### Authentication
Verifying the identity of a user or system.

### Authorization
Granting appropriate access rights.

### Accounting
Tracking user activities and resource usage.`,
    difficulty: 'Beginner',
    duration: '15 min',
    category: 'General Security',
    order: 1
  },
  {
    id: 'lesson-2',
    title: 'Threat Actors and Attack Types',
    description: 'Understanding different types of threat actors and common attack methodologies.',
    content: `# Threat Actors and Attack Types

## Types of Threat Actors

### Nation-State Actors
- Government-sponsored hackers
- Advanced persistent threats (APTs)
- High resources and sophistication

### Hacktivists
- Politically or socially motivated
- Target organizations to make statements
- Examples: Anonymous, WikiLeaks

### Organized Crime
- Financial motivation
- Ransomware and fraud operations
- Well-funded and organized

### Script Kiddies
- Low skill level
- Use existing tools
- Opportunistic attacks

## Common Attack Types

### Phishing
Fraudulent attempts to obtain sensitive information through deceptive emails or websites.

### Malware
Malicious software including viruses, worms, trojans, and ransomware.

### DDoS Attacks
Overwhelming systems with traffic to cause service disruption.`,
    difficulty: 'Beginner',
    duration: '20 min',
    category: 'Threats',
    order: 2
  },
  {
    id: 'lesson-3',
    title: 'Cryptography Fundamentals',
    description: 'Introduction to cryptographic concepts, algorithms, and their applications.',
    content: `# Cryptography Fundamentals

## Symmetric Encryption

Uses the same key for encryption and decryption.

### Common Algorithms
- AES (Advanced Encryption Standard)
- DES (Data Encryption Standard) - Legacy
- 3DES (Triple DES)

### Advantages
- Fast performance
- Suitable for large data

### Disadvantages
- Key distribution challenge
- Key management complexity

## Asymmetric Encryption

Uses public and private key pairs.

### Common Algorithms
- RSA
- ECC (Elliptic Curve Cryptography)
- Diffie-Hellman

### Use Cases
- Digital signatures
- Key exchange
- SSL/TLS certificates

## Hashing

One-way cryptographic function producing fixed-size output.

### Common Algorithms
- SHA-256
- SHA-3
- MD5 (Legacy, not recommended)

### Applications
- Password storage
- Data integrity verification
- Digital signatures`,
    difficulty: 'Intermediate',
    duration: '25 min',
    category: 'Cryptography',
    order: 3
  },
  {
    id: 'lesson-4',
    title: 'Network Security',
    description: 'Network security principles, protocols, and protective measures.',
    content: `# Network Security

## Network Security Devices

### Firewalls
- Packet filtering
- Stateful inspection
- Application-layer filtering
- Next-generation firewalls (NGFW)

### IDS/IPS
**Intrusion Detection Systems (IDS)**
- Monitors network traffic
- Alerts on suspicious activity

**Intrusion Prevention Systems (IPS)**
- Actively blocks threats
- Inline deployment

### VPN (Virtual Private Network)
- Encrypted tunnels
- Remote access
- Site-to-site connectivity

## Network Protocols

### Secure Protocols
- HTTPS (HTTP over TLS)
- SSH (Secure Shell)
- SFTP (SSH File Transfer Protocol)
- FTPS (FTP over SSL/TLS)

### Legacy/Insecure Protocols
- HTTP
- Telnet
- FTP
- SNMP v1/v2

## Network Segmentation

Dividing networks into separate zones:
- DMZ for public-facing services
- Internal networks
- Management networks
- Guest networks`,
    difficulty: 'Intermediate',
    duration: '30 min',
    category: 'Network Security',
    order: 4
  },
  {
    id: 'lesson-5',
    title: 'Identity and Access Management',
    description: 'Managing user identities, authentication methods, and access controls.',
    content: `# Identity and Access Management (IAM)

## Authentication Methods

### Something You Know
- Passwords
- PINs
- Security questions

### Something You Have
- Smart cards
- Hardware tokens
- Mobile devices

### Something You Are
- Fingerprints
- Facial recognition
- Iris scans

## Multi-Factor Authentication (MFA)

Combining two or more authentication factors for enhanced security.

### Benefits
- Significantly reduces unauthorized access
- Protects against password theft
- Industry best practice

## Access Control Models

### Role-Based Access Control (RBAC)
Permissions based on user roles within organization.

### Mandatory Access Control (MAC)
System-enforced access based on security labels.

### Discretionary Access Control (DAC)
Resource owners control access permissions.

### Attribute-Based Access Control (ABAC)
Dynamic access based on attributes and policies.

## Single Sign-On (SSO)

Allows users to access multiple systems with one set of credentials.

### Protocols
- SAML
- OAuth 2.0
- OpenID Connect`,
    difficulty: 'Intermediate',
    duration: '25 min',
    category: 'IAM',
    order: 5
  },
  {
    id: 'lesson-6',
    title: 'Incident Response',
    description: 'Incident response lifecycle, procedures, and best practices.',
    content: `# Incident Response

## Incident Response Lifecycle

### 1. Preparation
- Develop IR plan
- Train IR team
- Implement monitoring tools
- Establish communication channels

### 2. Detection and Analysis
- Monitor for indicators
- Analyze security events
- Determine incident severity
- Document findings

### 3. Containment
**Short-term containment**
- Isolate affected systems
- Prevent spread

**Long-term containment**
- Apply temporary fixes
- Maintain business operations

### 4. Eradication
- Remove threat
- Identify root cause
- Patch vulnerabilities

### 5. Recovery
- Restore systems
- Verify normal operations
- Monitor for recurrence

### 6. Post-Incident Activity
- Lessons learned
- Update procedures
- Improve defenses

## Incident Response Team Roles

### Incident Manager
Coordinates response activities

### Security Analysts
Investigate and analyze incidents

### IT Staff
Support system recovery

### Legal/Compliance
Address regulatory requirements

### Communications
Handle internal and external messaging`,
    difficulty: 'Advanced',
    duration: '30 min',
    category: 'Incident Response',
    order: 6
  }
];

export const getLessonById = (id) => {
  return lessons.find(lesson => lesson.id === id);
};

export const getLessonsByCategory = (category) => {
  return lessons.filter(lesson => lesson.category === category);
};

export const getLessonsByDifficulty = (difficulty) => {
  return lessons.filter(lesson => lesson.difficulty === difficulty);
};