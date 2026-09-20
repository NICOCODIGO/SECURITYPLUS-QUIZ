// Domain 3: Security Architecture — why each wrong choice is wrong.
// Keyed by question text, then wrong-choice text.

export default {
  "What is network segmentation?": {
    "Combining multiple networks into one": "That's the opposite. Segmentation splits a network so a breach in one part can't spread freely.",
    "Encrypting network traffic": "Encryption protects data in transit. Segmentation limits which systems can reach each other.",
    "Monitoring network activity": "Monitoring observes traffic. Segmentation is an architectural design choice.",
  },
  "What is a DMZ in network architecture?": {
    "A data management zone for backups": "DMZ stands for demilitarized zone: a buffer network for internet-facing services, not backups.",
    "A domain management zone for Active Directory": "Domain controllers belong deep inside the internal network, never in the DMZ.",
    "A disaster management zone for recovery": "Recovery uses DR sites. A DMZ isolates public services like web and mail servers.",
  },
  "What is the purpose of data classification?": {
    "To encrypt all data": "Classification decides which data needs strong protection. Encrypting everything the same way isn't the goal.",
    "To backup data regularly": "Backups support availability. Classification labels data by sensitivity.",
    "To delete old data": "Retention and disposal are separate lifecycle steps, though classification may inform them.",
  },
  "In cloud architecture, what is the shared responsibility model?": {
    "All security is the cloud provider's responsibility": "Providers secure the cloud itself. Customers still secure their data, identities and configurations.",
    "All security is the customer's responsibility": "The provider handles physical data centers and underlying infrastructure.",
    "Security is optional in cloud environments": "Security is required in the cloud; the model just divides who does what.",
  },
  "What is a VPN?": {
    "Very Public Network": "VPN means virtual private network: an encrypted tunnel across a public network.",
    "Variable Password Network": "A VPN is about encrypted tunnels, not passwords.",
    "Verified Personal Network": "The P is private, and the V is virtual.",
  },
  "What is microsegmentation?": {
    "Large network segments": "Microsegmentation is very fine-grained, often down to individual workloads.",
    "Removing segmentation": "It adds more segmentation, not less.",
    "Physical separation": "It's usually done in software, with policies per workload, not physical separation.",
  },
  "What is software-defined networking (SDN)?": {
    "Hardware-based networking": "SDN moves control into software, separate from the hardware that forwards traffic.",
    "Manual network configuration": "SDN is centrally programmed and automated, rather than configured box by box.",
    "Legacy networking": "Legacy networks tie control to each device. SDN separates the control plane from the data plane.",
  },
  "What is encryption at rest?": {
    "Encrypting moving data": "Data that's moving is 'in transit', protected by protocols like TLS. 'At rest' means stored.",
    "No encryption": "At rest describes where encryption is applied: to stored data.",
    "Temporary encryption": "It protects stored data for as long as it's stored.",
  },
  "What is a jump server?": {
    "Regular server": "A jump server is a hardened, tightly controlled gateway for admin access.",
    "Backup server": "Backups store copies of data. A jump server brokers access into a secure zone.",
    "Web server": "Web servers serve content to users. A jump server is for administrators.",
  },
  "What is Infrastructure as Code (IaC)?": {
    "Manual configuration": "IaC replaces manual setup with version-controlled definition files.",
    "Physical hardware": "IaC describes infrastructure in code, even when it runs on hardware.",
    "Traditional setup": "Traditional setup is hand-configured. IaC is automated and repeatable.",
  },
  "What is a proxy server?": {
    "Direct connection": "A proxy sits in the middle, so the client doesn't connect directly.",
    "Firewall type": "Some firewalls include proxy features, but a proxy is defined by making requests on a client's behalf.",
    "Router": "A router forwards packets between networks. A proxy handles application requests for clients.",
  },
  "What is load balancing?": {
    "Overloading servers": "Load balancing prevents overload by spreading requests out.",
    "Blocking traffic": "It distributes traffic; it doesn't filter it.",
    "Routing errors": "It's a deliberate method for reliability, not a fault.",
  },
  "What is a security orchestration platform?": {
    "Manual security tool": "Orchestration automates and connects tools. It replaces manual steps.",
    "Antivirus software": "Antivirus protects one endpoint. Orchestration coordinates many tools and playbooks.",
    "Firewall": "A firewall is one control that an orchestration platform might trigger.",
  },
  "What is network access control (NAC)?": {
    "Unrestricted access": "NAC restricts access, checking device identity and health before letting it connect.",
    "Internet service": "NAC is a control on your own network, not an ISP service.",
    "Email filtering": "Email filtering handles messages. NAC decides which devices may join the network.",
  },
  "What is a honeypot?": {
    "Production system": "A honeypot is a decoy with no real business use, so any activity on it is suspicious.",
    "Backup server": "A honeypot lures attackers; it doesn't store backups.",
    "Mail server": "A honeypot might imitate a mail server, but its purpose is to attract and study attackers.",
  },
  "What is east-west traffic?": {
    "Internet traffic": "Traffic entering or leaving the data center is north-south. East-west moves between internal servers.",
    "User traffic": "Client-to-server traffic is usually north-south.",
    "Backup traffic": "Backup jobs may be east-west, but the term covers all lateral traffic within the data center.",
  },
  "What is a VLAN?": {
    "Physical LAN": "A VLAN is virtual: it splits one physical network into logical segments.",
    "Wide Area Network": "A WAN spans large distances. A VLAN segments a local network.",
    "Internet connection": "A VLAN is internal segmentation, not internet access.",
  },
  "What is network address translation (NAT)?": {
    "Encrypting addresses": "NAT rewrites addresses; it doesn't encrypt them.",
    "Creating addresses": "Assigning addresses is DHCP's job. NAT translates existing ones.",
    "Deleting addresses": "NAT maps private addresses to public ones rather than removing them.",
  },
  "What is perfect forward secrecy?": {
    "Using same key forever": "PFS does the opposite: each session gets a fresh key, so one leaked key exposes only one session.",
    "No encryption": "PFS strengthens encryption by using ephemeral session keys.",
    "Weak encryption": "PFS improves security by limiting what a single stolen key can unlock.",
  },
  "What is a firewall?": {
    "Physical barrier": "In building design a firewall stops fire. In networking it's a device that filters traffic.",
    "Fire suppression system": "Fire suppression is an environmental control. A network firewall filters traffic.",
    "Backup device": "Firewalls control traffic; they don't store backups.",
  },
  "What is the difference between symmetric and asymmetric encryption?": {
    "No difference": "They differ in keys: symmetric uses one shared key; asymmetric uses a public/private pair.",
    "Asymmetric is faster": "It's the reverse. Symmetric is much faster, which is why it encrypts bulk data.",
    "Symmetric is newer": "Symmetric ciphers are much older. Public-key (asymmetric) cryptography came in the 1970s.",
  },
  "What is containerization in security?": {
    "Physical packaging": "Containers here are software units that isolate an application and its dependencies.",
    "Data compression": "Compression shrinks data. Containers isolate running applications.",
    "File archiving": "Archives bundle files for storage. Containers run isolated workloads.",
  },
  "What does SSL/TLS provide?": {
    "Speed improvement": "TLS adds a little overhead. Its purpose is secure communication.",
    "File storage": "TLS protects data in transit, not stored files.",
    "Email filtering": "TLS can encrypt mail in transit, but filtering is a different control.",
  },
  "What is a bastion host?": {
    "Regular server": "A bastion host is specially hardened because it's deliberately exposed to attack.",
    "Backup server": "It's a hardened, exposed gateway, not a storage system.",
    "Database server": "Databases belong inside the network. A bastion host faces the internet.",
  },
  "What is quantum cryptography?": {
    "Old encryption method": "It's cutting-edge, based on quantum physics.",
    "Slow encryption": "Speed isn't what defines it. It uses quantum mechanics, for example to detect eavesdropping.",
    "Weak encryption": "It aims for very strong, physics-based security.",
  },
  "What is network topology?": {
    "Network speed": "Speed is bandwidth or throughput. Topology is the layout, such as star or mesh.",
    "Network color": "Topology describes how nodes are connected.",
    "Network cost": "Cost is a budget question. Topology is the physical or logical arrangement.",
  },
  "What is air gap?": {
    "Window opening": "An air gap means a system has no network connection to other networks.",
    "Network bridge": "A bridge connects networks, the opposite of an air gap.",
    "Wireless connection": "Wireless is still a connection. Air-gapped systems have none.",
  },
  "What is network function virtualization?": {
    "Physical hardware": "NFV replaces dedicated appliances with software running on standard servers.",
    "Manual configuration": "NFV is about virtualizing functions like firewalls and load balancers, not manual setup.",
    "Old technology": "NFV is a modern approach that replaces hardware appliances.",
  },
  "What is a router?": {
    "Security tool": "Routers can filter with ACLs, but their main job is forwarding packets between networks.",
    "Storage device": "Routers move data; they don't store it.",
    "Display": "A router is a network device, not a screen.",
  },
  "What is port security?": {
    "Physical door locks": "Here 'port' means a switch port. Port security limits which devices can plug in.",
    "Airport security": "It controls network switch ports, often by MAC address.",
    "Ship security": "It's about switch ports, not harbors.",
  },
  "What is blockchain in security?": {
    "Physical chain": "The 'chain' is blocks linked by cryptographic hashes.",
    "Database": "It's a distributed ledger that can't be changed once written, unlike a normal editable database.",
    "Spreadsheet": "A spreadsheet can be edited freely. Blockchain entries can't be changed after the fact.",
  },
  "What is a switch?": {
    "Light control": "A network switch connects devices on a LAN and forwards frames by MAC address.",
    "Router": "Routers connect different networks at Layer 3. Switches connect devices within one network at Layer 2.",
    "Firewall": "A firewall filters traffic by rules. A switch forwards traffic between local devices.",
  },
  "What is geofencing?": {
    "Physical fence": "Geofencing is a virtual boundary based on GPS or network location.",
    "Firewall": "Firewalls filter by rules. Geofencing triggers actions based on where a device is.",
    "Antivirus": "Antivirus scans for malware. Geofencing uses location.",
  },
  "What is steganography?": {
    "Encryption": "Encryption scrambles data but it's visibly encrypted. Steganography hides that a message exists at all.",
    "Compression": "Compression shrinks data. Steganography hides data inside other files, like images.",
    "Deletion": "Nothing is deleted. Data is hidden within a cover file.",
  },
  "What is cloud computing?": {
    "Weather prediction": "'Cloud' means on-demand computing services delivered over the internet.",
    "Local storage": "Local storage is on-premises. The cloud is remote and provider-hosted.",
    "Physical servers": "Cloud services run on physical servers, but you consume them as on-demand services.",
  },
  "What is IaaS?": {
    "Software service": "Software as a service is SaaS. IaaS provides virtual machines, storage and networks.",
    "Internet service": "The I is for infrastructure.",
    "Information service": "IaaS rents out compute infrastructure, not information.",
  },
  "What is serverless computing?": {
    "No servers exist": "Servers still exist; the provider manages them so you only deploy code.",
    "Local servers": "Serverless is a cloud model where the provider handles the servers.",
    "Physical servers": "You never manage any servers, physical or virtual.",
  },
  "What is PaaS?": {
    "Personal application service": "PaaS means platform as a service: a managed environment for building and running apps.",
    "Private access service": "The P is platform.",
    "Public area service": "PaaS provides a development and runtime platform.",
  },
  "What is SaaS?": {
    "Security as service": "Security as a service is sometimes called SECaaS. SaaS is software delivered over the internet.",
    "Server as service": "Renting servers is closer to IaaS.",
    "Storage as service": "Storage services are usually counted as IaaS. SaaS is complete applications, like email.",
  },
  "What is edge computing?": {
    "Central computing": "Edge computing moves processing away from the center, closer to where data is created.",
    "Cloud only": "It complements the cloud by processing some data locally first.",
    "Server room": "The edge is out near devices, not in a central server room.",
  },
  "What is network protocol?": {
    "Physical cable": "Cables carry signals. A protocol is the set of rules for communicating.",
    "Computer": "Computers follow protocols; a protocol isn't a device.",
    "Software": "Software implements protocols, but the protocol is the agreed set of rules.",
  },
  "What is IPSec?": {
    "Image processing": "IPSec means Internet Protocol Security: authentication and encryption for IP traffic.",
    "Internal protocol": "IPSec secures IP traffic, often across the internet for VPNs.",
    "Identity protection": "It protects packets, not identities.",
  },
  "What is WPA3?": {
    "Old security": "WPA3 is the newest Wi-Fi security standard, replacing WPA2.",
    "Wired protection": "WPA3 secures wireless networks.",
    "Web protocol": "It's a Wi-Fi standard, not a web protocol.",
  },
  "What is Wi-Fi?": {
    "Wired connection": "Wi-Fi is wireless, using radio waves.",
    "Physical cable": "No cable is needed for Wi-Fi.",
    "Fiber optic": "Fiber is a wired medium using light.",
  },
  "What is 802.1X?": {
    "Network cable": "802.1X is an IEEE standard for port-based network access control.",
    "Router model": "It's a standard, often used with RADIUS, not a product.",
    "Firewall type": "It authenticates devices before they can use a port, rather than filtering traffic.",
  },
  "What is RADIUS?": {
    "Circle measurement": "RADIUS is a protocol for centralized authentication, authorization and accounting.",
    "Router": "Routers may send authentication requests to a RADIUS server, but RADIUS is the protocol.",
    "Firewall": "RADIUS handles authentication, not traffic filtering.",
  },
  "What is DNS?": {
    "Data network system": "DNS stands for Domain Name System, which translates names into IP addresses.",
    "Direct name service": "The D is domain.",
    "Digital network system": "DNS is the internet's naming system.",
  },
  "What is DNSSEC?": {
    "DNS backup": "DNSSEC adds digital signatures so DNS answers can be verified.",
    "DNS speed": "DNSSEC adds authenticity checks, not speed.",
    "DNS software": "It's a set of security extensions to DNS, not a program.",
  },
  "What is DNS over HTTPS?": {
    "Regular DNS": "Regular DNS is sent in plaintext. DoH encrypts it inside HTTPS.",
    "Slow DNS": "Its purpose is privacy through encryption, not speed.",
    "Local DNS": "DoH usually sends queries to a remote resolver over HTTPS.",
  },
  "What is HTTPS?": {
    "High transfer protocol": "HTTPS is HTTP Secure: HTTP over TLS.",
    "Home terminal": "It's a web protocol.",
    "Host transfer": "The S stands for secure.",
  },
  "What is certificate pinning?": {
    "Physical pins": "Pinning ties an app to a specific expected certificate or public key.",
    "Unpinning certificate": "Pinning is the security control. Attackers try to bypass it.",
    "No certificates": "Pinning depends on certificates.",
  },
  "What is HSTS?": {
    "HTTP transfer": "HSTS stands for HTTP Strict Transport Security: it forces browsers to use HTTPS.",
    "Host security": "It's a web security header, not general host security.",
    "Home security": "It's a browser policy, set by a response header.",
  },
  "What is AES?": {
    "Application entry system": "AES is the Advanced Encryption Standard, a symmetric block cipher.",
    "Automatic encryption": "AES is a specific algorithm, not a feature.",
    "Access entry system": "It's an encryption standard, not an access system.",
  },
  "What is RSA?": {
    "Random security": "RSA is named after its creators, Rivest, Shamir and Adleman. It's an asymmetric algorithm.",
    "Router security": "RSA is a public-key algorithm, not a network device feature.",
    "Storage algorithm": "RSA encrypts and signs data; it doesn't store it.",
  },
  "What is elliptic curve cryptography?": {
    "Old method": "ECC is newer than RSA and gives equal strength with smaller keys.",
    "Simple encryption": "ECC relies on hard elliptic-curve math.",
    "Weak security": "ECC is strong and efficient, which suits mobile and IoT devices.",
  },
  "What is a digital signature?": {
    "Handwritten signature": "A digital signature is cryptographic: a hash encrypted with the sender's private key.",
    "Photo": "It's cryptographic proof of origin and integrity, not an image.",
    "Password": "A password proves identity at login. A signature proves who sent a message and that it's unchanged.",
  },
  "What is PKI?": {
    "Private key internet": "PKI stands for Public Key Infrastructure: CAs, certificates and key management.",
    "Password key information": "PKI is certificate-based, not password-based.",
    "Personal key identity": "PKI is an organization-wide trust system, not a personal identity.",
  },
  "What is certificate authority?": {
    "Government only": "CAs can be commercial companies, like DigiCert, or internal to an organization.",
    "Local authority": "A CA is a trusted issuer of digital certificates, not a local government body.",
    "No authority": "The CA is the trusted anchor of PKI.",
  },
  "What is secure boot?": {
    "Fast boot": "Secure boot checks signatures during startup. Fast boot just skips steps for speed.",
    "Slow boot": "It's about verification, not speed.",
    "No boot": "It still boots, but only software that is signed and trusted.",
  },
  "What is TPM?": {
    "Total protection method": "TPM stands for Trusted Platform Module, a chip on the motherboard.",
    "Technical process management": "TPM is hardware that stores keys and supports secure boot.",
    "Transfer protocol module": "It isn't a protocol. It's a cryptographic hardware chip.",
  },
  "What is HSM?": {
    "High speed memory": "HSM stands for Hardware Security Module, which protects and manages keys.",
    "Host security management": "An HSM is a dedicated cryptographic device, not a management process.",
    "Home security monitor": "HSMs are enterprise devices for key management.",
  },
  "What is full disk encryption?": {
    "Partial encryption": "FDE encrypts the entire drive, not just part of it.",
    "File encryption only": "File-level encryption protects individual files. FDE covers everything on the disk.",
    "No encryption": "FDE is a strong form of encryption at rest.",
  },
  "What is file encryption?": {
    "Disk encryption": "Disk encryption covers the whole drive. File encryption targets individual files.",
    "Network encryption": "Network encryption protects data in transit.",
    "No encryption": "It encrypts selected files.",
  },
  "What is homomorphic encryption?": {
    "Normal encryption": "Normal encryption must be decrypted before you can compute on the data. Homomorphic encryption doesn't.",
    "Weak encryption": "Its distinguishing feature is computing on data while it stays encrypted.",
    "No encryption": "The data stays encrypted the whole time.",
  },
  "What is a subnet?": {
    "Main network": "A subnet is a smaller piece of a larger network.",
    "Internet": "The internet is a global network of networks. A subnet is a local subdivision.",
    "Router": "Routers connect subnets; they aren't subnets.",
  },
  "What is IPv6?": {
    "Old protocol": "IPv6 is the newer version, with 128-bit addresses.",
    "IPv4 backup": "IPv6 is a successor, not a backup, though they often run side by side.",
    "Local network": "IPv6 is an internet protocol used everywhere, not just locally.",
  },
  "What is BGP?": {
    "Basic gateway process": "BGP stands for Border Gateway Protocol, which routes traffic between autonomous systems.",
    "Backup general protocol": "BGP is the internet's routing protocol.",
    "Bridge group protocol": "BGP operates between networks, not within a bridge.",
  },
  "What is MAC address?": {
    "Apple computer": "Here MAC means Media Access Control, a network card's hardware address.",
    "Main access code": "It's a Layer 2 hardware identifier, not a code you enter.",
    "Master authentication code": "A MAC address identifies an interface; it doesn't authenticate anyone. (A message authentication code is different.)",
  },
  "What is ARP?": {
    "Automatic routing protocol": "ARP is the Address Resolution Protocol, which maps IP addresses to MAC addresses.",
    "Access route process": "ARP resolves addresses on a local network.",
    "Application retrieval protocol": "ARP works at the network layers, not with applications.",
  },
  "What is VXLAN?": {
    "Very external LAN": "VXLAN stands for Virtual Extensible LAN, which carries Layer 2 networks over Layer 3.",
    "Visual extension LAN": "The V is virtual.",
    "Verified extra LAN": "It's a network virtualization technology, not a verification feature.",
  },
  "What is bandwidth?": {
    "Network cable width": "Bandwidth is capacity: how much data a link can carry per second.",
    "Router size": "Bandwidth describes a link's capacity, not a device's size.",
    "Switch speed": "A switch port has a speed, but bandwidth is the link's data capacity.",
  },
  "What is QoS?": {
    "Quick operation system": "QoS means Quality of Service: prioritizing important traffic.",
    "Queue order service": "QoS uses queues, but the name means Quality of Service.",
    "Quota of storage": "QoS manages network traffic, not storage.",
  },
  "What is MPLS?": {
    "Main protocol layer system": "MPLS stands for Multi-Protocol Label Switching, which forwards traffic using labels.",
    "Manual process label service": "MPLS is an automated forwarding technique.",
    "Multiple path load service": "MPLS may use several paths, but it's defined by label switching.",
  },
  "What is redundancy?": {
    "Single point": "Redundancy removes single points of failure.",
    "No backup": "Redundancy means having duplicate components ready.",
    "One system": "It requires more than one system or component.",
  },
  "What is high availability?": {
    "Sometimes working": "High availability aims for near-constant uptime, like 99.999%.",
    "Always broken": "HA is designed to keep services running.",
    "No service": "HA maximizes service uptime.",
  },
  "What is active-active configuration?": {
    "One active": "One active node with a standby is active-passive.",
    "All standby": "In active-active, every node handles traffic.",
    "No redundancy": "Active-active is a redundant design.",
  },
  "What is active-passive configuration?": {
    "All active": "All nodes working at once is active-active.",
    "All standby": "One node is active; the other waits to take over.",
    "No backup": "The passive node is the backup.",
  },
  "What is containerization?": {
    "Physical boxes": "Containers package software, not goods.",
    "Full VM": "A VM includes a full guest OS. Containers share the host's kernel, which makes them lighter.",
    "No isolation": "Containers do isolate applications, though less strongly than VMs.",
  },
  "What is microservices architecture?": {
    "Monolithic app": "A monolith is one large codebase. Microservices split an app into small independent services.",
    "Single service": "Microservices are many small services working together.",
    "No architecture": "It's a specific architectural style.",
  },
  "What is API gateway?": {
    "Regular gateway": "An API gateway is specialized: it handles API authentication, rate limiting and routing.",
    "Firewall": "It can enforce API security, but its main role is being the single entry point for APIs.",
    "Router": "A router forwards packets. An API gateway routes API calls to backend services.",
  },
  "What is REST API?": {
    "SOAP only": "SOAP is a different, XML-based web service style. REST uses standard HTTP methods.",
    "Database": "A REST API may front a database, but it's a web service interface.",
    "Programming language": "REST is an architectural style usable from any language.",
  },
  "What is service mesh?": {
    "Physical network": "A service mesh is a software layer, often sidecar proxies, between microservices.",
    "Single service": "It manages communication between many services.",
    "No networking": "It is entirely about service-to-service networking.",
  },
  "What is infrastructure as code?": {
    "Manual configuration": "IaC replaces manual setup with code.",
    "Physical only": "IaC defines infrastructure in files, whether it runs on cloud or on-premises hardware.",
    "No automation": "Automation is the main benefit of IaC.",
  },
  "What is DevOps?": {
    "Development only": "DevOps joins development with operations.",
    "Operations only": "It combines operations with development.",
    "No collaboration": "Collaboration between the two teams is the core of DevOps.",
  },
  "What is DevSecOps?": {
    "No security": "The 'Sec' means security is built into DevOps.",
    "Development only": "It spans development, security and operations.",
    "Security later": "DevSecOps 'shifts security left', to the start of development.",
  },
  "What is CI/CD?": {
    "Manual deployment": "CI/CD automates building, testing and deploying code.",
    "No automation": "Automation is the heart of CI/CD pipelines.",
    "Random releases": "CI/CD releases are frequent, automated and repeatable.",
  },
  "What is version control?": {
    "No tracking": "Version control tracks every change, like Git does.",
    "Deleting code": "It preserves history, so old versions can be restored.",
    "Random changes": "Changes are recorded, reviewed and attributed.",
  },
  "What is immutable infrastructure?": {
    "Changing systems": "Immutable systems aren't changed after deployment; they're replaced with new builds.",
    "Regular updates": "Updates happen by deploying a fresh image, not by patching in place.",
    "Constant changes": "Immutability prevents configuration drift by never modifying running systems.",
  },
  "What is snapshot?": {
    "Photo": "A snapshot captures a system's state at a moment in time.",
    "Live system": "It's a saved copy of the system at one point, not the running system.",
    "No backup": "Snapshots are a quick form of backup and recovery point.",
  },
  "What is SIEM?": {
    "Simple tool": "A SIEM gathers and correlates logs from across the whole environment.",
    "Firewall": "A firewall is one log source that feeds a SIEM.",
    "Antivirus": "Antivirus protects endpoints. A SIEM analyzes events from many sources.",
  },
  "What is SOAR?": {
    "Flying": "SOAR means Security Orchestration, Automation and Response.",
    "Manual only": "SOAR automates response playbooks.",
    "No automation": "Automation is the A in SOAR.",
  },
  "What is NAC?": {
    "National code": "NAC stands for Network Access Control.",
    "No control": "NAC enforces who and what may connect.",
    "Cable type": "NAC is a security control, not cabling.",
  },
  "What is DMZ?": {
    "Military zone": "The term is borrowed from the military, but in networking it's a buffer segment for public services.",
    "Safe zone": "The DMZ is semi-trusted: more exposed than the internal network.",
    "Internal network": "The DMZ is deliberately separated from the internal network.",
  },
  "What is screened subnet?": {
    "No firewall": "A screened subnet sits between firewalls.",
    "Single firewall": "The classic design uses two firewalls, one on each side of the DMZ.",
    "No security": "It's a layered security design.",
  },
  "What is jump server?": {
    "Exercise equipment": "A jump server is a hardened host that admins go through to reach secure systems.",
    "Router": "A router forwards packets. A jump server brokers admin sessions.",
    "Switch": "A switch connects local devices. A jump server controls privileged access.",
  },
  "What is proxy server?": {
    "Direct connection": "A proxy sits between client and server, so the connection isn't direct.",
    "End device": "A proxy is an intermediary, not an endpoint.",
    "Router": "Routers forward packets. Proxies make requests on behalf of clients.",
  },
  "What is reverse proxy?": {
    "Forward proxy": "A forward proxy represents clients. A reverse proxy sits in front of servers.",
    "Client proxy": "A client-side proxy is a forward proxy. A reverse proxy protects the backend.",
    "No proxy": "A reverse proxy is a proxy, facing the server side.",
  },
  "What is WAF?": {
    "Regular firewall": "A regular firewall filters by IP and port. A WAF inspects HTTP traffic for attacks like SQL injection.",
    "Network firewall": "Network firewalls work at Layers 3 and 4. A WAF works at Layer 7 for web apps.",
    "No protection": "A WAF protects web applications.",
  },
  "What is next-gen firewall?": {
    "Old firewall": "NGFWs are the modern generation, with application awareness.",
    "Basic firewall": "Basic firewalls filter by port. NGFWs add deep inspection, IPS and app control.",
    "No firewall": "An NGFW is a firewall with extra capabilities.",
  },
  "What is unified threat management?": {
    "Single threat": "UTM covers many threats with many functions in one device.",
    "No management": "UTM centralizes management of several security functions.",
    "Separate tools": "Separate tools are what UTM consolidates into one appliance.",
  },
  "What is DLP?": {
    "Data creation": "DLP means Data Loss Prevention: stopping sensitive data from leaving.",
    "Data deletion": "DLP prevents data from leaking out, not deletion.",
    "No protection": "DLP is a protective control.",
  },
  "What is endpoint security?": {
    "Server only": "Endpoints include laptops, phones and workstations, not only servers.",
    "Network only": "Network security protects the network. Endpoint security protects the devices.",
    "No protection": "It's protection for user devices.",
  },
  "What is EDR?": {
    "Endpoint Data Recovery": "The DR stands for detection and response: monitoring endpoints and reacting to threats.",
    "Email delivery": "EDR runs on endpoints, not mail systems.",
    "No detection": "Detection is the D in EDR.",
  },
  "What is MDM?": {
    "Master data": "Master data management is a data practice. MDM here is Mobile Device Management.",
    "Memory device": "MDM is software for managing and securing mobile devices.",
    "No management": "MDM is all about managing devices.",
  },
  "What is BYOD?": {
    "Company devices only": "BYOD means employees bring their own devices.",
    "No personal devices": "BYOD specifically allows personal devices.",
    "Banned devices": "BYOD allows personal devices under a policy.",
  },
  "What is COPE?": {
    "BYOD": "With BYOD the employee owns the device. With COPE the company does.",
    "Personal only": "COPE devices are corporate-owned, with personal use allowed.",
    "No devices": "COPE is a device ownership model.",
  },
  "What is CYOD?": {
    "No choice": "CYOD gives employees a choice from an approved list.",
    "Company decides": "The company sets the list, but the employee picks the device.",
    "Random device": "The choice is limited to approved devices.",
  },
  "What is VDI?": {
    "Physical desktop": "VDI desktops run as virtual machines on central servers.",
    "Video display": "VDI means Virtual Desktop Infrastructure.",
    "No desktops": "VDI delivers desktops remotely.",
  },
  "What is software-defined networking?": {
    "Hardware networking": "SDN moves network control into software.",
    "Physical only": "SDN separates control from the physical devices that forward traffic.",
    "No software": "Software is the defining feature of SDN.",
  },
  "What is software-defined perimeter?": {
    "Physical perimeter": "An SDP is a logical boundary based on identity, not a physical one.",
    "Traditional firewall": "Traditional firewalls protect a network edge. An SDP hides resources until the user is verified.",
    "No boundary": "An SDP creates a dynamic, per-user boundary.",
  },
};
