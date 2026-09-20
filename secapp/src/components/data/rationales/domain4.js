// Domain 4: Security Operations — why each wrong choice is wrong.
// Keyed by question text, then wrong-choice text.

export default {
  "What is multi-factor authentication (MFA)?": {
    "Using multiple passwords": "Two passwords are both something you know, so that's still one factor type. MFA needs different types.",
    "Logging in multiple times": "Repeated logins add nothing. MFA combines different kinds of proof in a single login.",
    "Using different usernames": "Usernames only identify you. MFA is about adding different authentication factors.",
  },
  "What does IDS stand for?": {
    "Internet Data Service": "IDS stands for Intrusion Detection System, which watches for suspicious activity.",
    "Internal Defense System": "The I and D are intrusion and detection.",
    "Identity Directory Service": "Directory services like LDAP store identities. An IDS detects intrusions.",
  },
  "What is the difference between IDS and IPS?": {
    "IDS prevents threats, IPS detects them": "That's reversed. An IDS detects and alerts; an IPS sits inline and blocks.",
    "There is no difference": "The key difference is action: an IPS can block traffic, an IDS only alerts.",
    "IDS is for internal networks, IPS is for external": "Either can be deployed anywhere. They differ in detecting versus preventing.",
  },
  "What is SOAR in security operations?": {
    "Security Operations and Response": "Close, but it leaves out orchestration and automation, which are SOAR's core.",
    "System Operations and Recovery": "SOAR is about security response automation, not system recovery.",
    "Secure Online Access Resource": "SOAR isn't an access resource. It automates security workflows.",
  },
  "What is patch management?": {
    "Breaking software": "Patches fix software, though testing is needed so updates don't break anything.",
    "Deleting software": "Patching updates software; it doesn't remove it.",
    "Installing malware": "Patch management closes the holes malware exploits.",
  },
  "What is a SIEM system?": {
    "Firewall": "A firewall is one of many log sources that feed a SIEM.",
    "Antivirus": "Antivirus protects endpoints. A SIEM correlates events from across the environment.",
    "Router": "A router forwards traffic and can send logs to a SIEM.",
  },
  "What is threat hunting?": {
    "Waiting for alerts": "Waiting for alerts is reactive. Threat hunting is proactive: searching before anything alerts.",
    "Ignoring threats": "Hunting actively searches for threats.",
    "Automatic detection": "Automated tools raise alerts. Hunters look for what those tools missed.",
  },
  "What is security awareness training?": {
    "Technical training only": "Awareness training is for all staff, covering things like phishing and password habits.",
    "Ignoring users": "It focuses on users, who are often the first target.",
    "Complex coding": "It's about recognizing threats, not programming.",
  },
  "What is log aggregation?": {
    "Deleting logs": "Aggregation collects logs; retention policies decide deletion.",
    "Ignoring logs": "Aggregating logs makes them easier to analyze.",
    "Creating logs": "Systems create logs. Aggregation gathers them in one place.",
  },
  "What is behavioral analytics?": {
    "User surveys": "It analyzes activity data automatically, not survey answers.",
    "Personality tests": "It builds a baseline of normal activity and flags deviations.",
    "Random checks": "It continuously compares behavior against a baseline.",
  },
  "What is account lockout?": {
    "Opening accounts": "Lockout disables an account after repeated failed logins.",
    "Creating accounts": "Creating accounts is provisioning. Lockout blocks brute-force attempts.",
    "Sharing accounts": "Lockout protects accounts; sharing them weakens security.",
  },
  "What is privileged access management (PAM)?": {
    "Regular user access": "PAM focuses on elevated accounts like administrators and service accounts.",
    "Public access": "PAM tightly controls high-risk access.",
    "No access control": "PAM is a strict access control, with password vaulting and session monitoring.",
  },
  "What is security orchestration?": {
    "Manual processes": "Orchestration connects tools so workflows run automatically.",
    "Ignoring security": "It makes security operations faster and more consistent.",
    "Random actions": "Orchestration follows defined playbooks.",
  },
  "What is vulnerability scanning?": {
    "Creating vulnerabilities": "Scanning finds existing weaknesses; it doesn't create them.",
    "Exploiting systems": "Exploitation is penetration testing. Scanning identifies and reports.",
    "Installing malware": "Scanners are legitimate security tools.",
  },
  "What is continuous monitoring?": {
    "Checking once yearly": "A yearly check is a point-in-time audit. Continuous monitoring is ongoing.",
    "No monitoring": "It's constant monitoring.",
    "Random checks": "Spot checks leave gaps. Continuous monitoring doesn't stop.",
  },
  "What is an audit log?": {
    "Shopping list": "An audit log records system and user activity.",
    "Phone book": "It records events, not contacts.",
    "Calendar": "Log entries are timestamped, but a log records activity, not appointments.",
  },
  "What is penetration testing?": {
    "Breaking systems intentionally": "Pen tests are authorized and scoped to find weaknesses, not to cause damage.",
    "Installing software": "Testers may use tools, but the goal is to simulate attacks.",
    "Creating users": "Pen testing assesses security; it isn't account administration.",
  },
  "What is purple teaming?": {
    "Using purple color": "Purple mixes red (attack) and blue (defense): the two teams working together.",
    "Single team": "It brings two teams together.",
    "No teamwork": "Collaboration is the whole point.",
  },
  "What is the purpose of antivirus software?": {
    "Speed up computer": "Antivirus uses resources; its job is catching malware.",
    "Create backups": "Backup software makes copies. Antivirus detects and removes malware.",
    "Browse internet": "Browsers do that. Antivirus protects against malicious code.",
  },
  "What is security automation?": {
    "Manual processes": "Automation replaces repetitive manual steps.",
    "Ignoring security": "Automation speeds up security work.",
    "Random actions": "Automated tasks follow defined rules and playbooks.",
  },
  "What is threat intelligence sharing?": {
    "Keeping threats secret": "Sharing helps everyone defend faster, for example through ISACs.",
    "Creating threats": "It's about sharing information on existing threats.",
    "Ignoring threats": "Sharing is an active defense practice.",
  },
  "What is endpoint detection and response (EDR)?": {
    "Email filtering": "Email filtering happens at the mail gateway. EDR runs on the endpoints.",
    "Network router": "Routers forward traffic. EDR monitors activity on devices.",
    "Backup system": "Backups support recovery. EDR detects and responds to threats.",
  },
  "What is deception technology?": {
    "Lying to users": "It deceives attackers, using decoys like honeypots, not users.",
    "Hiding systems": "Hiding is obscurity. Deception adds fake targets that trigger alerts.",
    "Fake security": "The decoys are fake, but the detection they provide is real.",
  },
  "What is configuration management?": {
    "Ignoring settings": "It tracks and controls settings.",
    "Random changes": "Changes are planned and documented against a baseline.",
    "Breaking systems": "It keeps systems stable and consistent.",
  },
  "What is baseline configuration?": {
    "Random settings": "A baseline is a defined, approved standard.",
    "Maximum settings": "It's the minimum secure standard every system must meet.",
    "No configuration": "The baseline is a specific configuration.",
  },
  "What is threat modeling?": {
    "Fashion modeling": "It's a structured analysis of how a system could be attacked, as with STRIDE.",
    "Ignoring threats": "It identifies and prioritizes threats.",
    "Creating threats": "It anticipates threats; it doesn't create them.",
  },
  "What is a firewall rule?": {
    "Legal regulation": "A firewall rule is a technical entry saying which traffic to allow or deny.",
    "Fire code": "It's about network traffic, not fire safety.",
    "Building code": "It's a network policy entry, like an ACL line.",
  },
  "What is asset inventory?": {
    "Shopping list": "An asset inventory lists what the organization owns and must protect.",
    "Price list": "Value may be recorded, but the inventory tracks assets, owners and locations.",
    "Phone book": "It lists hardware, software and data assets.",
  },
  "What is security analytics?": {
    "Ignoring data": "Analytics digs into data to find threats.",
    "Creating reports": "Reports may result, but analytics is the analysis that finds patterns.",
    "Deleting logs": "Analytics depends on keeping logs.",
  },
  "What is user provisioning?": {
    "Deleting users": "Removing access is deprovisioning.",
    "Locking accounts": "Lockout is a separate control against failed logins.",
    "Sharing passwords": "Provisioning creates individual accounts; sharing passwords breaks accountability.",
  },
  "What is certificate management?": {
    "Paper certificates": "It manages digital certificates: issuing, renewing and revoking them.",
    "Printing documents": "It's about the digital certificate lifecycle.",
    "Filing papers": "It tracks digital certificates so none expire unexpectedly.",
  },
  "What is security maturity model?": {
    "Age of security": "Maturity describes how capable a program is, not how old it is.",
    "Old security": "It measures progress through defined levels.",
    "New security": "It assesses where a program stands and how to improve it.",
  },
  "What is backup testing?": {
    "Ignoring backups": "Testing proves backups can actually be restored.",
    "Creating backups": "Creating backups comes first. Testing checks that they work.",
    "Deleting backups": "Testing verifies backups; it doesn't remove them.",
  },
  "What is security information sharing?": {
    "Keeping secrets": "It means exchanging threat data with trusted partners.",
    "No sharing": "Sharing is the whole practice.",
    "Private only": "It's shared, often through industry groups like ISACs.",
  },
  "What is vulnerability assessment?": {
    "Creating vulnerabilities": "An assessment finds weaknesses; it doesn't add them.",
    "Ignoring weaknesses": "It exists to find and rank weaknesses.",
    "No assessment": "It's a systematic evaluation.",
  },
  "What is security monitoring?": {
    "Ignoring security": "Monitoring watches continuously for threats.",
    "No oversight": "Monitoring is ongoing oversight.",
    "Random checks": "It's continuous, not random spot checks.",
  },
};
