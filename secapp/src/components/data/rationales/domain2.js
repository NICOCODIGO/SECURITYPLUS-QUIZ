// Domain 2: Threats, Vulnerabilities, and Mitigations — why each wrong choice
// is wrong. Keyed by question text, then wrong-choice text.

export default {
  "What is malware?": {
    "A type of firewall": "A firewall is a defensive control that filters traffic. Malware is the harmful code such controls try to stop.",
    "A security protocol": "Protocols like TLS protect communications. Malware is software built to cause harm.",
    "An encryption algorithm": "Algorithms like AES protect data. Ransomware may use encryption, but malware itself is any malicious program.",
  },
  "What is phishing?": {
    "A network scanning technique": "Scanning probes systems for open ports and services. Phishing targets people with deceptive messages.",
    "A type of encryption": "Encryption protects data. Phishing is a social engineering attack.",
    "A firewall configuration": "Firewall rules filter traffic. Phishing tricks people into giving up information.",
  },
  "What type of attack involves overwhelming a system with traffic?": {
    "SQL Injection": "SQL injection sends crafted input to manipulate a database. It isn't about traffic volume.",
    "Cross-Site Scripting": "XSS injects scripts into web pages that other users view. It doesn't flood the target.",
    "Man-in-the-Middle": "An on-path attacker quietly intercepts traffic between two parties rather than flooding a system.",
  },
  "What is ransomware?": {
    "Software that monitors user activity": "That describes spyware. Ransomware locks or encrypts your files and demands payment.",
    "A type of firewall": "A firewall is a defensive control, not malware.",
    "An antivirus program": "Antivirus defends against malware such as ransomware.",
  },
  "What is the MITRE ATT&CK framework used for?": {
    "Password encryption": "ATT&CK is a knowledge base of attacker behavior. Passwords are protected with hashing, not a framework.",
    "Network traffic filtering": "Filtering is a firewall's job. ATT&CK helps defenders understand and detect attacker techniques.",
    "User authentication": "ATT&CK doesn't authenticate anyone. It catalogs tactics, techniques and procedures (TTPs).",
  },
  "What is a vulnerability?": {
    "A type of malware": "Malware is a threat that may exploit a vulnerability. The vulnerability is the weakness itself.",
    "A security control": "A control reduces risk, often by fixing or shielding a vulnerability.",
    "An encryption method": "Encryption is a control. A vulnerability is a flaw that could be exploited.",
  },
  "What is a zero-day exploit?": {
    "Exploit for known vulnerabilities": "Known, disclosed flaws usually have patches available. Zero-days target flaws the vendor doesn't know about yet.",
    "Expired exploit": "'Zero day' means defenders have had zero days to fix the flaw, not that the exploit expired.",
    "Slow exploit": "The name is about how long the flaw has been known, not the attack's speed.",
  },
  "What is advanced persistent threat (APT)?": {
    "Quick attack": "APTs are the opposite: they stay hidden in a network for months or longer.",
    "Automated attack": "APTs are run by skilled, often nation-state, operators who adapt their approach, not by automation alone.",
    "Random attack": "APTs choose their targets deliberately and pursue them persistently.",
  },
  "What is social engineering?": {
    "Building networks": "Building networks is network engineering. Social engineering manipulates people.",
    "Installing software": "Social engineering targets human behavior, not system setup.",
    "Encrypting data": "Encryption is a technical control. Social engineering works around technology by deceiving people.",
  },
  "What is spear phishing?": {
    "General phishing attack": "Mass phishing sends the same lure to many people. Spear phishing is tailored to specific targets.",
    "Physical attack": "Spear phishing is delivered digitally, usually by email, not in person.",
    "Network attack": "It targets a person through a personalized message, not network infrastructure.",
  },
  "What is privilege escalation?": {
    "Reducing permissions": "That's the opposite. Escalation means gaining more rights than you were granted.",
    "Creating users": "An attacker might create accounts afterwards, but escalation is about raising privilege levels.",
    "Deleting accounts": "Deleting accounts is a separate action, not the act of gaining elevated access.",
  },
  "What is a trojan horse?": {
    "Antivirus software": "Antivirus detects trojans. A trojan pretends to be legitimate software.",
    "Firewall": "A firewall is a defensive control, not malware.",
    "Encryption tool": "A trojan may pose as a useful tool, but it's malware underneath.",
  },
  "What is SQL injection?": {
    "Database optimization": "Optimization improves performance. SQL injection abuses unsanitized input to run the attacker's queries.",
    "Creating databases": "Creating databases is normal administration, not an attack.",
    "Backing up data": "Backups protect data. SQL injection steals or alters it.",
  },
  "What is a supply chain attack?": {
    "Direct attack": "A supply chain attack is indirect: it goes through a trusted vendor, software update or component.",
    "Physical theft": "Stealing goods isn't the point. The attack compromises something the target trusts and installs.",
    "Password attack": "Password attacks target credentials directly. Supply chain attacks abuse a third party's trust.",
  },
  "What is a virus?": {
    "Hardware device": "A virus is code, not hardware.",
    "Security tool": "Security tools remove viruses.",
    "Network protocol": "Protocols define how systems communicate. A virus is malware that infects files.",
  },
  "What is a worm?": {
    "Physical device": "A worm is malicious code, not hardware.",
    "Encryption method": "Encryption protects data. A worm spreads itself across networks.",
    "Access control": "Access controls restrict who can use a resource. A worm is malware.",
  },
  "What is a rootkit?": {
    "Admin tool": "A rootkit may grant root-level access, but it's malware designed to hide that access.",
    "Firewall": "A firewall filters traffic. A rootkit hides malicious activity deep in the system.",
    "Antivirus": "Antivirus tries to find rootkits, which are built to evade exactly that.",
  },
  "What is malvertising?": {
    "Online advertising": "Ordinary online ads are legitimate. Malvertising uses ads to deliver malware.",
    "Ad blocker": "An ad blocker can help defend against malvertising.",
    "Marketing tool": "Malvertising abuses ad networks to attack users; it isn't a marketing tool.",
  },
  "What is watering hole attack?": {
    "Physical attack": "A watering hole attack is online: it infects websites the targets already visit.",
    "Email attack": "No email is needed. The attacker waits on a compromised site the targets trust.",
    "Phone attack": "It's web-based, not phone-based.",
  },
  "What is typosquatting?": {
    "Fixing typos": "Typosquatting exploits typos. It registers look-alike domains such as 'gooogle.com'.",
    "Correcting errors": "Nothing gets corrected. Attackers profit from users' typing mistakes.",
    "Domain protection": "Registering common misspellings of your own domain is a defense, but typosquatting is the attack.",
  },
  "What is a botnet?": {
    "Single infected computer": "One infected machine is a bot. A botnet is many bots under central control.",
    "Security tool": "Botnets are attacker infrastructure, used for DDoS attacks, spam and more.",
    "Firewall type": "Firewalls defend networks. A botnet is a network of compromised machines.",
  },
  "What is credential stuffing?": {
    "Creating passwords": "Credential stuffing reuses passwords already leaked in breaches.",
    "Encrypting passwords": "Encryption protects passwords. Stuffing tries stolen ones on other sites.",
    "Resetting passwords": "A reset is a recovery process. Stuffing is automated logins with stolen credentials.",
  },
  "What is a fileless malware attack?": {
    "Attack using files": "Fileless attacks deliberately avoid dropping files, which is why file scanners miss them.",
    "Deleting files": "It runs in memory and in legitimate tools. It isn't about deleting files.",
    "Backing up files": "Backups are a defense. Fileless malware is an attack technique.",
  },
  "What is adware?": {
    "Hardware component": "Adware is software.",
    "Antivirus program": "Antivirus can remove adware.",
    "Email client": "An email client handles mail. Adware pushes unwanted ads.",
  },
  "What is a logic bomb?": {
    "Physical explosive": "It's code that 'detonates' when a condition is met, such as a date or an employee being removed.",
    "Network device": "A logic bomb is hidden code inside software, not a device.",
    "Security tool": "It's malicious code, often planted by an insider.",
  },
  "What is a race condition vulnerability?": {
    "Slow performance": "The flaw is about the order and timing of operations, not speed. An attacker slips in between two steps.",
    "Network congestion": "Congestion is heavy traffic. A race condition is a software timing flaw, such as time-of-check to time-of-use (TOCTOU).",
    "Disk error": "Disk errors are hardware faults. Race conditions come from how code handles concurrent operations.",
  },
  "What is pharming?": {
    "Agriculture practice": "Pharming is a play on 'phishing': it redirects traffic to fake sites.",
    "Email filtering": "Filtering is a defense. Pharming poisons DNS or hosts files to send users to the wrong site.",
    "Password storage": "Pharming steals credentials through fake sites; it doesn't store them securely.",
  },
  "What is pretexting?": {
    "Writing code": "Pretexting is social engineering: inventing a believable story, like posing as IT support.",
    "Testing software": "It targets people, not software.",
    "Installing updates": "An attacker might pretend to be installing updates, but pretexting is the made-up story itself.",
  },
  "What is tailgating?": {
    "Following cars": "In security, tailgating means slipping through a secured door behind an authorized person.",
    "Network attack": "Tailgating is a physical intrusion.",
    "Email attack": "It happens in person at a door, not by email.",
  },
  "What is an insider threat?": {
    "External hacker": "An insider already has authorized access, such as an employee or contractor. External hackers don't.",
    "Virus": "A virus is malware. An insider threat is a person.",
    "Firewall": "A firewall is a control, and it does little against someone already inside.",
  },
  "What is vishing?": {
    "Visual attack": "The V stands for voice: phishing over phone calls.",
    "Email attack": "Email-based lures are regular phishing.",
    "Text attack": "Text-message phishing is smishing.",
  },
  "What is smishing?": {
    "Smiling attack": "Smishing combines SMS and phishing.",
    "Email attack": "Email lures are regular phishing.",
    "Phone call": "Phone calls are vishing. Smishing uses text messages.",
  },
  "What is a polymorphic virus?": {
    "Static virus": "Polymorphic means many forms: it changes its code to avoid signature detection.",
    "Harmless program": "A polymorphic virus is malware that is especially hard to detect.",
    "Antivirus": "Antivirus struggles against polymorphic viruses because their signatures keep changing.",
  },
  "What is dumpster diving?": {
    "Diving sport": "It means literally searching trash for documents or media containing sensitive data.",
    "Network attack": "It's physical: going through discarded papers and devices.",
    "Software bug": "It's a reconnaissance technique, not a flaw in code.",
  },
  "What is shoulder surfing?": {
    "Exercise": "It means watching someone's screen or keypad to steal information.",
    "Physical attack": "It involves being physically nearby, but nothing is attacked. The attacker just watches.",
    "Network scan": "It's direct observation, not scanning systems.",
  },
  "What is command and control (C&C)?": {
    "Management structure": "In security, C&C (C2) is the attacker's infrastructure for directing compromised machines.",
    "Firewall": "A firewall may block C&C traffic, but C&C is the attacker's server.",
    "Router": "A router forwards traffic. A C&C server sends commands to infected hosts.",
  },
  "What is baiting?": {
    "Fishing": "The bait is usually an infected USB drive left for someone to plug in.",
    "Email attack": "Baiting typically uses physical media, relying on curiosity.",
    "Phone scam": "Phone scams are vishing. Baiting leaves a tempting infected device.",
  },
  "What is a backdoor?": {
    "Physical door": "It's a hidden way into a system that bypasses normal authentication.",
    "Front entrance": "A backdoor is the opposite of the normal, authenticated way in.",
    "Window": "It's a covert software access path, not a building feature.",
  },
  "What is cryptojacking?": {
    "Stealing wallets": "Wallet theft takes existing coins. Cryptojacking secretly uses your computing power to mine new ones.",
    "Encryption": "Mining involves cryptography, but cryptojacking is unauthorized mining, not encryption.",
    "Password theft": "It hijacks computing resources, not credentials.",
  },
  "What is keylogger?": {
    "Password manager": "A password manager protects passwords. A keylogger steals them by recording keystrokes.",
    "Security tool": "Keyloggers can be used in monitoring, but in this context they're malware.",
    "Antivirus": "Antivirus tries to detect keyloggers.",
  },
  "What is spam?": {
    "Ham": "'Ham' is filter slang for wanted, legitimate email. Spam is the unwanted bulk kind.",
    "Legitimate email": "Spam is unsolicited and often malicious.",
    "Important messages": "Spam is junk sent in bulk.",
  },
  "What is session hijacking?": {
    "Creating sessions": "Hijacking takes over someone else's existing session, often by stealing its cookie.",
    "Closing sessions": "Logging out is a defense. Hijacking keeps the stolen session alive.",
    "Starting sessions": "The attacker doesn't start a session; they take over a valid one.",
  },
  "What is cross-site scripting (XSS)?": {
    "Database attack": "Attacking the database is SQL injection. XSS runs scripts in the victim's browser.",
    "Network attack": "XSS is an application-layer web attack.",
    "Physical attack": "XSS is delivered through web pages.",
  },
  "What is a denial of service attack?": {
    "Good service": "DoS is the opposite: making a service unavailable.",
    "Better service": "It degrades or blocks service.",
    "Faster service": "It floods or crashes a service, making it slower or unusable.",
  },
  "What is buffer overflow?": {
    "Empty buffer": "An overflow writes more data than the buffer holds, spilling into nearby memory.",
    "Normal operation": "It's a memory-safety flaw that can let attackers run code.",
    "Fast buffer": "Speed is irrelevant. The issue is data exceeding the buffer's size.",
  },
  "What is eavesdropping?": {
    "Loud talking": "It means secretly listening in on communications.",
    "Broadcasting": "Broadcasting sends information openly. Eavesdropping intercepts it secretly.",
    "Announcing": "Announcing is public. Eavesdropping is covert.",
  },
  "What is impersonation?": {
    "Being yourself": "Impersonation means pretending to be someone else, like IT support or an executive.",
    "Real identity": "The attacker uses a false identity.",
    "Honest behavior": "It's deception used to gain trust and access.",
  },
  "What is a side-channel attack?": {
    "Direct attack": "Side channels are indirect: they infer secrets from timing, power use or emissions.",
    "Front attack": "It doesn't break the algorithm head-on; it watches physical side effects.",
    "Password attack": "Side channels can leak keys or passwords, but the defining trait is measuring leaked signals.",
  },
  "What is reconnaissance?": {
    "Random attack": "Recon is deliberate information gathering before an attack.",
    "Direct attack": "Recon happens before the attack, such as OSINT or scanning.",
    "Defense": "Defenders do their own discovery too, but reconnaissance is the attacker's first phase.",
  },
  "What is social media threat?": {
    "Using social media": "Normal use isn't a threat. The threat is attackers exploiting these platforms.",
    "Posting photos": "Oversharing can help attackers, but the threat is the exploitation, like OSINT or scams.",
    "Making friends": "Fake friend requests can be a tactic, but the threat is the attack itself.",
  },
  "What is DNS poisoning?": {
    "Cleaning DNS": "Flushing the DNS cache can clear poisoning. Poisoning inserts false records.",
    "Good DNS": "Poisoned DNS sends users to malicious IP addresses.",
    "Fast DNS": "It corrupts answers; it has nothing to do with speed.",
  },
  "What is IP spoofing?": {
    "Real IP": "Spoofing forges the source address.",
    "Valid IP": "The forged address may look valid, but it isn't the sender's.",
    "Assigned IP": "Spoofing uses an address the attacker wasn't assigned.",
  },
  "What is password attack?": {
    "Changing password": "Changing a password is routine. Attacks try to discover or crack someone else's.",
    "Creating password": "Creating passwords is normal. The attack targets existing ones.",
    "Strong password": "Strong passwords defend against these attacks.",
  },
  "What is pass-the-hash?": {
    "Using password": "The attacker never needs the plaintext password, just the stolen hash.",
    "Cracking password": "Cracking recovers the password. Pass-the-hash skips that and sends the hash directly.",
    "Creating hash": "The hash is stolen from memory or storage, not created.",
  },
  "What is brute force attack?": {
    "Smart guessing": "Informed guessing from wordlists is a dictionary attack. Brute force tries everything.",
    "Single attempt": "Brute force makes huge numbers of attempts.",
    "Social engineering": "Brute force is purely computational; no people are tricked.",
  },
  "What is elicitation?": {
    "Forcing answers": "Elicitation is subtle: casual conversation that draws information out.",
    "Ignoring people": "It requires engaging people in friendly conversation.",
    "Silent treatment": "It relies on talking, often with flattery or false statements that invite correction.",
  },
  "What is a hoax?": {
    "Real threat": "A hoax is fake, like a bogus virus warning, but it still causes disruption.",
    "Security tool": "Hoaxes are social engineering, not tools.",
    "Prevention method": "Hoaxes cause harm, such as tricking users into deleting system files.",
  },
  "What is clickjacking?": {
    "Good clicks": "Clickjacking hides a malicious element under something the user means to click.",
    "Fast clicking": "Speed isn't involved. It's deception with layered or invisible page elements.",
    "Double clicking": "It's about what gets clicked, not how many times.",
  },
  "What is whaling?": {
    "Ocean activity": "Whaling is phishing aimed at 'big fish' like executives.",
    "Regular phishing": "Regular phishing is broad. Whaling targets senior, high-value individuals.",
    "Fishing": "It's phishing, spelled with 'ph', aimed at executives.",
  },
  "What is domain hijacking?": {
    "Buying domain": "A legitimate purchase isn't hijacking. Hijacking takes control without authorization.",
    "Registering domain": "Registration is lawful. Hijacking steals an existing domain, often through the registrar account.",
    "Legal ownership": "Hijacking is unauthorized control.",
  },
  "What is URL hijacking?": {
    "Correct URLs": "It exploits incorrect URLs that users mistype.",
    "Creating URLs": "The attacker registers look-alike domains specifically to capture mistakes.",
    "Valid URLs": "Users meant to reach the valid URL but land on the attacker's look-alike.",
  },
  "What is invoice scam?": {
    "Real invoice": "The invoice is fake, made to look like a real supplier's.",
    "Legitimate bill": "A legitimate bill is owed. The scam invoice isn't.",
    "Receipt": "A receipt confirms a payment. The scam tries to trigger one.",
  },
  "What is on-path attack?": {
    "Direct path": "'On-path' means the attacker sits between two parties and intercepts traffic.",
    "Straight line": "The name describes the attacker's position between communicating parties.",
    "Open path": "It's interception, formerly called man-in-the-middle.",
  },
  "What is replay attack?": {
    "Playing music": "The attacker captures valid traffic, like an auth token, and sends it again.",
    "Deleting data": "Replay reuses captured data; it doesn't delete it.",
    "Creating data": "Nothing new is created. Valid data is resent.",
  },
  "What is birthday attack?": {
    "Party planning": "It's named after the birthday paradox, which makes hash collisions more likely than you'd expect.",
    "Annual event": "It's a probability-based attack on hash functions.",
    "Calendar attack": "It targets hash collisions, not calendars.",
  },
  "What is downgrade attack?": {
    "Upgrading": "A downgrade attack forces an older, weaker version, such as SSL instead of modern TLS.",
    "Improving security": "It deliberately weakens the security in use.",
    "Latest version": "The attacker pushes toward an older, vulnerable version.",
  },
  "What is a watering hole strategy?": {
    "Finding water": "The name is a metaphor: predators wait at the watering hole. Attackers infect sites their targets visit.",
    "Direct attack": "It's indirect: the site is compromised and the targets come to it.",
    "Email campaign": "No email is needed. The trap is a trusted website.",
  },
  "What is piggybacking?": {
    "Giving rides": "Piggybacking means an unauthorized person entering with an authorized person, often with their consent.",
    "Network protocol": "It's a physical access breach.",
    "File sharing": "It's about secured entrances, not files.",
  },
  "What is adversarial AI?": {
    "Friendly AI": "Adversarial AI is used to attack or fool AI systems, for example with manipulated inputs.",
    "Helpful AI": "It aims to make AI systems misbehave.",
    "Safe AI": "It's a threat to AI safety, not a form of it.",
  },
  "What is juice jacking?": {
    "Stealing juice": "'Juice' means power: public USB charging ports rigged to steal data or install malware.",
    "Power surge": "A surge damages hardware. Juice jacking uses the USB data lines to attack.",
    "Battery drain": "The threat is data theft or malware over USB, not draining the battery.",
  },
  "What is a security misconfiguration?": {
    "Perfect setup": "A misconfiguration is a setting that's wrong or insecure, like default passwords.",
    "Best configuration": "It's the opposite of a secure baseline.",
    "Optimized settings": "It's an insecure setting that attackers can exploit.",
  },
  "What is a living off the land attack?": {
    "Using new tools": "The attacker avoids bringing tools, using built-in ones like PowerShell to blend in.",
    "Physical attack": "It's a digital technique using legitimate admin tools.",
    "External tools": "Dropping outside tools risks detection. Living off the land uses what's already installed.",
  },
  "What is a DDoS attack?": {
    "Single source attack": "A single source is plain DoS. DDoS comes from many distributed systems, often a botnet.",
    "Direct attack": "The extra 'D' is for distributed: traffic comes from many hosts at once.",
    "Data attack": "DDoS targets availability by flooding, not the data itself.",
  },
  "What is vulnerability?": {
    "Strength": "A vulnerability is a weakness.",
    "Feature": "Features can be abused, but a vulnerability is a flaw that can be exploited.",
    "Benefit": "A vulnerability creates risk, not benefit.",
  },
  "What is exploit kit?": {
    "Security tool": "Exploit kits are attacker toolkits that automatically exploit browser and plugin flaws.",
    "Antivirus": "Antivirus defends against exploit kits.",
    "Firewall": "A firewall filters traffic. An exploit kit attacks visitors' systems.",
  },
  "What is code injection?": {
    "Writing code": "Normal development isn't injection. The attacker slips their own code into a vulnerable application.",
    "Deleting code": "Injection adds malicious code.",
    "Debugging": "Debugging fixes flaws. Injection exploits them.",
  },
  "What is XML external entity attack?": {
    "Normal XML": "XXE abuses a parser that resolves external entities to read files or reach internal systems.",
    "XML feature": "External entities are a real XML feature, but XXE is the attack that abuses them.",
    "Safe operation": "XXE can leak files or enable SSRF.",
  },
  "What is LDAP injection?": {
    "Normal query": "The attacker injects crafted input into LDAP queries to change what they return.",
    "Database backup": "It's an injection attack on directory services.",
    "Security feature": "It exploits missing input validation.",
  },
  "What is command injection?": {
    "Normal command": "The attacker adds their own OS commands through unsanitized input.",
    "Help command": "It runs arbitrary commands on the server.",
    "Safe operation": "It can give an attacker control of the host.",
  },
  "What is directory traversal?": {
    "Normal navigation": "Traversal uses sequences like '../' to escape the allowed folder.",
    "File system feature": "Relative paths are a feature, but traversal abuses them to reach restricted files.",
    "Safe browsing": "It exposes files the application was never meant to serve.",
  },
  "What is cross-site request forgery?": {
    "Normal request": "CSRF forges a request from the victim's logged-in browser without their knowledge.",
    "Safe request": "It performs unwanted actions, like changing an email or sending money.",
    "Good practice": "Anti-CSRF tokens are the good practice. CSRF is the attack.",
  },
  "What is server-side request forgery?": {
    "Client attack": "Unlike CSRF, SSRF makes the server itself send requests, often to internal systems.",
    "Normal operation": "SSRF abuses a server feature that fetches URLs.",
    "Safe request": "SSRF can reach internal services or cloud metadata endpoints.",
  },
  "What is race condition?": {
    "Running race": "It's a timing flaw where the order of operations can be exploited.",
    "Normal operation": "It's a bug that attackers can exploit, such as TOCTOU.",
    "Safe condition": "Race conditions are vulnerabilities.",
  },
  "What is an APT?": {
    "Simple attack": "APTs are advanced: skilled, well-funded and stealthy.",
    "Quick attack": "Persistent means they stay in a network for a long time.",
    "Basic threat": "APTs are among the most sophisticated threat actors.",
  },
  "What is fileless malware?": {
    "File-based": "Fileless malware avoids writing files and lives in memory and trusted tools.",
    "Regular malware": "Traditional malware drops files. Fileless malware deliberately doesn't.",
    "Stored malware": "It isn't stored on disk, which is what makes it hard to detect.",
  },
  "What is logic bomb?": {
    "Physical bomb": "It's code that activates when a condition is met, such as a certain date.",
    "Safe code": "It's malicious code hidden inside legitimate software.",
    "Normal program": "It looks normal until its trigger condition is met.",
  },
  "What is a trojan?": {
    "Safe program": "A trojan only looks safe; it hides malware.",
    "Antivirus": "Antivirus detects trojans. Some trojans even pose as antivirus.",
    "Firewall": "A firewall is a defensive control, not malware.",
  },
  "What is rootkit?": {
    "System tool": "Rootkits often replace system tools to hide themselves, but they're malware.",
    "Security software": "Security software tries to find rootkits.",
    "Antivirus": "Rootkits are designed to evade antivirus.",
  },
  "What is spyware?": {
    "Security tool": "Spyware secretly collects user information without consent.",
    "Antivirus": "Antivirus removes spyware.",
    "Safe program": "Spyware is malicious because it monitors covertly.",
  },
  "What is a bot?": {
    "Legitimate program": "Some bots are legitimate, like chatbots, but here a bot is a compromised machine in a botnet.",
    "Antivirus": "Antivirus helps clean bots from infected machines.",
    "Firewall": "A firewall can block bot traffic. The bot is the infected host.",
  },
  "What is a RAT?": {
    "Animal": "RAT stands for remote access trojan: malware that gives an attacker remote control.",
    "Safe tool": "Legitimate remote tools exist, but a RAT is installed covertly.",
    "Antivirus": "Antivirus tries to detect RATs.",
  },
  "What is ARP poisoning?": {
    "Clean ARP": "Poisoning sends forged ARP replies so traffic flows through the attacker.",
    "Normal ARP": "Normal ARP maps IPs to MAC addresses. Poisoning falsifies that mapping.",
    "Safe operation": "It enables on-path interception on a local network.",
  },
  "What is MAC flooding?": {
    "Normal traffic": "Flooding sends huge numbers of fake MAC addresses to overflow the switch's table.",
    "Slow traffic": "The goal is to make the switch send traffic out every port, like a hub, so it can be sniffed.",
    "Safe operation": "It's an attack. Port security helps prevent it.",
  },
  "What is a rogue access point?": {
    "Authorized AP": "A rogue AP is one installed without authorization, often by an employee.",
    "Secure AP": "Rogue APs bypass network security controls.",
    "Company AP": "Company-managed APs are authorized. Rogue ones aren't.",
  },
  "What is evil twin?": {
    "Good AP": "An evil twin copies a legitimate network's name to lure users.",
    "Secure AP": "It's an attacker-controlled AP used to intercept traffic.",
    "Authorized AP": "The evil twin imitates the authorized AP.",
  },
  "What is WPS attack?": {
    "Secure method": "WPS was meant to make setup easier, but its PIN method is weak and can be brute-forced.",
    "Safe feature": "The feature exists, but the attack exploits its weak PIN design.",
    "Good practice": "Good practice is to disable WPS.",
  },
  "What is bluejacking?": {
    "Serious attack": "Bluejacking is mostly a nuisance: unsolicited messages over Bluetooth. Data theft is bluesnarfing.",
    "Wired attack": "It uses Bluetooth, which is wireless.",
    "Safe practice": "It's unsolicited contact, even if the harm is usually low.",
  },
  "What is bluesnarfing?": {
    "Safe feature": "Bluesnarfing steals data like contacts and messages over Bluetooth.",
    "Normal operation": "It exploits Bluetooth flaws to access data without authorization.",
    "Authorized access": "The access is unauthorized.",
  },
  "What is RFID cloning?": {
    "Normal copy": "Cloning copies a badge's credential so an attacker can get in.",
    "Authorized backup": "It's unauthorized duplication.",
    "Safe practice": "It defeats RFID-based access control.",
  },
  "What is NFC attack?": {
    "Normal use": "The attack exploits NFC for skimming, relaying or intercepting data.",
    "Safe feature": "NFC itself is a feature. The attack abuses it.",
    "Authorized access": "The access is unauthorized.",
  },
  "What is jamming?": {
    "Music": "Jamming floods radio frequencies with interference to block wireless communication.",
    "Amplifying signals": "It disrupts signals rather than boosting them.",
    "Normal operation": "It's a deliberate denial-of-service against wireless networks.",
  },
  "What is wardriving?": {
    "Driving safely": "Wardriving means moving around, often by car, to map Wi-Fi networks.",
    "Normal driving": "The purpose is discovering wireless networks.",
    "GPS navigation": "GPS may tag the locations, but the goal is finding Wi-Fi networks.",
  },
  "What is a zero-day vulnerability?": {
    "Old vulnerability": "An old, known flaw is usually patchable. A zero-day is unknown to the vendor.",
    "Patched vulnerability": "Once patched, it's no longer a zero-day.",
    "Safe code": "A zero-day is a real, unpatched flaw.",
  },
  "What is threat intelligence?": {
    "No information": "Threat intelligence is evidence-based information about threats.",
    "Random data": "It's curated and analyzed, such as IoCs and actor profiles.",
    "Guessing": "It relies on evidence from feeds, research and observation.",
  },
  "What is indicator of attack?": {
    "Past event": "Evidence of a past compromise is an indicator of compromise (IoC). IoAs show an attack in progress.",
    "No indication": "An IoA is a sign that an attack is happening or about to.",
    "Historical data": "Historical artifacts are IoCs. IoAs focus on current behavior.",
  },
  "What is vulnerability scanner?": {
    "Creating vulnerabilities": "Scanners find existing weaknesses; they don't create them.",
    "Exploit tool": "Exploiting is penetration testing. A scanner identifies and reports weaknesses.",
    "Malware": "Scanners are legitimate security tools, such as Nessus.",
  },
  "What is weaponization?": {
    "Normal code": "In the Cyber Kill Chain, weaponization pairs an exploit with a payload to deliver.",
    "Safe development": "It's an attacker's preparation step.",
    "Security measure": "It's a phase of an attack, not a defense.",
  },
};
