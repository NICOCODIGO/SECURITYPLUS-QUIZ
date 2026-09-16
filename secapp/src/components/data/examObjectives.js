// Official CompTIA Security+ SY0-701 exam objectives, domain by domain.
//
// Source: CompTIA Security+ SY0-701 Certification Exam Objectives v5.0,
// © 2023 CompTIA, Inc. Reproduced here as study reference material.
//
// Shape: each domain holds an ordered list of objectives. A topic is either a
// plain string (a leaf) or `{ label, children }`, nested to whatever depth the
// official outline uses — three levels for the most part, and four in exactly
// one place (3.1 Network infrastructure > Physical isolation > Air-gapped).
//
// All five domains are transcribed. `getObjectives` still returns an empty
// array for an unknown id, and the modal renders a placeholder for that case.

const objectives = {
  domain1: [
    {
      id: '1.1',
      title: 'Compare and contrast various types of security controls.',
      topics: [
        {
          label: 'Categories',
          children: ['Technical', 'Managerial', 'Operational', 'Physical'],
        },
        {
          label: 'Control types',
          children: [
            'Preventive',
            'Deterrent',
            'Detective',
            'Corrective',
            'Compensating',
            'Directive',
          ],
        },
      ],
    },
    {
      id: '1.2',
      title: 'Summarize fundamental security concepts.',
      topics: [
        'Confidentiality, Integrity, and Availability (CIA)',
        'Non-repudiation',
        {
          label: 'Authentication, Authorization, and Accounting (AAA)',
          children: [
            'Authenticating people',
            'Authenticating systems',
            'Authorization models',
          ],
        },
        'Gap analysis',
        {
          label: 'Zero Trust',
          children: [
            {
              label: 'Control Plane',
              children: [
                'Adaptive identity',
                'Threat scope reduction',
                'Policy-driven access control',
                'Policy Administrator',
                'Policy Engine',
              ],
            },
            {
              label: 'Data Plane',
              children: [
                'Implicit trust zones',
                'Subject/System',
                'Policy Enforcement Point',
              ],
            },
          ],
        },
        {
          label: 'Physical security',
          children: [
            'Bollards',
            'Access control vestibule',
            'Fencing',
            'Video surveillance',
            'Security guard',
            'Access badge',
            'Lighting',
            {
              label: 'Sensors',
              children: ['Infrared', 'Pressure', 'Microwave', 'Ultrasonic'],
            },
          ],
        },
        {
          label: 'Deception and disruption technology',
          children: ['Honeypot', 'Honeynet', 'Honeyfile', 'Honeytoken'],
        },
      ],
    },
    {
      id: '1.3',
      title:
        'Explain the importance of change management processes and the impact to security.',
      topics: [
        {
          label: 'Business processes impacting security operation',
          children: [
            'Approval process',
            'Ownership',
            'Stakeholders',
            'Impact analysis',
            'Test results',
            'Backout plan',
            'Maintenance window',
            'Standard operating procedure',
          ],
        },
        {
          label: 'Technical implications',
          children: [
            'Allow lists/deny lists',
            'Restricted activities',
            'Downtime',
            'Service restart',
            'Application restart',
            'Legacy applications',
            'Dependencies',
          ],
        },
        {
          label: 'Documentation',
          children: ['Updating diagrams', 'Updating policies/procedures'],
        },
        'Version control',
      ],
    },
    {
      id: '1.4',
      title:
        'Explain the importance of using appropriate cryptographic solutions.',
      topics: [
        {
          label: 'Public key infrastructure (PKI)',
          children: ['Public key', 'Private key', 'Key escrow'],
        },
        {
          label: 'Encryption',
          children: [
            {
              label: 'Level',
              children: [
                'Full-disk',
                'Partition',
                'File',
                'Volume',
                'Database',
                'Record',
              ],
            },
            'Transport/communication',
            'Asymmetric',
            'Symmetric',
            'Key exchange',
            'Algorithms',
            'Key length',
          ],
        },
        {
          label: 'Tools',
          children: [
            'Trusted Platform Module (TPM)',
            'Hardware security module (HSM)',
            'Key management system',
            'Secure enclave',
          ],
        },
        {
          // The official PDF marks these three with the third-level bullet
          // even though they sit directly under a first-level item. Nested at
          // their actual depth here so the indentation stays consistent.
          label: 'Obfuscation',
          children: ['Steganography', 'Tokenization', 'Data masking'],
        },
        'Hashing',
        'Salting',
        'Digital signatures',
        'Key stretching',
        'Blockchain',
        'Open public ledger',
        {
          label: 'Certificates',
          children: [
            'Certificate authorities',
            'Certificate revocation lists (CRLs)',
            'Online Certificate Status Protocol (OCSP)',
            'Self-signed',
            'Third-party',
            'Root of trust',
            'Certificate signing request (CSR) generation',
            'Wildcard',
          ],
        },
      ],
    },
  ],

  domain2: [
    {
      id: '2.1',
      title: 'Compare and contrast common threat actors and motivations.',
      topics: [
        {
          label: 'Threat actors',
          children: [
            'Nation-state',
            'Unskilled attacker',
            'Hacktivist',
            'Insider threat',
            'Organized crime',
            'Shadow IT',
          ],
        },
        {
          label: 'Attributes of actors',
          children: [
            'Internal/external',
            'Resources/funding',
            'Level of sophistication/capability',
          ],
        },
        {
          label: 'Motivations',
          children: [
            'Data exfiltration',
            'Espionage',
            'Service disruption',
            'Blackmail',
            'Financial gain',
            'Philosophical/political beliefs',
            'Ethical',
            'Revenge',
            'Disruption/chaos',
            'War',
          ],
        },
      ],
    },
    {
      id: '2.2',
      title: 'Explain common threat vectors and attack surfaces.',
      topics: [
        {
          label: 'Message-based',
          children: [
            'Email',
            'Short Message Service (SMS)',
            'Instant messaging (IM)',
          ],
        },
        'Image-based',
        'File-based',
        'Voice call',
        'Removable device',
        {
          label: 'Vulnerable software',
          children: ['Client-based vs. agentless'],
        },
        'Unsupported systems and applications',
        {
          label: 'Unsecure networks',
          children: ['Wireless', 'Wired', 'Bluetooth'],
        },
        'Open service ports',
        'Default credentials',
        {
          label: 'Supply chain',
          children: [
            'Managed service providers (MSPs)',
            'Vendors',
            'Suppliers',
          ],
        },
        {
          label: 'Human vectors/social engineering',
          children: [
            'Phishing',
            'Vishing',
            'Smishing',
            'Misinformation/disinformation',
            'Impersonation',
            'Business email compromise',
            'Pretexting',
            'Watering hole',
            'Brand impersonation',
            'Typosquatting',
          ],
        },
      ],
    },
    {
      id: '2.3',
      title: 'Explain various types of vulnerabilities.',
      topics: [
        {
          label: 'Application',
          children: [
            'Memory injection',
            'Buffer overflow',
            {
              label: 'Race conditions',
              children: ['Time-of-check (TOC)', 'Time-of-use (TOU)'],
            },
            'Malicious update',
          ],
        },
        'Operating system (OS)-based',
        {
          label: 'Web-based',
          children: [
            'Structured Query Language injection (SQLi)',
            'Cross-site scripting (XSS)',
          ],
        },
        {
          label: 'Hardware',
          children: ['Firmware', 'End-of-life', 'Legacy'],
        },
        {
          label: 'Virtualization',
          children: ['Virtual machine (VM) escape', 'Resource reuse'],
        },
        'Cloud-specific',
        {
          label: 'Supply chain',
          children: ['Service provider', 'Hardware provider', 'Software provider'],
        },
        'Cryptographic',
        'Misconfiguration',
        {
          label: 'Mobile device',
          children: ['Side loading', 'Jailbreaking'],
        },
        'Zero-day',
      ],
    },
    {
      id: '2.4',
      title: 'Given a scenario, analyze indicators of malicious activity.',
      topics: [
        {
          label: 'Malware attacks',
          children: [
            'Ransomware',
            'Trojan',
            'Worm',
            'Spyware',
            'Bloatware',
            'Virus',
            'Keylogger',
            'Logic bomb',
            'Rootkit',
          ],
        },
        {
          label: 'Physical attacks',
          children: [
            'Brute force',
            'Radio frequency identification (RFID) cloning',
            'Environmental',
          ],
        },
        {
          label: 'Network attacks',
          children: [
            {
              label: 'Distributed denial-of-service (DDoS)',
              children: ['Amplified', 'Reflected'],
            },
            'Domain Name System (DNS) attacks',
            'Wireless',
            'On-path',
            'Credential replay',
            'Malicious code',
          ],
        },
        {
          label: 'Application attacks',
          children: [
            'Injection',
            'Buffer overflow',
            'Replay',
            'Privilege escalation',
            'Forgery',
            'Directory traversal',
          ],
        },
        {
          label: 'Cryptographic attacks',
          children: ['Downgrade', 'Collision', 'Birthday'],
        },
        {
          label: 'Password attacks',
          children: ['Spraying', 'Brute force'],
        },
        {
          label: 'Indicators',
          children: [
            'Account lockout',
            'Concurrent session usage',
            'Blocked content',
            'Impossible travel',
            'Resource consumption',
            'Resource inaccessibility',
            'Out-of-cycle logging',
            'Published/documented',
            'Missing logs',
          ],
        },
      ],
    },
    {
      id: '2.5',
      title:
        'Explain the purpose of mitigation techniques used to secure the enterprise.',
      topics: [
        'Segmentation',
        {
          label: 'Access control',
          children: ['Access control list (ACL)', 'Permissions'],
        },
        'Application allow list',
        'Isolation',
        'Patching',
        'Encryption',
        'Monitoring',
        'Least privilege',
        'Configuration enforcement',
        'Decommissioning',
        {
          label: 'Hardening techniques',
          children: [
            'Encryption',
            'Installation of endpoint protection',
            'Host-based firewall',
            'Host-based intrusion prevention system (HIPS)',
            'Disabling ports/protocols',
            'Default password changes',
            'Removal of unnecessary software',
          ],
        },
      ],
    },
  ],

  domain3: [
    {
      id: '3.1',
      title:
        'Compare and contrast security implications of different architecture models.',
      topics: [
        {
          label: 'Architecture and infrastructure concepts',
          children: [
            {
              label: 'Cloud',
              children: [
                'Responsibility matrix',
                'Hybrid considerations',
                'Third-party vendors',
              ],
            },
            'Infrastructure as code (IaC)',
            'Serverless',
            'Microservices',
            {
              label: 'Network infrastructure',
              children: [
                {
                  // The only four-level branch in the whole outline.
                  label: 'Physical isolation',
                  children: ['Air-gapped'],
                },
                'Logical segmentation',
                'Software-defined networking (SDN)',
              ],
            },
            'On-premises',
            'Centralized vs. decentralized',
            'Containerization',
            'Virtualization',
            'IoT',
            'Industrial control systems (ICS)/supervisory control and data acquisition (SCADA)',
            'Real-time operating system (RTOS)',
            'Embedded systems',
            'High availability',
          ],
        },
        {
          label: 'Considerations',
          children: [
            'Availability',
            'Resilience',
            'Cost',
            'Responsiveness',
            'Scalability',
            'Ease of deployment',
            'Risk transference',
            'Ease of recovery',
            'Patch availability',
            'Inability to patch',
            'Power',
            'Compute',
          ],
        },
      ],
    },
    {
      id: '3.2',
      title:
        'Given a scenario, apply security principles to secure enterprise infrastructure.',
      topics: [
        {
          label: 'Infrastructure considerations',
          children: [
            'Device placement',
            'Security zones',
            'Attack surface',
            'Connectivity',
            {
              label: 'Failure modes',
              children: ['Fail-open', 'Fail-closed'],
            },
            {
              label: 'Device attribute',
              children: ['Active vs. passive', 'Inline vs. tap/monitor'],
            },
            {
              label: 'Network appliances',
              children: [
                'Jump server',
                'Proxy server',
                'Intrusion prevention system (IPS)/intrusion detection system (IDS)',
                'Load balancer',
                'Sensors',
              ],
            },
            {
              label: 'Port security',
              children: ['802.1X', 'Extensible Authentication Protocol (EAP)'],
            },
            {
              label: 'Firewall types',
              children: [
                'Web application firewall (WAF)',
                'Unified threat management (UTM)',
                'Next-generation firewall (NGFW)',
                'Layer 4/Layer 7',
              ],
            },
          ],
        },
        {
          label: 'Secure communication/access',
          children: [
            'Virtual private network (VPN)',
            'Remote access',
            {
              label: 'Tunneling',
              children: [
                'Transport Layer Security (TLS)',
                'Internet protocol security (IPSec)',
              ],
            },
            'Software-defined wide area network (SD-WAN)',
            'Secure access service edge (SASE)',
          ],
        },
        'Selection of effective controls',
      ],
    },
    {
      id: '3.3',
      title: 'Compare and contrast concepts and strategies to protect data.',
      topics: [
        {
          label: 'Data types',
          children: [
            'Regulated',
            'Trade secret',
            'Intellectual property',
            'Legal information',
            'Financial information',
            'Human- and non-human-readable',
          ],
        },
        {
          label: 'Data classifications',
          children: [
            'Sensitive',
            'Confidential',
            'Public',
            'Restricted',
            'Private',
            'Critical',
          ],
        },
        {
          label: 'General data considerations',
          children: [
            {
              label: 'Data states',
              children: ['Data at rest', 'Data in transit', 'Data in use'],
            },
            'Data sovereignty',
            'Geolocation',
          ],
        },
        {
          label: 'Methods to secure data',
          children: [
            'Geographic restrictions',
            'Encryption',
            'Hashing',
            'Masking',
            'Tokenization',
            'Obfuscation',
            'Segmentation',
            'Permission restrictions',
          ],
        },
      ],
    },
    {
      id: '3.4',
      title:
        'Explain the importance of resilience and recovery in security architecture.',
      topics: [
        {
          label: 'High availability',
          children: ['Load balancing vs. clustering'],
        },
        {
          label: 'Site considerations',
          children: ['Hot', 'Cold', 'Warm', 'Geographic dispersion'],
        },
        'Platform diversity',
        'Multi-cloud systems',
        'Continuity of operations',
        {
          label: 'Capacity planning',
          children: ['People', 'Technology', 'Infrastructure'],
        },
        {
          label: 'Testing',
          children: [
            'Tabletop exercises',
            'Fail over',
            'Simulation',
            'Parallel processing',
          ],
        },
        {
          label: 'Backups',
          children: [
            'Onsite/offsite',
            'Frequency',
            'Encryption',
            'Snapshots',
            'Recovery',
            'Replication',
            'Journaling',
          ],
        },
        {
          label: 'Power',
          children: ['Generators', 'Uninterruptible power supply (UPS)'],
        },
      ],
    },
  ],

  domain4: [
    {
      id: '4.1',
      title:
        'Given a scenario, apply common security techniques to computing resources.',
      topics: [
        {
          label: 'Secure baselines',
          children: ['Establish', 'Deploy', 'Maintain'],
        },
        {
          label: 'Hardening targets',
          children: [
            'Mobile devices',
            'Workstations',
            'Switches',
            'Routers',
            'Cloud infrastructure',
            'Servers',
            'ICS/SCADA',
            'Embedded systems',
            'RTOS',
            'IoT devices',
          ],
        },
        {
          label: 'Wireless devices',
          children: [
            {
              label: 'Installation considerations',
              children: ['Site surveys', 'Heat maps'],
            },
          ],
        },
        {
          label: 'Mobile solutions',
          children: [
            'Mobile device management (MDM)',
            {
              label: 'Deployment models',
              children: [
                'Bring your own device (BYOD)',
                'Corporate-owned, personally enabled (COPE)',
                'Choose your own device (CYOD)',
              ],
            },
            {
              label: 'Connection methods',
              children: ['Cellular', 'Wi-Fi', 'Bluetooth'],
            },
          ],
        },
        {
          label: 'Wireless security settings',
          children: [
            'Wi-Fi Protected Access 3 (WPA3)',
            'AAA/Remote Authentication Dial-In User Service (RADIUS)',
            'Cryptographic protocols',
            'Authentication protocols',
          ],
        },
        {
          label: 'Application security',
          children: [
            'Input validation',
            'Secure cookies',
            'Static code analysis',
            'Code signing',
          ],
        },
        'Sandboxing',
        'Monitoring',
      ],
    },
    {
      id: '4.2',
      title:
        'Explain the security implications of proper hardware, software, and data asset management.',
      topics: [
        'Acquisition/procurement process',
        {
          label: 'Assignment/accounting',
          children: ['Ownership', 'Classification'],
        },
        {
          label: 'Monitoring/asset tracking',
          children: ['Inventory', 'Enumeration'],
        },
        {
          label: 'Disposal/decommissioning',
          children: ['Sanitization', 'Destruction', 'Certification', 'Data retention'],
        },
      ],
    },
    {
      id: '4.3',
      title: 'Explain various activities associated with vulnerability management.',
      topics: [
        {
          label: 'Identification methods',
          children: [
            'Vulnerability scan',
            {
              label: 'Application security',
              children: ['Static analysis', 'Dynamic analysis', 'Package monitoring'],
            },
            {
              label: 'Threat feed',
              children: [
                'Open-source intelligence (OSINT)',
                'Proprietary/third-party',
                'Information-sharing organization',
                'Dark web',
              ],
            },
            'Penetration testing',
            {
              label: 'Responsible disclosure program',
              children: ['Bug bounty program'],
            },
            'System/process audit',
          ],
        },
        {
          label: 'Analysis',
          children: [
            {
              label: 'Confirmation',
              children: ['False positive', 'False negative'],
            },
            'Prioritize',
            'Common Vulnerability Scoring System (CVSS)',
            'Common Vulnerability Enumeration (CVE)',
            'Vulnerability classification',
            'Exposure factor',
            'Environmental variables',
            'Industry/organizational impact',
            'Risk tolerance',
          ],
        },
        {
          label: 'Vulnerability response and remediation',
          children: [
            'Patching',
            'Insurance',
            'Segmentation',
            'Compensating controls',
            'Exceptions and exemptions',
          ],
        },
        {
          label: 'Validation of remediation',
          children: ['Rescanning', 'Audit', 'Verification'],
        },
        'Reporting',
      ],
    },
    {
      id: '4.4',
      title: 'Explain security alerting and monitoring concepts and tools.',
      topics: [
        {
          label: 'Monitoring computing resources',
          children: ['Systems', 'Applications', 'Infrastructure'],
        },
        {
          label: 'Activities',
          children: [
            'Log aggregation',
            'Alerting',
            'Scanning',
            'Reporting',
            'Archiving',
            {
              label: 'Alert response and remediation/validation',
              children: ['Quarantine', 'Alert tuning'],
            },
          ],
        },
        {
          label: 'Tools',
          children: [
            'Security Content Automation Protocol (SCAP)',
            'Benchmarks',
            'Agents/agentless',
            'Security information and event management (SIEM)',
            'Antivirus',
            'Data loss prevention (DLP)',
            'Simple Network Management Protocol (SNMP) traps',
            'NetFlow',
            'Vulnerability scanners',
          ],
        },
      ],
    },
    {
      id: '4.5',
      title: 'Given a scenario, modify enterprise capabilities to enhance security.',
      topics: [
        {
          label: 'Firewall',
          children: ['Rules', 'Access lists', 'Ports/protocols', 'Screened subnets'],
        },
        {
          label: 'IDS/IPS',
          children: ['Trends', 'Signatures'],
        },
        {
          label: 'Web filter',
          children: [
            'Agent-based',
            'Centralized proxy',
            'Universal Resource Locator (URL) scanning',
            'Content categorization',
            'Block rules',
            'Reputation',
          ],
        },
        {
          label: 'Operating system security',
          children: ['Group Policy', 'SELinux'],
        },
        {
          label: 'Implementation of secure protocols',
          children: ['Protocol selection', 'Port selection', 'Transport method'],
        },
        'DNS filtering',
        {
          label: 'Email security',
          children: [
            'Domain-based Message Authentication Reporting and Conformance (DMARC)',
            'DomainKeys Identified Mail (DKIM)',
            'Sender Policy Framework (SPF)',
            'Gateway',
          ],
        },
        'File integrity monitoring',
        'DLP',
        'Network access control (NAC)',
        'Endpoint detection and response (EDR)/extended detection and response (XDR)',
        'User behavior analytics',
      ],
    },
    {
      id: '4.6',
      title:
        'Given a scenario, implement and maintain identity and access management.',
      topics: [
        'Provisioning/de-provisioning user accounts',
        'Permission assignments and implications',
        'Identity proofing',
        'Federation',
        {
          label: 'Single sign-on (SSO)',
          children: [
            'Lightweight Directory Access Protocol (LDAP)',
            'Open authorization (OAuth)',
            'Security Assertions Markup Language (SAML)',
          ],
        },
        'Interoperability',
        'Attestation',
        {
          label: 'Access controls',
          children: [
            'Mandatory',
            'Discretionary',
            'Role-based',
            'Rule-based',
            'Attribute-based',
            'Time-of-day restrictions',
            'Least privilege',
          ],
        },
        {
          label: 'Multifactor authentication',
          children: [
            {
              label: 'Implementations',
              children: [
                'Biometrics',
                'Hard/soft authentication tokens',
                'Security keys',
              ],
            },
            {
              label: 'Factors',
              children: [
                'Something you know',
                'Something you have',
                'Something you are',
                'Somewhere you are',
              ],
            },
          ],
        },
        {
          label: 'Password concepts',
          children: [
            {
              label: 'Password best practices',
              children: ['Length', 'Complexity', 'Reuse', 'Expiration', 'Age'],
            },
            'Password managers',
            'Passwordless',
          ],
        },
        {
          label: 'Privileged access management tools',
          children: [
            'Just-in-time permissions',
            'Password vaulting',
            'Ephemeral credentials',
          ],
        },
      ],
    },
    {
      id: '4.7',
      title:
        'Explain the importance of automation and orchestration related to secure operations.',
      topics: [
        {
          label: 'Use cases of automation and scripting',
          children: [
            'User provisioning',
            'Resource provisioning',
            'Guard rails',
            'Security groups',
            'Ticket creation',
            'Escalation',
            'Enabling/disabling services and access',
            'Continuous integration and testing',
            'Integrations and Application programming interfaces (APIs)',
          ],
        },
        {
          label: 'Benefits',
          children: [
            'Efficiency/time saving',
            'Enforcing baselines',
            'Standard infrastructure configurations',
            'Scaling in a secure manner',
            'Employee retention',
            'Reaction time',
            'Workforce multiplier',
          ],
        },
        {
          label: 'Other considerations',
          children: [
            'Complexity',
            'Cost',
            'Single point of failure',
            'Technical debt',
            'Ongoing supportability',
          ],
        },
      ],
    },
    {
      id: '4.8',
      title: 'Explain appropriate incident response activities.',
      topics: [
        {
          label: 'Process',
          children: [
            'Preparation',
            'Detection',
            'Analysis',
            'Containment',
            'Eradication',
            'Recovery',
            'Lessons learned',
          ],
        },
        'Training',
        {
          label: 'Testing',
          children: ['Tabletop exercise', 'Simulation'],
        },
        'Root cause analysis',
        'Threat hunting',
        {
          label: 'Digital forensics',
          children: [
            'Legal hold',
            'Chain of custody',
            'Acquisition',
            'Reporting',
            'Preservation',
            'E-discovery',
          ],
        },
      ],
    },
    {
      id: '4.9',
      title: 'Given a scenario, use data sources to support an investigation.',
      topics: [
        {
          label: 'Log data',
          children: [
            'Firewall logs',
            'Application logs',
            'Endpoint logs',
            'OS-specific security logs',
            'IPS/IDS logs',
            'Network logs',
            'Metadata',
          ],
        },
        {
          label: 'Data sources',
          children: [
            'Vulnerability scans',
            'Automated reports',
            'Dashboards',
            'Packet captures',
          ],
        },
      ],
    },
  ],

  domain5: [
    {
      id: '5.1',
      title: 'Summarize elements of effective security governance.',
      topics: [
        'Guidelines',
        {
          label: 'Policies',
          children: [
            'Acceptable use policy (AUP)',
            'Information security policies',
            'Business continuity',
            'Disaster recovery',
            'Incident response',
            'Software development lifecycle (SDLC)',
            'Change management',
          ],
        },
        {
          label: 'Standards',
          children: ['Password', 'Access control', 'Physical security', 'Encryption'],
        },
        {
          label: 'Procedures',
          children: ['Change management', 'Onboarding/offboarding', 'Playbooks'],
        },
        {
          label: 'External considerations',
          children: [
            'Regulatory',
            'Legal',
            'Industry',
            'Local/regional',
            'National',
            'Global',
          ],
        },
        'Monitoring and revision',
        {
          label: 'Types of governance structures',
          children: [
            'Boards',
            'Committees',
            'Government entities',
            'Centralized/decentralized',
          ],
        },
        {
          label: 'Roles and responsibilities for systems and data',
          children: ['Owners', 'Controllers', 'Processors', 'Custodians/stewards'],
        },
      ],
    },
    {
      id: '5.2',
      title: 'Explain elements of the risk management process.',
      topics: [
        'Risk identification',
        {
          label: 'Risk assessment',
          children: ['Ad hoc', 'Recurring', 'One-time', 'Continuous'],
        },
        {
          label: 'Risk analysis',
          children: [
            'Qualitative',
            'Quantitative',
            'Single loss expectancy (SLE)',
            'Annualized loss expectancy (ALE)',
            'Annualized rate of occurrence (ARO)',
            'Probability',
            'Likelihood',
            'Exposure factor',
            'Impact',
          ],
        },
        {
          label: 'Risk register',
          children: ['Key risk indicators', 'Risk owners', 'Risk threshold'],
        },
        'Risk tolerance',
        {
          label: 'Risk appetite',
          children: ['Expansionary', 'Conservative', 'Neutral'],
        },
        {
          label: 'Risk management strategies',
          children: [
            'Transfer',
            {
              label: 'Accept',
              children: ['Exemption', 'Exception'],
            },
            'Avoid',
            'Mitigate',
          ],
        },
        'Risk reporting',
        {
          label: 'Business impact analysis',
          children: [
            'Recovery time objective (RTO)',
            'Recovery point objective (RPO)',
            'Mean time to repair (MTTR)',
            'Mean time between failures (MTBF)',
          ],
        },
      ],
    },
    {
      id: '5.3',
      title:
        'Explain the processes associated with third-party risk assessment and management.',
      topics: [
        {
          label: 'Vendor assessment',
          children: [
            'Penetration testing',
            'Right-to-audit clause',
            'Evidence of internal audits',
            'Independent assessments',
            'Supply chain analysis',
          ],
        },
        {
          label: 'Vendor selection',
          children: ['Due diligence', 'Conflict of interest'],
        },
        {
          label: 'Agreement types',
          children: [
            'Service-level agreement (SLA)',
            'Memorandum of agreement (MOA)',
            'Memorandum of understanding (MOU)',
            'Master service agreement (MSA)',
            'Work order (WO)/statement of work (SOW)',
            'Non-disclosure agreement (NDA)',
            'Business partners agreement (BPA)',
          ],
        },
        'Vendor monitoring',
        'Questionnaires',
        'Rules of engagement',
      ],
    },
    {
      id: '5.4',
      title: 'Summarize elements of effective security compliance.',
      topics: [
        {
          label: 'Compliance reporting',
          children: ['Internal', 'External'],
        },
        {
          label: 'Consequences of non-compliance',
          children: [
            'Fines',
            'Sanctions',
            'Reputational damage',
            'Loss of license',
            'Contractual impacts',
          ],
        },
        {
          label: 'Compliance monitoring',
          children: [
            'Due diligence/care',
            'Attestation and acknowledgement',
            'Internal and external',
            'Automation',
          ],
        },
        {
          label: 'Privacy',
          children: [
            {
              label: 'Legal implications',
              children: ['Local/regional', 'National', 'Global'],
            },
            'Data subject',
            'Controller vs. processor',
            'Ownership',
            'Data inventory and retention',
            'Right to be forgotten',
          ],
        },
      ],
    },
    {
      id: '5.5',
      title: 'Explain types and purposes of audits and assessments.',
      topics: [
        'Attestation',
        {
          label: 'Internal',
          children: ['Compliance', 'Audit committee', 'Self-assessments'],
        },
        {
          label: 'External',
          children: [
            'Regulatory',
            'Examinations',
            'Assessment',
            'Independent third-party audit',
          ],
        },
        {
          label: 'Penetration testing',
          children: [
            'Physical',
            'Offensive',
            'Defensive',
            'Integrated',
            'Known environment',
            'Partially known environment',
            'Unknown environment',
            {
              label: 'Reconnaissance',
              children: ['Passive', 'Active'],
            },
          ],
        },
      ],
    },
    {
      id: '5.6',
      title: 'Given a scenario, implement security awareness practices.',
      topics: [
        {
          label: 'Phishing',
          children: [
            'Campaigns',
            'Recognizing a phishing attempt',
            'Responding to reported suspicious messages',
          ],
        },
        {
          label: 'Anomalous behavior recognition',
          children: ['Risky', 'Unexpected', 'Unintentional'],
        },
        {
          label: 'User guidance and training',
          children: [
            'Policy/handbooks',
            'Situational awareness',
            'Insider threat',
            'Password management',
            'Removable media and cables',
            'Social engineering',
            'Operational security',
            'Hybrid/remote work environments',
          ],
        },
        {
          label: 'Reporting and monitoring',
          children: ['Initial', 'Recurring'],
        },
        'Development',
        'Execution',
      ],
    },
  ],
};

export const getObjectives = (domainId) => objectives[domainId] || [];

export const hasObjectives = (domainId) => getObjectives(domainId).length > 0;

/** Counts every leaf term in a domain, for the "N terms" summary. */
export const countTerms = (domainId) => {
  const walk = (topics) =>
    topics.reduce(
      (sum, topic) =>
        typeof topic === 'string' ? sum + 1 : sum + 1 + walk(topic.children || []),
      0
    );
  return getObjectives(domainId).reduce((sum, o) => sum + walk(o.topics), 0);
};

export default objectives;
