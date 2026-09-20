// Domain 1: General Security Concepts — why each wrong choice is wrong.
// Keyed by question text, then wrong-choice text. See ../choiceRationales.js.

export default {
  "What does the CIA triad stand for in information security?": {
    "Computer, Internet, Application": "Those are parts of an IT environment, not security goals. The triad names what security protects.",
    "Control, Identification, Authentication": "These are access-control ideas that help achieve security, but they aren't the three goals the triad names.",
    "Cryptography, Identity, Access": "Cryptography and identity are tools for reaching security goals. The triad lists the goals themselves.",
  },
  "Which type of security control is a firewall?": {
    "Physical": "Physical controls are tangible barriers like locks, fences and guards. A firewall enforces rules with technology.",
    "Administrative": "Administrative (managerial) controls are policies and procedures written by people, not devices that filter traffic.",
    "Procedural": "A procedure is a set of steps people follow. A firewall filters traffic automatically, which makes it technical.",
  },
  "What is authentication?": {
    "Granting access to resources": "That's authorization, which happens after authentication has proven who you are.",
    "Encrypting sensitive data": "Encryption keeps data confidential. It doesn't confirm who a user is.",
    "Logging user activities": "That's accounting: recording what an authenticated user did.",
  },
  "Which authentication factor is a fingerprint scan?": {
    "Something you know": "Knowledge factors are secrets you remember, like passwords or PINs. A fingerprint is part of your body.",
    "Something you have": "Possession factors are objects you carry, like a smart card or hardware token.",
    "Somewhere you are": "Location factors check where you are (GPS, IP address), not a physical trait.",
  },
  "What is the primary purpose of encryption?": {
    "To prevent unauthorized access to systems": "That's the job of access controls. Encrypted data can still be reached; it just can't be read without the key.",
    "To verify data integrity": "Close, but integrity is checked with hashing or digital signatures. Encryption's main goal is keeping data secret.",
    "To improve system performance": "Encryption adds processing overhead; it never speeds a system up.",
  },
  "In a zero-trust security model, which principle is fundamental?": {
    "Trust but verify": "That's the older mindset of trusting first and checking later. Zero trust grants nothing until each request is verified.",
    "Trust all internal users": "Zero trust rejects the idea that being inside the network makes a user trustworthy.",
    "Verify once, trust forever": "Zero trust keeps re-verifying throughout a session instead of trusting after one check.",
  },
  "What is the purpose of a security policy?": {
    "To install software": "Installing software is an operational task. A policy states the rules such tasks must follow.",
    "To encrypt data": "Encryption is a technical control. A policy may require it, but doesn't perform it.",
    "To monitor networks": "Monitoring is done by tools like a SIEM or IDS. A policy defines what should be monitored and why.",
  },
  "What is defense in depth?": {
    "Using one strong security control": "One control is a single point of failure. Defense in depth assumes any single layer can be bypassed.",
    "Focusing only on perimeter security": "A perimeter-only design leaves nothing behind the wall once an attacker gets through.",
    "Relying solely on firewalls": "A firewall is just one layer. Defense in depth combines it with endpoint protection, access control, monitoring and more.",
  },
  "What is the principle of least privilege?": {
    "Give everyone admin access": "Universal admin rights are the opposite: one compromised account could control everything.",
    "Allow all access by default": "Allowing everything is 'implicit allow'. Least privilege starts from nothing and adds only what's needed.",
    "Share passwords freely": "Shared passwords break accountability and have nothing to do with limiting permissions.",
  },
  "What is authorization?": {
    "Verifying identity": "That's authentication. Authorization comes next and decides what the verified user may access.",
    "Encrypting data": "Encryption keeps data confidential. It doesn't decide who may use a resource.",
    "Logging events": "Logging is accounting: the record of what users did after being authorized.",
  },
  "What is non-repudiation?": {
    "Denying access": "Denying access is an authorization decision. Non-repudiation is proof that can't be disputed later.",
    "Encrypting messages": "Encryption hides content but doesn't prove who sent it. Digital signatures provide non-repudiation.",
    "Backing up data": "Backups support availability and recovery, not proof of who did what.",
  },
  "What is separation of duties?": {
    "Working alone": "One person handling a whole sensitive process is exactly the fraud risk this control removes.",
    "Combining all tasks": "Combining tasks concentrates power. Separation of duties splits critical steps between people.",
    "Eliminating oversight": "It adds oversight: each person's part acts as a check on the others.",
  },
  "What is asset management?": {
    "Selling assets": "Selling is one possible end of an asset's life. Asset management covers tracking it the whole way.",
    "Buying hardware": "Procurement is one step. Asset management is the ongoing inventory, ownership and protection of assets.",
    "Disposing equipment": "Secure disposal is the final lifecycle stage, not the whole practice.",
  },
  "What is security through obscurity?": {
    "Strong security practice": "Hiding how something works isn't strong security: once the secret leaks, nothing else protects the system.",
    "Best practice approach": "Best practice treats obscurity as, at most, an extra layer, never the main defense.",
    "Required security measure": "No framework requires it. A design should stay secure even when it's public.",
  },
  "What is access control?": {
    "Opening doors": "A door is one thing access control can govern. The concept covers any resource, physical or digital.",
    "Installing locks": "Locks are one physical access control. Access control is the broader practice of deciding who may use what.",
    "Creating passwords": "Passwords are an authentication method that supports access control, not access control itself.",
  },
  "What is role-based access control (RBAC)?": {
    "Access based on time": "Time-of-day limits are a rule- or attribute-based condition, not a role.",
    "Access based on location": "Location is an attribute used by ABAC or conditional access, not by RBAC.",
    "Random access": "Access control is never random. RBAC maps permissions to defined job roles.",
  },
  "What is mandatory access control (MAC)?": {
    "Optional security": "MAC is the strictest model. Users can't opt out or change the labels.",
    "User-controlled access": "That's discretionary access control (DAC), where the owner decides. MAC is enforced by the system.",
    "No access control": "MAC is an access control model: the most rigid one, based on classification labels.",
  },
  "What is a security control?": {
    "A network device": "A device like a firewall can implement a control, but controls also include policies and physical measures.",
    "A password": "A password is one example of a control. The term covers any safeguard that reduces risk.",
    "An encryption key": "A key is part of one technical control, not the definition of a control.",
  },
  "What is the difference between preventive and detective controls?": {
    "No difference": "They differ in timing: preventive controls act before an incident, detective controls during or after it.",
    "Detective stops attacks": "That's reversed. Detective controls, like an IDS or audit logs, spot attacks; preventive ones block them.",
    "Both are the same": "A lock prevents entry; a camera detects it. Related goal, different roles.",
  },
  "What is the purpose of hashing?": {
    "To encrypt data": "Hashing is one-way: you can't get the original back. Encryption is reversible with the key.",
    "To compress files": "A hash is a fixed-size fingerprint, not a smaller copy you can expand again.",
    "To create backups": "A hash can't restore data. It only tells you whether data has changed.",
  },
  "What is attribute-based access control (ABAC)?": {
    "Access based on job titles": "Job titles point to RBAC. ABAC weighs several attributes together, such as role, time, location and device.",
    "Access based on passwords only": "A password proves identity. ABAC decides access after that, using many attributes.",
    "No access control": "ABAC is a fine-grained access control model, not the absence of one.",
  },
  "What is the difference between identification and authentication?": {
    "They are the same": "Typing a username identifies you; entering the password proves it. They are separate steps.",
    "Authentication comes first": "You have to claim an identity before you can prove it, so identification comes first.",
    "Identification is stronger": "Identification alone proves nothing, since anyone can type a username. Authentication supplies the proof.",
  },
  "What is accounting in security?": {
    "Financial records": "In AAA, accounting means recording user activity, not bookkeeping.",
    "Creating accounts": "That's provisioning. Accounting tracks what accounts do once they exist.",
    "Deleting logs": "Deleting logs destroys the audit trail that accounting creates.",
  },
  "What is implicit deny?": {
    "Allowing everything": "That's implicit allow, the opposite. Implicit deny blocks anything not explicitly permitted.",
    "Random access": "Implicit deny is predictable: whatever no rule allows is blocked.",
    "No rules": "Implicit deny is itself a rule, usually the final 'deny all' at the end of an ACL.",
  },
  "What is a compensating control?": {
    "Primary control": "A compensating control stands in when the primary control can't be used.",
    "Backup system": "A backup provides recovery. A compensating control is an alternative safeguard meeting the same requirement.",
    "Extra security": "It isn't an extra layer on top; it replaces a control that isn't feasible.",
  },
  "What is confidentiality?": {
    "Data availability": "Availability is a different part of the CIA triad: data being reachable when needed.",
    "Data speed": "Speed is performance, not a security goal.",
    "Data location": "Where data lives matters for sovereignty, but confidentiality is about who can read it.",
  },
  "What is security posture?": {
    "Physical stance": "Posture here is figurative: how well the organization is defended overall.",
    "Security job": "A job is a role. Posture describes the organization's overall security state.",
    "Network speed": "Speed is performance. Posture is about controls, risks and readiness.",
  },
  "What is integrity in security?": {
    "Honesty": "In security, integrity describes data being accurate and unaltered, not a personal quality.",
    "Data storage": "Storing data doesn't make it trustworthy. Integrity means it isn't changed without authorization.",
    "Network speed": "Speed is performance, not a security property.",
  },
  "What is risk appetite?": {
    "Fear of risk": "Appetite isn't an emotion. It's a deliberate statement of how much risk leadership will take on.",
    "No risk tolerance": "Zero risk is impossible. Every organization accepts some, and appetite defines how much.",
    "Maximum risk": "Appetite is the level the organization is willing to accept, not the most it could face.",
  },
  "What is due care?": {
    "Not caring": "Due care is the opposite: acting responsibly to protect assets.",
    "Maximum effort": "Due care asks for reasonable, prudent effort, not unlimited effort.",
    "Minimal effort": "The bare minimum can amount to negligence. Due care is what a reasonable person would do.",
  },
  "What is availability?": {
    "Data speed": "A fast system can still be down. Availability means authorized users can reach data when they need it.",
    "Data storage": "Storing data doesn't guarantee access. Availability is about uptime for authorized users.",
    "Data encryption": "Encryption serves confidentiality, a different part of the CIA triad.",
  },
  "What is discretionary access control (DAC)?": {
    "System-controlled access": "System-enforced labels describe MAC. In DAC, the resource owner decides.",
    "No access control": "DAC is an access control model: the owner grants and revokes access.",
    "Random access": "DAC permissions are set deliberately by the owner.",
  },
  "What is context-aware authentication?": {
    "Basic login": "A basic login checks only credentials. Context-aware authentication also weighs location, time and device.",
    "No authentication": "It's a stronger form of authentication, not the absence of it.",
    "Single factor": "Single-factor login ignores context. Context-aware systems adapt to the circumstances of each login.",
  },
  "What is a password policy?": {
    "Random rules": "A policy is deliberate and consistent. Random rules couldn't be enforced or audited.",
    "No rules": "A password policy exists to set rules, such as length, complexity and reuse limits.",
    "Optional guidelines": "Guidelines are recommendations. A policy is mandatory and enforced.",
  },
  "What is single sign-on (SSO)?": {
    "Multiple logins": "That's life without SSO. With SSO, one authentication opens many systems.",
    "No login": "You still log in once. SSO removes the repeat logins, not authentication.",
    "Complex authentication": "SSO simplifies things for the user, even when it's backed by strong MFA.",
  },
  "What is federated identity?": {
    "Single organization identity": "An identity limited to one organization is local. Federation extends trust across organizations.",
    "No identity": "Federation relies on a verified identity and shares it with partners, using protocols like SAML.",
    "Local identity only": "Local-only accounts are what federation replaces, so users don't need a separate account everywhere.",
  },
  "What is biometric authentication?": {
    "Password only": "A password is something you know. Biometrics are something you are.",
    "Card reader": "A card is something you have, a possession factor.",
    "PIN code": "A PIN is a knowledge factor, like a password.",
  },
  "What is time-based access control?": {
    "Permanent access": "Time-based control is the opposite: access is valid only during set hours or periods.",
    "No time limits": "Time limits are the whole point of time-based access control.",
    "Random timing": "The time windows are defined by policy, not random.",
  },
  "What is continuous authentication?": {
    "One-time login": "A single check at login is traditional authentication. Continuous authentication keeps checking during the session.",
    "No authentication": "It's more authentication, not none.",
    "Login only": "Checking only at login is what continuous authentication improves on.",
  },
  "What is multifactor authentication?": {
    "Single password": "A password alone is single-factor authentication.",
    "No password": "MFA may or may not include a password. What matters is combining factors from different categories.",
    "Easy login": "MFA adds a step to make logins harder to abuse, not easier.",
  },
  "What is risk assessment?": {
    "Ignoring risks": "Assessment is the opposite: finding and measuring risks so they can be handled.",
    "Creating risks": "It identifies existing risks. It doesn't introduce new ones.",
    "Accepting all risks": "Acceptance is one possible response decided after assessment, not the assessment itself.",
  },
  "What is a security token?": {
    "Password": "A password is something you know. A token is something you have.",
    "Username": "A username only identifies you. It isn't a device and proves nothing.",
    "Email address": "An email address is an identifier, not an authentication device.",
  },
  "What is risk mitigation?": {
    "Ignoring risk": "Ignoring a risk isn't a valid response. Mitigation actively reduces it.",
    "Increasing risk": "Mitigation lowers a risk's likelihood or impact.",
    "Accepting risk": "Acceptance means living with the risk as it is. Mitigation adds controls to reduce it.",
  },
  "What is risk avoidance?": {
    "Accepting risk": "Acceptance keeps the activity and its risk. Avoidance stops doing the activity.",
    "Ignoring risk": "Ignoring isn't a response. Avoidance is a deliberate decision to stop.",
    "Increasing risk": "Avoidance removes the risk entirely by not engaging in the activity.",
  },
  "What is data classification?": {
    "Random sorting": "Classification follows defined labels (public, internal, confidential) based on sensitivity.",
    "Deleting data": "Classification decides how data is handled. Deletion is a separate lifecycle step.",
    "Encrypting data": "Some classifications require encryption, but labeling the data comes first.",
  },
  "What is job rotation?": {
    "Staying in same job": "Staying put is what job rotation changes, so fraud hidden in one role gets uncovered.",
    "Never changing": "Rotation means moving people between roles periodically.",
    "Random assignments": "Rotation is planned and periodic, not random.",
  },
  "What is mandatory vacation?": {
    "Optional time off": "It's required, so someone else covers the role long enough to spot irregularities.",
    "No vacation": "Skipping vacations lets someone hide ongoing fraud, which this control prevents.",
    "Unlimited vacation": "The control forces a minimum absence; it isn't about unlimited leave.",
  },
  "What is encryption?": {
    "Deleting data": "Encrypted data still exists. It's just unreadable without the key.",
    "Copying data": "Encryption transforms data. It doesn't duplicate it.",
    "Storing data": "Storage is where data sits. Encryption is what makes it unreadable there.",
  },
  "What is data masking?": {
    "Deleting data": "Masked data stays usable, like showing the last four digits of a card. Nothing is deleted.",
    "Encrypting everything": "Masking hides only the sensitive parts and usually can't be reversed, unlike encryption.",
    "Copying data": "Masking changes what's shown or shared, not how many copies exist.",
  },
  "What is tokenization?": {
    "Creating coins": "The tokens are random stand-in values, not cryptocurrency.",
    "Encrypting data": "Close, but a token has no mathematical link to the original. The real value is kept in a secure token vault.",
    "Deleting data": "The original still exists in the vault. Tokens replace it everywhere else.",
  },
  "What is physical security?": {
    "Software only": "Software protection is logical security. Physical security covers buildings, rooms and hardware.",
    "Network security": "Network security protects data in transit. Physical security protects tangible assets.",
    "Cloud security": "Cloud security covers hosted services. Physical security covers things like doors, guards and cameras.",
  },
  "What is environmental control?": {
    "Outdoor security": "Environmental controls manage conditions like temperature, humidity and fire suppression, not the outdoors.",
    "Software control": "These are physical systems such as HVAC and fire suppression, not software.",
    "Network control": "Network controls filter traffic. Environmental controls keep equipment in safe operating conditions.",
  },
  "What is security convergence?": {
    "Separation": "Convergence is the opposite: bringing physical and cyber security together.",
    "Physical only": "Convergence combines physical security with logical (information) security.",
    "Logical only": "Logical security alone isn't convergence. The term means merging it with physical security.",
  },
  "What is need-to-know?": {
    "Everyone knows everything": "Need-to-know limits information to people whose job requires it.",
    "No restrictions": "It's a restriction, even for people who hold a high clearance.",
    "Full access": "Full access contradicts need-to-know, which grants only what a task requires.",
  },
  "What is security awareness?": {
    "Ignoring security": "Awareness is the opposite: knowing the threats and how to respond.",
    "Technical skills only": "Awareness is for everyone, not just technical staff, like recognizing a phishing email.",
    "Programming": "Programming is a technical skill. Awareness is understanding threats and safe behavior.",
  },
  "What is security governance?": {
    "No oversight": "Governance is oversight: leadership setting direction, policy and accountability.",
    "Random activities": "Governance makes security work structured and aligned with business goals.",
    "Technical tasks only": "Governance works at the strategic level (policy, roles, accountability), not just technical work.",
  },
  "What is acceptable use policy?": {
    "No rules": "An AUP is a set of rules for how company resources may be used.",
    "Optional guidelines": "Users typically must agree to the AUP, and breaking it has consequences.",
    "Ignored document": "An AUP is enforceable: users acknowledge it, and it backs disciplinary action.",
  },
  "What is clean desk policy?": {
    "Never clean": "The policy requires clearing sensitive material from workspaces.",
    "Messy workspace": "Leaving papers and devices out is exactly what the policy prevents.",
    "No policy": "It's a named administrative policy covering documents, notes and unattended screens.",
  },
  "What is data sovereignty?": {
    "No rules": "Sovereignty means rules do apply: those of the country where the data resides.",
    "Global rules only": "There's no single global law. Each country's own laws govern data stored there.",
    "No restrictions": "Sovereignty adds restrictions, such as limits on moving data across borders.",
  },
  "What is privacy?": {
    "Public information": "Privacy concerns personal information and who controls it, not data that's already public.",
    "No control": "Privacy is about people having control over their personal data.",
    "Sharing everything": "Privacy limits sharing to what the person has agreed to.",
  },
  "What is personally identifiable information (PII)?": {
    "Public data": "Some PII is publicly visible, but PII is defined by identifying a person, not by being public.",
    "Anonymous data": "Anonymized data has had its identifiers removed, so it no longer counts as PII.",
    "Corporate data": "Business data like financials is sensitive, but PII is specifically about individuals.",
  },
  "What is privacy by design?": {
    "Added later": "Bolting privacy on afterwards is what privacy by design avoids.",
    "Optional privacy": "Privacy by design makes privacy the default, not an opt-in.",
    "No privacy": "It puts privacy at the center of system design.",
  },
  "What is a security incident?": {
    "Normal operation": "Normal activity is just an event. An incident threatens security and needs a response.",
    "Routine task": "Routine tasks are expected. Incidents are unexpected and potentially harmful.",
    "Scheduled activity": "Scheduled work like maintenance is planned. An incident is unplanned.",
  },
  "What is change control?": {
    "Random changes": "Change control makes changes planned, approved and documented.",
    "No oversight": "It adds oversight through reviews and approvals, often by a change advisory board.",
    "Breaking things": "Change control exists to stop changes from breaking systems.",
  },
  "What is configuration drift?": {
    "Desired state": "The desired state is the baseline. Drift is movement away from it.",
    "Planned changes": "Planned changes go through change control and update the baseline. Drift is unplanned.",
    "No changes": "Drift is change: unapproved changes that build up over time.",
  },
  "What is hardening?": {
    "Making difficult": "Hardening makes a system harder to attack, not harder to use, by removing unneeded services and settings.",
    "Softening": "Softening is the opposite. Hardening shrinks the attack surface.",
    "No security": "Hardening is a core security practice, like disabling unused ports and applying secure baselines.",
  },
  "What is attack surface?": {
    "Physical size": "Attack surface counts entry points (ports, services, accounts, interfaces), not physical size.",
    "No vulnerabilities": "Attack surface describes exposure, whether or not vulnerabilities have been found yet.",
    "One entry point": "It's the sum of all entry points, not just one.",
  },
  "What is defense evasion?": {
    "Strong defense": "The term describes attacker techniques for getting around defenses, not a defense.",
    "No evasion": "It's specifically about evading detection, such as disabling logs or obfuscating code.",
    "Detection method": "It's the attacker's side: techniques that defeat detection methods.",
  },
  "What is secure by default?": {
    "Insecure start": "Secure by default means the out-of-box settings are already secure.",
    "No security": "Security is on from the start, with nothing for the user to configure.",
    "Optional security": "Users shouldn't have to opt in. Secure settings are the default.",
  },
  "What is fail secure?": {
    "Failing open": "Fail open allows access when something breaks. Fail secure (fail closed) blocks it.",
    "No security": "Fail secure keeps protection in place even while the system is failing.",
    "Breaking completely": "The point is to fail into a controlled, locked-down state, not unpredictably.",
  },
  "What is trust but verify?": {
    "Blind trust": "Blind trust skips the 'verify' half of the phrase.",
    "No verification": "Verification is half of the principle.",
    "No trust": "Starting with no trust at all is zero trust, not trust but verify.",
  },
  "What is least privilege?": {
    "Maximum access": "Least privilege is the opposite: the minimum access a job requires.",
    "No access": "Users still get what they need for their job, just nothing more.",
    "Full admin access": "Admin rights for everyone violate least privilege.",
  },
  "What is zero trust?": {
    "Trust everyone": "Zero trust trusts no one by default, inside or outside the network.",
    "Blind trust": "Zero trust verifies every request, the opposite of blind trust.",
    "No security": "Zero trust is a strict model built on continuous verification.",
  },
  "What is detective control?": {
    "Preventing attacks": "Stopping attacks is preventive. Detective controls find attacks that are happening or have happened.",
    "Recovering systems": "Recovery is corrective. Detective controls identify, alert and log.",
    "No detection": "Detection is the whole purpose, as with an IDS, SIEM or audit logs.",
  },
  "What is corrective control?": {
    "Preventing issues": "Prevention is preventive. Corrective controls act after something has happened.",
    "Detecting issues": "Detection comes first. Corrective controls then fix the damage, like restoring from backup.",
    "No action": "Corrective controls take action to repair or limit damage.",
  },
  "What is preventive control?": {
    "Detecting threats": "Detection is the job of detective controls, which act during or after an event.",
    "Fixing issues": "Fixing is corrective, which happens after an incident.",
    "Responding to threats": "Response happens once a threat appears. Preventive controls stop it beforehand.",
  },
  "What is deterrent control?": {
    "Encouraging attacks": "Deterrents do the opposite: warning signs and visible cameras discourage attackers.",
    "No effect": "Deterrents work psychologically by making an attacker think twice.",
    "Attracting threats": "Attracting attackers is what honeypots do. Deterrents push them away.",
  },
  "What is administrative control?": {
    "Technical tools": "Tools and software are technical controls.",
    "Physical barriers": "Barriers like fences and locks are physical controls.",
    "No controls": "Administrative controls are real controls: policies, procedures, training and background checks.",
  },
  "What is technical control?": {
    "Policies only": "Policies are administrative (managerial) controls.",
    "Physical locks": "Locks are physical controls.",
    "Procedures": "Procedures are administrative or operational controls carried out by people.",
  },
  "What is physical control?": {
    "Software": "Software-based safeguards are technical controls.",
    "Policies": "Policies are administrative controls.",
    "Networks": "Network safeguards like firewalls are technical controls.",
  },
  "What is attribute-based access control?": {
    "Role-based only": "Using only the role is RBAC. ABAC can combine role with many other attributes.",
    "No attributes": "Attributes are the basis of ABAC.",
    "Manual control": "ABAC evaluates its policies automatically for every request.",
  },
  "What is role-based access control?": {
    "User-based": "Granting permissions to individual users one by one is closer to DAC. RBAC grants them to roles.",
    "No roles": "Roles are the core of RBAC.",
    "Random access": "RBAC permissions follow defined job roles, not chance.",
  },
  "What is mandatory access control?": {
    "Optional control": "MAC is mandatory by definition. Users can't change it.",
    "User choice": "Letting users choose is DAC. MAC is enforced by the system using labels.",
    "No control": "MAC is the strictest access control model.",
  },
  "What is rule-based access control?": {
    "No rules": "Rules are the basis of this model, like firewall ACLs or time-of-day rules.",
    "Role-based": "Easy to mix up, since both shorten to RBAC. Role-based uses job roles; rule-based applies the same rules to everyone.",
    "Random": "Rule-based decisions follow predefined conditions.",
  },
  "What is authentication factor?": {
    "Random number": "A one-time code can be used as a factor, but a factor is a category of evidence: know, have, are, and so on.",
    "Username": "A username is identification. It claims an identity but proves nothing.",
    "Email": "An email address is an identifier, not proof of identity.",
  },
  "What is something you know?": {
    "Something you have": "That's the possession factor, like a phone or token.",
    "Biometric": "Biometrics are something you are.",
    "Location": "Location is somewhere you are.",
  },
  "What is something you have?": {
    "Password": "A password is something you know.",
    "Biometric": "A biometric is something you are.",
    "Knowledge": "Knowledge is the something-you-know factor.",
  },
  "What is something you are?": {
    "Username": "A username is identification, not an authentication factor.",
    "Password": "A password is something you know.",
    "Token": "A token is something you have.",
  },
  "What is somewhere you are?": {
    "Home address": "It isn't a stored address. The system checks your current location, for example by GPS or IP.",
    "Office": "An office is one possible location. The factor is the location check itself.",
    "Country": "Country can be one level of detail, but the factor is location-based authentication in general.",
  },
  "What is something you do?": {
    "Job description": "The factor measures behavior like typing rhythm or gait, not your job.",
    "Daily routine": "It uses measurable behavioral patterns, like keystroke dynamics, not your schedule.",
    "Hobby": "It refers to behavioral biometrics, not your interests.",
  },
  "What is dual control?": {
    "Single person": "Dual control requires two people, so no one can act alone.",
    "No control": "It's a control that requires two people to act together.",
    "Triple control": "Dual means exactly two, as with two keys needed to open a vault.",
  },
  "What is security awareness culture?": {
    "Ignoring security": "A security culture is the opposite: everyone paying attention to security.",
    "IT only": "Culture spans the whole organization, not just the IT team.",
    "No culture": "It's a deliberate, shared mindset across the organization.",
  },
  "What is principle of least common mechanism?": {
    "Share everything": "Shared mechanisms give problems a path to spread. This principle minimizes sharing.",
    "Maximum sharing": "The principle calls for the least sharing of mechanisms between users or processes.",
    "No isolation": "It favors isolation, so one user's compromise doesn't reach others.",
  },
  "What is fail safe?": {
    "Never fail": "Every system can fail. Fail safe is about failing without causing harm.",
    "Complete failure": "Fail safe means failing into a controlled, harmless state, not collapsing.",
    "No safety": "Safety during failure is the whole point.",
  },
  "What is keep it simple?": {
    "Complex is better": "Complexity hides bugs and misconfigurations. Simple designs are easier to secure.",
    "Overcomplicate": "Overcomplicating a design adds attack surface and room for mistakes.",
    "Random complexity": "The principle calls for as little complexity as possible.",
  },
  "What is privacy threshold assessment?": {
    "No assessment": "A PTA is an assessment: the first screening step.",
    "Ignoring privacy": "A PTA checks whether a system handles PII.",
    "Random check": "A PTA is a structured screening that decides whether a full privacy impact assessment (PIA) is needed.",
  },
  "What is risk register?": {
    "Cash register": "In risk management, a register is a record of risks, owners, ratings and responses.",
    "Shopping list": "It's a formal tracking document for risks.",
    "Phone book": "It records risks, not contacts.",
  },
  "What is risk acceptance?": {
    "Ignoring risk": "Acceptance is a documented, deliberate decision. Ignoring a risk isn't.",
    "Avoiding risk": "Avoidance stops the activity. Acceptance continues it knowingly.",
    "Transferring risk": "Transference shifts the risk elsewhere, like to an insurer. Acceptance keeps it.",
  },
  "What is residual risk?": {
    "No risk": "Controls rarely remove risk entirely. What's left over is residual risk.",
    "Original risk": "Risk before any controls is inherent risk.",
    "Future risk": "Residual risk is what remains now, after controls, not a forecast.",
  },
  "What is inherent risk?": {
    "Final risk": "The risk left at the end, after controls, is residual risk.",
    "No risk": "Inherent risk is the full, untreated risk.",
    "Controlled risk": "Once controls are applied, what remains is residual risk.",
  },
  "What is qualitative risk assessment?": {
    "Exact numbers": "Exact figures are quantitative. Qualitative uses ratings like high, medium and low.",
    "Mathematical only": "Formula-based analysis, like ALE, is quantitative.",
    "No assessment": "Qualitative assessment is a real method based on expert judgment.",
  },
  "What is quantitative risk assessment?": {
    "Subjective only": "Subjective ratings are qualitative. Quantitative uses numbers like SLE, ARO and ALE.",
    "No numbers": "Numbers are what make it quantitative.",
    "Guessing": "It relies on data such as asset value and how often incidents occur.",
  },
  "What is single loss expectancy?": {
    "Total loss": "The total over a year is ALE. SLE is the loss from one occurrence (asset value × exposure factor).",
    "No loss": "SLE is the expected loss when the event happens once.",
    "Multiple losses": "Multiple occurrences come in through ARO when you calculate ALE.",
  },
  "What is annual loss expectancy?": {
    "Monthly loss": "ALE is annual: SLE × ARO (annualized rate of occurrence).",
    "Daily loss": "The A stands for annual, so it's a per-year figure.",
    "No loss": "ALE is the expected yearly loss from a risk.",
  },
};
