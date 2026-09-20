// Domain 5: Security Program Management and Oversight — why each wrong
// choice is wrong. Keyed by question text, then wrong-choice text.

export default {
  "What is the primary goal of risk management?": {
    "Eliminate all risks": "Zero risk is impossible, or too expensive to be practical. The aim is to bring risk down to an acceptable level.",
    "Remove all vulnerabilities": "Not every vulnerability can or should be fixed. Risk management prioritizes by likelihood and impact.",
    "Perform daily security audits": "Audits are one activity. Risk management is the overall process of identifying and treating risk.",
  },
  "What does compliance mean in cybersecurity?": {
    "Ignoring security controls": "Compliance means meeting required controls, not ignoring them.",
    "Creating new vulnerabilities": "Compliance aims to reduce risk.",
    "Monitoring social media": "Monitoring may be one control, but compliance means following laws and standards.",
  },
  "What is a security policy?": {
    "A firewall rule": "A firewall rule is a technical setting. A policy is the high-level document the rule should reflect.",
    "A network diagram": "A diagram documents the architecture. A policy sets rules and expectations.",
    "A software patch": "A patch fixes code. A policy governs behavior and requirements.",
  },
  "What does PII stand for?": {
    "Primary Internal Information": "PII stands for Personally Identifiable Information.",
    "Protected Infrastructure Index": "PII is about people's data, not infrastructure.",
    "Public Internet Identifier": "PII can be private and sensitive; the I's stand for identifiable information.",
  },
  "Why is a Business Continuity Plan important?": {
    "It prevents phishing attacks": "Phishing prevention comes from training and filtering. A BCP keeps the business running through a disruption.",
    "It monitors emails": "A BCP is a plan, not a monitoring tool.",
    "It encrypts data": "Encryption is a technical control. A BCP covers continuing operations.",
  },
  "What does BYOD mean?": {
    "Backup Your Operational Data": "BYOD stands for Bring Your Own Device.",
    "Build Your Onsite Datacenter": "BYOD is about personal devices used for work.",
    "Block Your Online Downloads": "BYOD is a device ownership policy, not download control.",
  },
  "Why is security awareness training important?": {
    "It teaches hacking": "It teaches staff to recognize and avoid threats, not to attack.",
    "It replaces antivirus software": "Training complements technical controls; it can't replace them.",
    "It increases server speed": "It changes human behavior, not system performance.",
  },
  "Who approves high-level security decisions?": {
    "Interns": "Strategic security decisions need executive authority and accountability.",
    "Security analysts": "Analysts advise and carry out the work, but leadership owns strategic decisions and risk acceptance.",
    "Janitorial staff": "Governance decisions belong to executive leadership.",
  },
  "What is data retention?": {
    "Deleting data immediately": "Retention means keeping data for a required period before disposal.",
    "Encrypting all data": "Encryption protects data. Retention decides how long it's kept.",
    "Copying data to USB drives": "That's a data-handling risk, not a retention policy.",
  },
  "Why is documentation important?": {
    "It fixes vulnerabilities": "Documentation guides people. Patches and configuration changes fix vulnerabilities.",
    "It speeds up Wi-Fi": "Documentation doesn't change network performance.",
    "It blocks malware": "Technical controls block malware. Documentation makes practices consistent.",
  },
  "What does an Acceptable Use Policy (AUP) define?": {
    "Employee dress code": "An AUP covers how company IT resources may be used, not clothing.",
    "How to configure servers": "Server settings belong in baselines and procedures. The AUP is for users.",
    "How to schedule vacations": "That's HR policy, not acceptable use.",
  },
  "Why is physical security important?": {
    "It increases Wi-Fi bandwidth": "Physical security protects facilities and hardware, not network speed.",
    "It replaces encryption": "It works alongside technical controls like encryption, not instead of them.",
    "It prevents phishing": "Phishing is countered with training and filtering. Physical security stops people walking in.",
  },
  "What is an incident in cybersecurity?": {
    "A planned change": "Planned changes go through change management. Incidents are unplanned and harmful.",
    "A software update": "Routine updates are expected events, not incidents.",
    "A user request": "User requests are service tickets, not security incidents.",
  },
  "What is the first phase of the incident response lifecycle?": {
    "Detection": "Detection is second. You have to prepare tools, plans and people first.",
    "Eradication": "Eradication comes after detection and containment.",
    "Recovery": "Recovery is near the end, after eradication.",
  },
  "Who is considered the weakest link in security?": {
    "Servers": "Servers can be hardened and patched. People are harder to secure and are often targeted first.",
    "Firewalls": "Firewalls enforce rules consistently. Human error causes more breaches.",
    "Routers": "Routers are managed devices. Users are the most common entry point, as with phishing.",
  },
  "Why are audits performed?": {
    "To shut down old systems": "Decommissioning is an operational task. Audits check compliance and control effectiveness.",
    "To install new firewalls": "Audits may recommend changes, but they evaluate controls rather than install them.",
    "To encrypt data": "Audits check that controls like encryption are in place; they don't apply them.",
  },
  "Which of the following is considered regulated data?": {
    "Movie reviews": "Reviews are public opinion, not protected by data regulations.",
    "Sports scores": "Public information like scores isn't regulated data.",
    "Public announcements": "Announcements are meant to be public.",
  },
  "Why are backups important?": {
    "They make systems faster": "Backups can add load. Their value is recovery.",
    "They prevent all malware infections": "Backups don't stop infections; they help you recover afterwards.",
    "They monitor networks": "Monitoring tools do that. Backups preserve copies of data.",
  },
  "Which document explains how to protect sensitive data?": {
    "Travel Policy": "Travel policies cover business travel, not data protection.",
    "Holiday Schedule": "That's a calendar, not a data-handling rule.",
    "Financial Report": "It reports finances; it doesn't set data protection rules.",
  },
  "What is a security baseline?": {
    "A maximum security level": "A baseline is the minimum required configuration.",
    "An optional suggestion": "Baselines are mandatory standards.",
    "A backup tool": "A baseline is a configuration standard, not software.",
  },
  "Who typically conducts risk assessments?": {
    "Doctors": "Medical risk is a different field. IT risk is assessed by security professionals.",
    "Sales staff": "Sales may be interviewed, but trained security staff run the assessment.",
    "Interns": "Assessments need trained, experienced professionals.",
  },
  "What is change management?": {
    "Updating systems randomly": "Change management makes changes planned, reviewed and approved.",
    "Monitoring CPU usage": "That's performance monitoring.",
    "Resetting passwords": "Resetting passwords is routine support work, not change management.",
  },
  "What is a compliance violation?": {
    "A firewall is misconfigured": "A misconfiguration may lead to a violation, but a violation means failing a required law or standard.",
    "A user forgot a password": "Forgetting a password is a support issue.",
    "A server rebooted": "A reboot is an operational event.",
  },
  "Who responds to cybersecurity incidents?": {
    "Marketing Team": "Marketing may help with public messaging, but response is led by the IR team.",
    "Sales Team": "Sales isn't responsible for incident handling.",
    "Facilities": "Facilities may help with physical issues, but the IR team handles cyber incidents.",
  },
  "Why is data classification used?": {
    "To determine data size": "Size is storage. Classification is about sensitivity.",
    "To decide employee pay": "Pay is an HR matter.",
    "To improve battery life": "Classification decides how data must be protected.",
  },
  "What is a security standard?": {
    "A required uniform or dress code": "A security standard sets technical or procedural requirements, like a benchmark.",
    "A firewall vendor": "Vendors make products. Standards define how controls should be implemented.",
    "A user privilege list": "Privilege lists are access records, not standards.",
  },
  "What is the goal of privacy?": {
    "To hide company profits": "Privacy protects personal information, not business finances.",
    "To block internet traffic": "Blocking traffic is a network control.",
    "To restrict social media": "Social media rules are an acceptable-use matter, not the goal of privacy.",
  },
  "What is a corrective control?": {
    "A control that prevents issues": "Stopping issues before they happen is what preventive controls do.",
    "A control that detects issues": "Spotting issues is what detective controls do.",
    "A control that encrypts traffic": "Encryption is usually preventive. Corrective controls fix things after an incident.",
  },
  "What is the purpose of onboarding in cybersecurity?": {
    "Assigning job titles": "Titles are HR's job. Security onboarding sets up the right access and training.",
    "Scheduling vacations": "That's HR scheduling.",
    "Blocking websites": "Web filtering is a technical control, not onboarding.",
  },
  "Offboarding ensures what?": {
    "Higher salaries": "Offboarding is about removing access when someone leaves.",
    "That employees receive bonuses": "Bonuses are payroll matters.",
    "That systems reboot properly": "Offboarding revokes accounts and collects equipment.",
  },
  "What is a security audit?": {
    "An informal review": "An audit is formal and structured, often by an independent party.",
    "A malware scan": "A scan is a technical check. An audit evaluates controls and compliance.",
    "A network speed test": "Speed tests measure performance.",
  },
  "What is a risk register used for?": {
    "Tracking employee attendance": "Attendance is HR data. A risk register tracks risks.",
    "Managing software licenses": "That's license or asset management.",
    "Listing hardware devices": "That's an asset inventory. The register lists risks, owners and responses.",
  },
  "What is due diligence?": {
    "Ignoring risk": "Due diligence is the effort to understand and prevent risk.",
    "Installing antivirus software": "Installing a control is due care. Due diligence is the research and planning behind it.",
    "Performing daily vulnerability scans": "Scanning is one activity. Due diligence is the reasonable effort to investigate and prevent risk.",
  },
  "What does Data Loss Prevention (DLP) do?": {
    "Detect malware": "Malware detection is antivirus or EDR. DLP stops sensitive data from leaving.",
    "Increase Wi-Fi speed": "DLP inspects data flows; it doesn't improve performance.",
    "Monitor CPU usage": "That's system monitoring.",
  },
  "Why is vendor risk management important?": {
    "To compare prices": "Price is procurement. Vendor risk management checks a supplier's security.",
    "To schedule vendor meetings": "Meetings are logistics.",
    "To reduce payroll costs": "Payroll is unrelated. The concern is third-party risk.",
  },
  "What is qualitative risk analysis based on?": {
    "Numerical values": "Numbers describe quantitative analysis.",
    "Financial loss only": "Dollar figures are quantitative. Qualitative uses ratings like high, medium and low.",
    "Legal requirements": "Laws can influence risk decisions, but qualitative analysis is based on subjective ratings.",
  },
  "What is an SLA?": {
    "Security Log Agreement": "SLA stands for Service Level Agreement: uptime and response commitments.",
    "Software License Agreement": "A license agreement covers usage rights. An SLA covers service performance.",
    "Server Logging Application": "An SLA is a contract, not software.",
  },
  "Why is data minimization important?": {
    "To delete old computers": "Minimization is about collecting less data, not disposing of hardware.",
    "To increase system performance": "Less data may help performance, but the goal is lower risk and privacy compliance.",
    "To reduce training costs": "Its purpose is limiting the sensitive data you hold.",
  },
  "What is a tabletop exercise?": {
    "A physical drill": "Tabletops are discussion-based. People walk through a scenario without taking real action.",
    "A real attack simulation": "Live simulations are red team or technical exercises. A tabletop is talk-through only.",
    "A Wi-Fi penetration test": "Pen tests are hands-on technical testing.",
  },
  "What does a Privacy Impact Assessment (PIA) evaluate?": {
    "Server uptime": "Uptime is an availability metric. A PIA looks at personal data handling.",
    "Password strength": "Password audits are a separate technical check.",
    "Employee productivity": "A PIA assesses privacy risk, not productivity.",
  },
  "Why are internal audits performed?": {
    "To fire employees": "Audits evaluate controls, not individual employment.",
    "To replace external audits": "Internal audits complement external ones; regulations often require independent auditors.",
    "To reduce payroll": "Audits check compliance with policy.",
  },
  "Why is encryption part of data protection?": {
    "It organizes folders": "Folder structure is organization. Encryption makes data unreadable to unauthorized people.",
    "It blocks phishing emails": "Email filtering blocks phishing.",
    "It improves CPU speed": "Encryption uses CPU; it doesn't speed it up.",
  },
  "Why are disciplinary policies needed?": {
    "To ensure employees dress correctly": "Dress codes are separate HR rules. Disciplinary policies enforce security accountability.",
    "To schedule breaks": "Break scheduling is HR operations.",
    "To train interns": "Training is a separate program.",
  },
  "What is segregation of duties?": {
    "Having users perform all tasks": "One person doing everything is the risk this control removes.",
    "Letting employees choose their own tasks": "Duties are assigned deliberately so critical steps are split.",
    "Reducing team size": "It usually requires more people involved in a process, not fewer.",
  },
  "Why is access recertification required?": {
    "To renew software licenses": "License renewal is procurement. Recertification reviews user permissions.",
    "To assign raises": "Raises are HR decisions.",
    "To reset email passwords": "Password resets are support tasks.",
  },
  "What is the purpose of a security exception?": {
    "A user bypassing rules without approval": "An exception is formally approved and documented. Unapproved bypassing is a violation.",
    "A type of firewall rule": "Exceptions are policy deviations, not firewall entries.",
    "A malware warning": "A malware warning is an alert, not an approved deviation.",
  },
  "Which document lists step-by-step procedures?": {
    "Policy": "Policies state what must happen and why. SOPs give the step-by-step how.",
    "Privacy notice": "A privacy notice tells people how their data is used.",
    "Travel guidelines": "Travel guidelines don't cover operational procedures.",
  },
  "Why is training part of compliance programs?": {
    "To lower system performance": "Training affects people, not systems.",
    "To increase storage space": "Storage is unrelated. Training helps staff follow the rules.",
    "To improve website design": "Design is unrelated to compliance training.",
  },
  "What is a security control assessment (SCA)?": {
    "A phishing attack": "An SCA is a review, not an attack.",
    "A penetration test": "A pen test simulates attacks. An SCA reviews whether controls work as intended, often without exploiting anything.",
    "A software license audit": "License audits check usage rights, not security controls.",
  },
  "Which document defines how long logs must be kept?": {
    "Holiday schedule": "A retention policy sets how long logs and data are kept.",
    "Incident report": "An incident report describes an event, not retention periods.",
    "Firewall rule set": "Firewall rules control traffic, not how long logs are stored.",
  },
  "Why are mergers and acquisitions high-risk events?": {
    "They slow down internet speeds": "The risk comes from combining unknown systems, accounts and vulnerabilities.",
    "They require employees to relocate": "Relocation is a business concern, not the core security risk.",
    "They reduce available storage": "The risk is inheriting unknown systems and access.",
  },
  "Why is onboarding important for access control?": {
    "It gives users full administrative access": "That violates least privilege. Onboarding grants only what the role needs.",
    "It prevents phishing attacks": "Awareness training helps with phishing, but onboarding's access role is assigning correct permissions.",
    "It configures firewalls": "Firewall configuration is a separate technical task.",
  },
  "What is offboarding?": {
    "Training new employees": "Training new hires is part of onboarding.",
    "Giving users new laptops": "Handing out equipment is onboarding. Offboarding collects it.",
    "Resetting database passwords": "Rotating shared credentials may be part of offboarding, but the core is removing the departing user's access.",
  },
  "What is the goal of business impact analysis (BIA)?": {
    "Measure packet loss": "Packet loss is a network metric. A BIA ranks business functions by the impact of downtime.",
    "Improve Wi-Fi strength": "A BIA is a planning analysis, not network tuning.",
    "Monitor CPU performance": "That's system monitoring.",
  },
  "What does a data owner do?": {
    "Reviews HR complaints": "HR handles complaints. A data owner decides how data is classified and who may access it.",
    "Writes firewall rules": "Network engineers write firewall rules.",
    "Runs backup servers": "Running systems is the data custodian's job. The owner makes the decisions.",
  },
  "What is continuous improvement in security programs?": {
    "Updating software daily": "Patching is one task. Continuous improvement is steadily strengthening the whole program.",
    "Firing employees": "It improves controls and processes, not staffing.",
    "Replacing all hardware": "Improvement is gradual, based on lessons learned and metrics.",
  },
  "Why are metrics important in security governance?": {
    "They decorate reports": "Metrics give leadership evidence to make decisions.",
    "They entertain users": "Metrics measure how well controls perform.",
    "They improve animations": "Metrics track security effectiveness.",
  },
  "What does risk appetite represent?": {
    "How much coffee employees drink": "Risk appetite is how much risk leadership is willing to accept.",
    "The number of vulnerabilities allowed": "Appetite is about overall risk, not a count of vulnerabilities.",
    "The time allowed for patching": "Patch deadlines are an operational policy that may reflect appetite, but they aren't the same thing.",
  },
  "Which framework focuses on continuous improvement of a security program?": {
    "ISO 9001": "ISO 9001 covers quality management in general, not security programs specifically.",
    "PCI DSS": "PCI DSS is a compliance standard for payment card data, not a program-improvement framework.",
    "GDPR": "GDPR is an EU privacy regulation, not a security improvement framework.",
  },
  "What is a Key Risk Indicator (KRI)?": {
    "A log entry": "A single log entry is raw data. A KRI is a tracked metric that warns of rising risk.",
    "A phishing technique": "KRIs are governance metrics.",
    "A vulnerability score": "A CVSS score rates one vulnerability. A KRI tracks risk trends over time.",
  },
  "The goal of governance frameworks is to:": {
    "Define technical configurations": "Technical settings belong in baselines and standards. Governance sets direction and accountability.",
    "Perform penetration tests": "Pen tests are operational assessments.",
    "Monitor network bandwidth": "That's network operations.",
  },
  "Quantitative risk analysis is based on:": {
    "Subjective ratings": "Subjective ratings describe qualitative analysis.",
    "Employee surveys": "Surveys give opinions. Quantitative analysis uses measurable values like SLE and ALE.",
    "Security training results": "Training results are awareness metrics, not the basis of quantitative risk analysis.",
  },
  "Data sovereignty laws require organizations to:": {
    "Encrypt all backups": "Encryption may be required elsewhere, but sovereignty is about the laws of the data's location.",
    "Use firewalls with geofencing": "Geofencing is a technical control, not a sovereignty requirement.",
    "Store data in the cloud": "Sovereignty applies wherever data is stored, cloud or not.",
  },
  "Master Data Management (MDM) primarily ensures:": {
    "Data encryption": "Here MDM means master data management: keeping core records accurate and consistent.",
    "Wi-Fi security": "That's wireless security, unrelated to master data.",
    "Account lockout policies": "Lockout is an authentication control.",
  },
  "Red team vs. blue team exercises focus on:": {
    "Web development": "The exercises test security: red attacks, blue defends.",
    "Writing policies": "Policies may be updated afterwards, but the exercise simulates attack and defense.",
    "Training sales staff": "They're for security teams.",
  },
  "Data classification helps determine:": {
    "Battery life": "Classification decides which protections data needs.",
    "Employee schedules": "Schedules are HR matters.",
    "System uptime": "Uptime is an availability metric, not something classification sets.",
  },
  "Gap analysis compares:": {
    "Usernames to passwords": "That's authentication, not gap analysis.",
    "Firewall rules to malware": "Gap analysis compares where you are with where you need to be.",
    "Cloud costs to salaries": "That's a financial comparison, not a security gap analysis.",
  },
  "Annual Loss Expectancy (ALE) is calculated using:": {
    "MTBF x MTTR": "MTBF and MTTR are reliability metrics. ALE = SLE × ARO.",
    "ROI ÷ TCO": "ROI and TCO are financial investment measures, not loss expectancy.",
    "CIA ÷ AAA": "Those are security concepts, not numbers you can calculate with.",
  },
  "A security maturity model is used to:": {
    "Rate password strength": "Password meters rate passwords. Maturity models rate how capable the security program is.",
    "Test network throughput": "That's performance testing.",
    "Audit social media": "Maturity models assess security processes overall.",
  },
  "A risk treatment plan describes:": {
    "Firewall rules": "Firewall rules may be one action, but the plan covers how each risk will be handled.",
    "Employee vacation schedules": "Schedules are HR matters.",
    "Database diagrams": "Diagrams document design, not risk responses.",
  },
  "What is risk transference?": {
    "Refusing to pay for security": "Transference often costs money, such as insurance premiums, to shift the risk.",
    "Ignoring the risk": "Transference is a deliberate response: someone else bears the financial impact.",
    "Encrypting the risk": "Encryption is mitigation, a different response.",
  },
  "Which report details weaknesses after testing controls?": {
    "Marketing report": "A findings report documents weaknesses found during assessment.",
    "Holiday schedule": "It isn't an assessment document.",
    "Billing invoice": "An invoice charges for work; it doesn't document findings.",
  },
  "Business Continuity Plans must include:": {
    "Employee birthdays": "A BCP covers recovery priorities and procedures.",
    "Favorite lunch options": "A BCP is about keeping critical operations running.",
    "Gaming policies": "Acceptable use rules aren't part of a BCP.",
  },
  "Privacy by design means:": {
    "Adding privacy later": "Adding it later is what privacy by design avoids.",
    "Removing privacy settings": "It makes privacy the default.",
    "Encrypting everything": "Encryption can be one tool, but privacy by design is a broader development principle.",
  },
  "Risk aggregation allows organizations to:": {
    "Hide audit logs": "Aggregation combines risks to see their total impact.",
    "Increase firewall throughput": "It's an analysis method, not network tuning.",
    "Reduce power consumption": "It measures combined risk, not energy use.",
  },
  "A data custodian is responsible for:": {
    "Approving budgets": "Budgets are management decisions. Custodians apply the protections day to day.",
    "Writing press releases": "That's communications work.",
    "Managing employee benefits": "That's HR.",
  },
  "ERM (Enterprise Risk Management) focuses on:": {
    "Department-specific risks only": "ERM looks across the whole enterprise, not one department.",
    "Only cybersecurity risks": "ERM includes financial, operational, legal and other risks too.",
    "Replacing all firewalls": "ERM is a management discipline, not a technical project.",
  },
  "A compensating control is:": {
    "A backup server": "A backup server supports recovery. A compensating control substitutes for a control that can't be used.",
    "A password manager": "A password manager is one tool, not the definition of a compensating control.",
    "A router firmware update": "Updating firmware is patching.",
  },
  "MTTR refers to:": {
    "Maximum Time To Respond": "MTTR means Mean Time To Repair: the average time to restore after a failure.",
    "Monthly Technical Training Requirement": "MTTR is a reliability metric.",
    "Managed Threat Testing Routine": "MTTR measures repair time, not testing.",
  },
  "MTBF represents:": {
    "Maximum Threat Baseline Factor": "MTBF means Mean Time Between Failures, a reliability measure.",
    "Managed Testing Before Failure": "MTBF is the average time a system runs between failures.",
    "Monthly Travel Budget Forecast": "MTBF is a reliability metric.",
  },
  "RPO (Recovery Point Objective) defines:": {
    "How long employees can work remotely": "RPO is about how much data you can afford to lose, measured in time.",
    "Cost of downtime": "Downtime cost comes from the BIA. RPO sets acceptable data loss.",
    "Office evacuation time": "RPO is a data recovery target.",
  },
  "RTO (Recovery Time Objective) defines:": {
    "Required time to update firewalls": "RTO is the maximum acceptable downtime before restoration.",
    "Backup window duration": "The backup window is when backups run. RTO is about restoring after an outage.",
    "Password expiration": "Password expiry is an authentication policy.",
  },
  "Which strategy involves identifying and assessing threats to assets?": {
    "Gap analysis": "Gap analysis compares current and desired states. Threat modeling maps out possible attacks.",
    "Port scanning": "Port scanning finds open services, one technical input, not the whole strategy.",
    "Data scrubbing": "Scrubbing cleans or sanitizes data.",
  },
  "What is cyber resilience?": {
    "An antivirus product": "Resilience is an organizational ability: withstanding and recovering from attacks.",
    "Firewall performance": "Resilience is about continuing operations, not one device.",
    "CPU resistance to overheating": "It's about cyber incidents, not hardware temperature.",
  },
  "Residual risk refers to:": {
    "Risk before assessment": "Risk before any controls is inherent risk.",
    "Risk transferred to insurance": "That's transferred risk. Residual risk is what remains after controls.",
    "Risk with no consequences": "Residual risk still has consequences; it's just been accepted.",
  },
  "Data masking is used to:": {
    "Encrypt hard drives": "That's full disk encryption. Masking hides real values, for example in test data.",
    "Improve database speed": "Masking protects data; it doesn't tune performance.",
    "Compress files": "Compression reduces size. Masking obscures sensitive values.",
  },
  "An ISSP (Issue-Specific Security Policy) addresses:": {
    "Entire company operations": "Organization-wide direction is the enterprise security policy. An ISSP covers one issue.",
    "Employee benefits": "Benefits are HR matters.",
    "Marketing strategies": "Marketing is unrelated. An ISSP covers topics like email or internet use.",
  },
};
