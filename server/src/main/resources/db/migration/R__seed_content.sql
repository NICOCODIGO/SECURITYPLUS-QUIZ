-- GENERATED FILE — DO NOT EDIT BY HAND.
-- Regenerate with:  node scripts/generate-seed.mjs
--
-- Repeatable migration: Flyway re-applies it whenever the checksum changes,
-- so editing a question means regenerating this file, not adding a new V<n>.
-- Every statement is an upsert, so re-running it is safe.

-- 28 objectives
insert into objectives (code, domain_number, title) values
  ('1.1', 1, 'Compare and contrast various types of security controls.'),
  ('1.2', 1, 'Summarize fundamental security concepts.'),
  ('1.3', 1, 'Explain the importance of change management processes and the impact to security.'),
  ('1.4', 1, 'Explain the importance of using appropriate cryptographic solutions.'),
  ('2.1', 2, 'Compare and contrast common threat actors and motivations.'),
  ('2.2', 2, 'Explain common threat vectors and attack surfaces.'),
  ('2.3', 2, 'Explain various types of vulnerabilities.'),
  ('2.4', 2, 'Given a scenario, analyze indicators of malicious activity.'),
  ('2.5', 2, 'Explain the purpose of mitigation techniques used to secure the enterprise.'),
  ('3.1', 3, 'Compare and contrast security implications of different architecture models.'),
  ('3.2', 3, 'Given a scenario, apply security principles to secure enterprise infrastructure.'),
  ('3.3', 3, 'Compare and contrast concepts and strategies to protect data.'),
  ('3.4', 3, 'Explain the importance of resilience and recovery in security architecture.'),
  ('4.1', 4, 'Given a scenario, apply common security techniques to computing resources.'),
  ('4.2', 4, 'Explain the security implications of proper hardware, software, and data asset management.'),
  ('4.3', 4, 'Explain various activities associated with vulnerability management.'),
  ('4.4', 4, 'Explain security alerting and monitoring concepts and tools.'),
  ('4.5', 4, 'Given a scenario, modify enterprise capabilities to enhance security.'),
  ('4.6', 4, 'Given a scenario, implement and maintain identity and access management.'),
  ('4.7', 4, 'Explain the importance of automation and orchestration related to secure operations.'),
  ('4.8', 4, 'Explain appropriate incident response activities.'),
  ('4.9', 4, 'Given a scenario, use data sources to support an investigation.'),
  ('5.1', 5, 'Summarize elements of effective security governance.'),
  ('5.2', 5, 'Explain elements of the risk management process.'),
  ('5.3', 5, 'Explain the processes associated with third-party risk assessment and management.'),
  ('5.4', 5, 'Summarize elements of effective security compliance.'),
  ('5.5', 5, 'Explain types and purposes of audits and assessments.'),
  ('5.6', 5, 'Given a scenario, implement security awareness practices.')
on conflict (code) do update set
  domain_number = excluded.domain_number,
  title         = excluded.title;

-- 444 questions
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('iybhy3', 'What does the CIA triad stand for in information security?', 'Beginner', '1.2', 1, 'The CIA triad represents the three main pillars of information security: Confidentiality (keeping data private), Integrity (ensuring data accuracy), and Availability (ensuring access when needed).', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('z4etyy', 'Which type of security control is a firewall?', 'Beginner', '1.1', 1, 'A firewall is a technical control that uses technology to enforce security policies by filtering network traffic.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ljvpxw', 'What is authentication?', 'Beginner', '1.2', 1, 'Authentication is the process of verifying that someone or something is who or what they claim to be.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('bx3kow', 'Which authentication factor is a fingerprint scan?', 'Intermediate', '4.6', 1, 'A fingerprint scan is a biometric authentication factor, classified as "something you are".', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ls1n47', 'What is the primary purpose of encryption?', 'Intermediate', '1.4', 1, 'Encryption primarily ensures confidentiality by transforming readable data into an unreadable format without the decryption key.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('eg98n8', 'In a zero-trust security model, which principle is fundamental?', 'Advanced', '1.2', 1, 'Zero-trust security operates on the principle of "never trust, always verify," requiring continuous authentication and authorization for all users and devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('jtwuox', 'What is the purpose of a security policy?', 'Beginner', '5.1', 1, 'A security policy defines the rules and procedures that govern an organization''s approach to security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1r5rau2', 'What is defense in depth?', 'Intermediate', '1.1', 1, 'Defense in depth uses multiple layers of security controls to protect assets.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gut9gw', 'What is the principle of least privilege?', 'Advanced', '2.5', 1, 'Least privilege means granting only the minimum permissions necessary to perform a job.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1koobnp', 'What is authorization?', 'Beginner', '1.2', 1, 'Authorization is the process of granting or denying access to resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('edqvw0', 'What is non-repudiation?', 'Intermediate', '1.2', 1, 'Non-repudiation ensures that someone cannot deny having performed an action.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('187s2rx', 'What is separation of duties?', 'Advanced', '5.1', 1, 'Separation of duties divides critical tasks among multiple people to prevent fraud.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ve2es1', 'What is asset management?', 'Intermediate', '4.2', 1, 'Asset management involves identifying, tracking, and protecting organizational resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('10jus1', 'What is security through obscurity?', 'Advanced', '1.2', 1, 'Security through obscurity is a weak approach that relies on keeping implementation details secret.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('9wryfb', 'What is access control?', 'Beginner', '4.6', 1, 'Access control manages and restricts who can access resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7ea9am', 'What is role-based access control (RBAC)?', 'Intermediate', '4.6', 1, 'RBAC grants access based on a user''s role within an organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('fudefs', 'What is mandatory access control (MAC)?', 'Advanced', '4.6', 1, 'MAC is a strict access control model where the system enforces access policies.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1v94t4e', 'What is a security control?', 'Beginner', '1.1', 1, 'A security control is any safeguard or countermeasure to protect assets.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('c4jn86', 'What is the difference between preventive and detective controls?', 'Intermediate', '1.1', 1, 'Preventive controls stop attacks before they happen, while detective controls identify attacks that have occurred.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jn1epm', 'What is the purpose of hashing?', 'Beginner', '1.4', 1, 'Hashing creates a fixed-size output from input data, primarily used to verify data integrity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('jpv9y7', 'What is attribute-based access control (ABAC)?', 'Advanced', '4.6', 1, 'ABAC grants access based on multiple attributes like user role, time, location, and resource type.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('xcnlz', 'What is the difference between identification and authentication?', 'Intermediate', '1.2', 1, 'Identification is claiming who you are, while authentication is proving that claim.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vrim8e', 'What is accounting in security?', 'Beginner', '1.2', 1, 'Accounting tracks and logs user activities for audit and security purposes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('bvo1r3', 'What is implicit deny?', 'Advanced', '4.6', 1, 'Implicit deny blocks all access unless specifically permitted by policy.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1la9v5q', 'What is a compensating control?', 'Intermediate', '1.1', 1, 'A compensating control provides alternative protection when the primary control is not feasible.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('10hd3tm', 'What is confidentiality?', 'Beginner', '1.2', 1, 'Confidentiality ensures that data is accessible only to authorized parties.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('p8owzi', 'What is security posture?', 'Advanced', '5.1', 1, 'Security posture describes the overall security status and readiness of an organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('18tlug2', 'What is integrity in security?', 'Beginner', '1.2', 1, 'Integrity ensures data remains accurate, consistent, and unaltered by unauthorized parties.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ra6j2h', 'What is risk appetite?', 'Advanced', '5.2', 1, 'Risk appetite defines the level of risk an organization is willing to accept.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('18o06q5', 'What is due care?', 'Intermediate', '5.4', 1, 'Due care involves taking appropriate steps to protect organizational assets.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ljx9n3', 'What is availability?', 'Beginner', '1.2', 1, 'Availability ensures that systems and data are accessible when authorized users need them.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('odzlpc', 'What is discretionary access control (DAC)?', 'Intermediate', '4.6', 1, 'DAC allows resource owners to control who can access their resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5awowm', 'What is context-aware authentication?', 'Advanced', '4.6', 1, 'Context-aware authentication considers factors like location, time, and device for access decisions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1uw4ou0', 'What is a password policy?', 'Beginner', '4.6', 1, 'A password policy defines rules for creating and managing passwords.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1lriks7', 'What is single sign-on (SSO)?', 'Intermediate', '4.6', 1, 'SSO allows users to authenticate once and access multiple systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('axy9nm', 'What is federated identity?', 'Advanced', '4.6', 1, 'Federated identity allows users to use same identity across multiple organizations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('pmnspe', 'What is biometric authentication?', 'Beginner', '4.6', 1, 'Biometric authentication uses unique physical characteristics like fingerprints or face.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1x45qw2', 'What is time-based access control?', 'Intermediate', '4.6', 1, 'Time-based access control restricts access to specific time periods.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('urtxwr', 'What is continuous authentication?', 'Advanced', '4.6', 1, 'Continuous authentication verifies user identity throughout the session.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1m944hq', 'What is multifactor authentication?', 'Beginner', '4.6', 1, 'MFA requires multiple different types of authentication factors.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ta2zf7', 'What is risk assessment?', 'Intermediate', '5.2', 1, 'Risk assessment identifies and evaluates potential security risks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('qe29ou', 'What is a security token?', 'Beginner', '4.6', 1, 'A security token is a physical or virtual device that generates authentication codes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1qn27nm', 'What is risk mitigation?', 'Intermediate', '5.2', 1, 'Risk mitigation implements controls to reduce risk likelihood or impact.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('imsxav', 'What is risk avoidance?', 'Advanced', '5.2', 1, 'Risk avoidance eliminates risk by not engaging in the risky activity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1lxqyyi', 'What is data classification?', 'Beginner', '3.3', 1, 'Data classification categorizes information based on sensitivity level.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('188z4e7', 'What is job rotation?', 'Intermediate', '5.1', 1, 'Job rotation periodically moves employees between different roles to reduce fraud risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1lxblq0', 'What is mandatory vacation?', 'Advanced', '5.1', 1, 'Mandatory vacation requires employees to take time off to detect fraud or misuse.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1fz631b', 'What is encryption?', 'Beginner', '1.4', 1, 'Encryption transforms readable data into unreadable format without the key.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jd7zdk', 'What is data masking?', 'Intermediate', '1.4', 1, 'Data masking obscures sensitive data while maintaining usability.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vc0eb7', 'What is tokenization?', 'Advanced', '1.4', 1, 'Tokenization replaces sensitive data with non-sensitive tokens.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('tjgyg9', 'What is physical security?', 'Beginner', '1.2', 1, 'Physical security protects physical assets like buildings and equipment.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('zecg47', 'What is environmental control?', 'Intermediate', '1.2', 1, 'Environmental controls manage factors like temperature and humidity for equipment.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1scx1az', 'What is security convergence?', 'Advanced', '1.2', 1, 'Security convergence integrates physical and information security functions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1mmg830', 'What is need-to-know?', 'Beginner', '4.6', 1, 'Need-to-know limits access to only information required for job duties.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('21ug6t', 'What is security awareness?', 'Intermediate', '5.6', 1, 'Security awareness means understanding security threats and best practices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('tpnupg', 'What is security governance?', 'Advanced', '5.1', 1, 'Security governance provides the framework and oversight for security programs.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1oc29ud', 'What is acceptable use policy?', 'Beginner', '5.1', 1, 'Acceptable use policy defines appropriate use of organizational resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('o8iz9q', 'What is clean desk policy?', 'Intermediate', '5.6', 1, 'Clean desk policy requires securing sensitive materials when not in use.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1hcc8zx', 'What is data sovereignty?', 'Advanced', '3.3', 1, 'Data sovereignty means data is subject to laws of the country where it resides.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('wy28qa', 'What is privacy?', 'Beginner', '5.4', 1, 'Privacy is the right to control personal information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('h2vnjq', 'What is personally identifiable information (PII)?', 'Intermediate', '5.4', 1, 'PII is information that can identify a specific individual.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1di01xj', 'What is privacy by design?', 'Advanced', '5.4', 1, 'Privacy by design builds privacy into systems from the beginning.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19i58t7', 'What is a security incident?', 'Beginner', '4.8', 1, 'A security incident is an event that requires security response.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('e9md6j', 'What is change control?', 'Intermediate', '1.3', 1, 'Change control is a formal process for managing system changes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('2cfy11', 'What is configuration drift?', 'Advanced', '4.1', 1, 'Configuration drift occurs when system configurations deviate from desired state.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ctrzs4', 'What is hardening?', 'Beginner', '2.5', 1, 'Hardening involves securing a system by reducing attack surface.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1f8f2ad', 'What is attack surface?', 'Intermediate', '2.2', 1, 'Attack surface includes all points where an attacker could enter a system.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('q4bfpf', 'What is defense evasion?', 'Advanced', '2.4', 1, 'Defense evasion techniques help attackers avoid detection by security controls.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vlcopn', 'What is secure by default?', 'Beginner', '4.1', 1, 'Secure by default means systems are configured securely out of the box.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('13ovjpz', 'What is fail secure?', 'Intermediate', '3.2', 1, 'Fail secure means systems default to secure state when failures occur.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('b3d6ye', 'What is trust but verify?', 'Advanced', '1.2', 1, 'Trust but verify means maintaining trust while continuously validating.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6cmelw', 'What is least privilege?', 'Intermediate', '2.5', 1, 'Least privilege grants only minimum access needed for job functions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1p4inue', 'What is zero trust?', 'Advanced', '1.2', 1, 'Zero trust requires verification for every access request regardless of location.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('p3vaq', 'What is detective control?', 'Intermediate', '1.1', 1, 'Detective control identifies and detects security incidents.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('lho59n', 'What is corrective control?', 'Advanced', '1.1', 1, 'Corrective control fixes or mitigates damage after security incident.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('p2a6d9', 'What is preventive control?', 'Beginner', '1.1', 1, 'Preventive control stops security incidents before they occur.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('bs241u', 'What is deterrent control?', 'Intermediate', '1.1', 1, 'Deterrent control discourages potential attackers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19pq5a1', 'What is administrative control?', 'Advanced', '1.1', 1, 'Administrative controls are policies and procedures governing security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('as63pc', 'What is technical control?', 'Beginner', '1.1', 1, 'Technical controls use technology to enforce security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('in9q8i', 'What is physical control?', 'Intermediate', '1.1', 1, 'Physical controls are tangible security measures like locks and cameras.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('d7g9fr', 'What is attribute-based access control?', 'Advanced', '4.6', 1, 'ABAC uses attributes (user, resource, environment) for access decisions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1myfy2t', 'What is role-based access control?', 'Beginner', '4.6', 1, 'RBAC assigns permissions based on user job roles.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('wfkoie', 'What is mandatory access control?', 'Intermediate', '4.6', 1, 'MAC enforces access control based on security labels.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1pc1paj', 'What is rule-based access control?', 'Advanced', '4.6', 1, 'Rule-based access control uses specific rules for access decisions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ie7xv7', 'What is authentication factor?', 'Beginner', '4.6', 1, 'Authentication factor is evidence used to verify identity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1rpf672', 'What is something you know?', 'Intermediate', '4.6', 1, 'Something you know is knowledge-based authentication like passwords.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1rn11yb', 'What is something you have?', 'Advanced', '4.6', 1, 'Something you have is possession-based authentication like security tokens.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jqhqd3', 'What is something you are?', 'Beginner', '4.6', 1, 'Something you are refers to biometric characteristics.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ifpf4o', 'What is somewhere you are?', 'Intermediate', '4.6', 1, 'Somewhere you are uses location as authentication factor.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('xz4mnm', 'What is something you do?', 'Advanced', '4.6', 1, 'Something you do refers to behavioral characteristics like typing patterns.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1m213sr', 'What is dual control?', 'Intermediate', '5.1', 1, 'Dual control requires two people to perform sensitive operations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jdx46x', 'What is security awareness culture?', 'Intermediate', '5.6', 1, 'Security awareness culture embeds security thinking throughout organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ncbkme', 'What is principle of least common mechanism?', 'Advanced', '1.2', 1, 'Least common mechanism minimizes shared resources to reduce attack surface.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('184ka6n', 'What is fail safe?', 'Beginner', '3.2', 1, 'Fail safe ensures system remains safe even during failure.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1oifmkg', 'What is keep it simple?', 'Intermediate', '1.2', 1, 'Keep it simple principle says simplicity reduces vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5p2yt', 'What is privacy threshold assessment?', 'Advanced', '5.4', 1, 'Privacy threshold assessment determines if privacy impact analysis is needed.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1l5mqia', 'What is risk register?', 'Beginner', '5.2', 1, 'Risk register documents identified risks and mitigation plans.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1xtrc1g', 'What is risk acceptance?', 'Intermediate', '5.2', 1, 'Risk acceptance means consciously accepting identified risks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7n0thi', 'What is residual risk?', 'Advanced', '5.2', 1, 'Residual risk is what remains after implementing controls.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wzxpuy', 'What is inherent risk?', 'Beginner', '5.2', 1, 'Inherent risk is natural risk level before any controls.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1caei8s', 'What is qualitative risk assessment?', 'Intermediate', '5.2', 1, 'Qualitative assessment uses subjective judgment to evaluate risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('zvhuvm', 'What is quantitative risk assessment?', 'Advanced', '5.2', 1, 'Quantitative assessment uses numerical data to calculate risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dzcj3f', 'What is single loss expectancy?', 'Beginner', '5.2', 1, 'SLE is expected monetary loss from a single security incident.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1uw8tyg', 'What is annual loss expectancy?', 'Intermediate', '5.2', 1, 'ALE is expected monetary loss per year from specific risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('17eg0yl', 'What is malware?', 'Beginner', '2.4', 2, 'Malware is short for malicious software, any program or code designed to harm, exploit, or compromise computer systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('3ph3u6', 'What is phishing?', 'Beginner', '2.2', 2, 'Phishing is a social engineering attack where attackers send fraudulent emails disguised as legitimate communications to trick recipients into revealing sensitive information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ous7n9', 'What type of attack involves overwhelming a system with traffic?', 'Intermediate', '2.4', 2, 'A Denial of Service (DoS) attack attempts to make a system unavailable by overwhelming it with excessive traffic or requests.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('dqp7v7', 'What is ransomware?', 'Intermediate', '2.4', 2, 'Ransomware is malicious software that encrypts a victim''s files and demands payment (usually in cryptocurrency) for the decryption key.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1nxb28p', 'What is the MITRE ATT&CK framework used for?', 'Advanced', '2.4', 2, 'The MITRE ATT&CK framework is a knowledge base of adversary tactics, techniques, and procedures (TTPs) based on real-world observations, used for threat modeling and detection.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('14hvwdb', 'What is a vulnerability?', 'Beginner', '2.3', 2, 'A vulnerability is a weakness in a system that can be exploited.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('wsgr6t', 'What is a zero-day exploit?', 'Intermediate', '2.3', 2, 'A zero-day exploit targets vulnerabilities that are unknown to the vendor.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('on29ix', 'What is advanced persistent threat (APT)?', 'Advanced', '2.1', 2, 'An APT is a prolonged and targeted cyberattack by sophisticated threat actors.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ddefju', 'What is social engineering?', 'Beginner', '2.2', 2, 'Social engineering manipulates people into revealing confidential information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1sfyjpl', 'What is spear phishing?', 'Intermediate', '2.2', 2, 'Spear phishing is a targeted phishing attack aimed at specific individuals or organizations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1saafku', 'What is privilege escalation?', 'Advanced', '2.4', 2, 'Privilege escalation is gaining unauthorized elevated access to resources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5pw8dg', 'What is a trojan horse?', 'Beginner', '2.4', 2, 'A trojan horse is malware that appears to be legitimate software.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vkhvl3', 'What is SQL injection?', 'Intermediate', '2.3', 2, 'SQL injection inserts malicious SQL code to manipulate databases.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wcs3q5', 'What is a supply chain attack?', 'Advanced', '2.2', 2, 'A supply chain attack compromises a trusted third-party to reach the target.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5lhnri', 'What is a virus?', 'Beginner', '2.4', 2, 'A virus is malware that can replicate itself and spread to other files.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6nekmy', 'What is a worm?', 'Intermediate', '2.4', 2, 'A worm is self-replicating malware that spreads without user interaction.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1rhxmdd', 'What is a rootkit?', 'Advanced', '2.4', 2, 'A rootkit is malware designed to hide its presence and provide unauthorized access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('q7w6o9', 'What is malvertising?', 'Beginner', '2.2', 2, 'Malvertising uses online advertising to distribute malware.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('qlool1', 'What is watering hole attack?', 'Intermediate', '2.2', 2, 'A watering hole attack compromises websites frequently visited by the target.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1alelvk', 'What is typosquatting?', 'Advanced', '2.2', 2, 'Typosquatting registers domains similar to legitimate ones to deceive users.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19kk6w1', 'What is a botnet?', 'Beginner', '2.4', 2, 'A botnet is a network of infected computers controlled by an attacker.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('w2560l', 'What is credential stuffing?', 'Intermediate', '2.4', 2, 'Credential stuffing uses stolen username/password pairs across multiple sites.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('elqgzx', 'What is a fileless malware attack?', 'Advanced', '2.4', 2, 'Fileless malware operates in memory without writing files to disk, making detection harder.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1enioh4', 'What is adware?', 'Beginner', '2.4', 2, 'Adware is software that automatically displays or downloads advertising material.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1u6ldgj', 'What is a logic bomb?', 'Intermediate', '2.4', 2, 'A logic bomb is malicious code that executes when specific conditions are met.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('15s3nvl', 'What is a race condition vulnerability?', 'Advanced', '2.3', 2, 'A race condition occurs when timing or sequence of events affects program correctness, potentially creating security vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19dsfii', 'What is pharming?', 'Beginner', '2.4', 2, 'Pharming redirects users from legitimate websites to fraudulent ones to steal information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('o5rj5q', 'What is pretexting?', 'Intermediate', '2.2', 2, 'Pretexting is a social engineering technique where an attacker creates a fabricated scenario to obtain information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1xxa8wo', 'What is tailgating?', 'Beginner', '2.2', 2, 'Tailgating is physical security breach where someone follows an authorized person through a secure door.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1eq2ift', 'What is an insider threat?', 'Advanced', '2.1', 2, 'An insider threat originates from people within the organization who have authorized access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('r5atbg', 'What is vishing?', 'Intermediate', '2.2', 2, 'Vishing is voice phishing conducted over phone calls to trick victims.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('28z3ti', 'What is smishing?', 'Beginner', '2.2', 2, 'Smishing is phishing conducted through SMS text messages.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('b7lpr8', 'What is a polymorphic virus?', 'Advanced', '2.4', 2, 'A polymorphic virus changes its code to evade detection while maintaining functionality.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('qmfug9', 'What is dumpster diving?', 'Intermediate', '2.2', 2, 'Dumpster diving involves searching through trash to find sensitive information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wyhni0', 'What is shoulder surfing?', 'Beginner', '2.2', 2, 'Shoulder surfing is observing someone (over their shoulder) to steal information like passwords.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1pyznes', 'What is command and control (C&C)?', 'Advanced', '2.4', 2, 'A C&C server controls compromised systems in a botnet or malware network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('umquqa', 'What is baiting?', 'Intermediate', '2.2', 2, 'Baiting leaves an infected device (like USB drive) hoping someone will use it.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('175enyy', 'What is a backdoor?', 'Beginner', '2.4', 2, 'A backdoor is a hidden method for bypassing normal authentication.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('15vmqy4', 'What is cryptojacking?', 'Advanced', '2.4', 2, 'Cryptojacking uses victim systems to mine cryptocurrency without permission.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7fw65', 'What is keylogger?', 'Intermediate', '2.4', 2, 'A keylogger records user keystrokes to steal passwords and data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('14gepx', 'What is spam?', 'Beginner', '2.2', 2, 'Spam is unsolicited bulk email, often containing malware or scams.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('hj21eo', 'What is session hijacking?', 'Advanced', '2.4', 2, 'Session hijacking takes over an active authenticated session.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('kst05e', 'What is cross-site scripting (XSS)?', 'Intermediate', '2.3', 2, 'XSS injects malicious scripts into trusted websites viewed by users.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ry6pnk', 'What is a denial of service attack?', 'Beginner', '2.4', 2, 'DoS attacks make services unavailable to legitimate users.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('9cj2aq', 'What is buffer overflow?', 'Advanced', '2.3', 2, 'Buffer overflow occurs when program writes more data than buffer can hold.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('c0ppe3', 'What is eavesdropping?', 'Intermediate', '2.4', 2, 'Eavesdropping intercepts private communications without authorization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('jdwi8s', 'What is impersonation?', 'Beginner', '2.2', 2, 'Impersonation involves pretending to be another person to gain access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('b4id20', 'What is a side-channel attack?', 'Advanced', '2.3', 2, 'Side-channel attacks exploit information leaked during system operations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('261cio', 'What is reconnaissance?', 'Intermediate', '5.5', 2, 'Reconnaissance gathers information about targets before attacking.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gtnl93', 'What is social media threat?', 'Beginner', '2.2', 2, 'Social media threats exploit social platforms for attacks or information gathering.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1o89vpr', 'What is DNS poisoning?', 'Advanced', '2.4', 2, 'DNS poisoning corrupts DNS cache to redirect users to malicious sites.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1sm99ki', 'What is IP spoofing?', 'Intermediate', '2.4', 2, 'IP spoofing falsifies the source IP address in network packets.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dvp6u7', 'What is password attack?', 'Beginner', '2.4', 2, 'Password attacks attempt to discover or crack user passwords.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1i3hyq2', 'What is pass-the-hash?', 'Advanced', '2.4', 2, 'Pass-the-hash uses stolen password hashes for authentication without cracking.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1llgw9p', 'What is brute force attack?', 'Intermediate', '2.4', 2, 'Brute force tries all possible combinations to crack passwords.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19l5zgp', 'What is elicitation?', 'Beginner', '2.2', 2, 'Elicitation extracts information through casual conversation.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6cswp1', 'What is a hoax?', 'Advanced', '2.2', 2, 'A hoax is a false threat or warning that causes disruption.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('64pgnl', 'What is clickjacking?', 'Intermediate', '2.4', 2, 'Clickjacking tricks users into clicking on hidden elements.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1nrpyny', 'What is whaling?', 'Beginner', '2.2', 2, 'Whaling is phishing that targets high-profile individuals like executives.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('uywxsk', 'What is domain hijacking?', 'Advanced', '2.4', 2, 'Domain hijacking gains unauthorized control over domain name.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('g74utr', 'What is URL hijacking?', 'Intermediate', '2.2', 2, 'URL hijacking registers misspelled URLs to capture traffic.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('10kt1r9', 'What is invoice scam?', 'Beginner', '2.2', 2, 'Invoice scam uses fake invoices to trick victims into paying.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('rkhf5v', 'What is on-path attack?', 'Advanced', '2.4', 2, 'On-path attack (man-in-the-middle) intercepts communications between parties.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('o6vv89', 'What is replay attack?', 'Intermediate', '2.4', 2, 'Replay attack captures and retransmits valid data to gain access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1s87hlv', 'What is birthday attack?', 'Beginner', '2.4', 2, 'Birthday attack exploits probability of hash collisions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1ljorhj', 'What is downgrade attack?', 'Advanced', '2.4', 2, 'Downgrade attack forces use of older, weaker security protocols.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1izp0lt', 'What is a watering hole strategy?', 'Intermediate', '2.2', 2, 'Watering hole compromises websites frequently visited by target group.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('136ztab', 'What is piggybacking?', 'Beginner', '2.2', 2, 'Piggybacking is when unauthorized person follows authorized person through secure entry.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gp4i98', 'What is adversarial AI?', 'Advanced', '2.3', 2, 'Adversarial AI uses AI techniques to attack or deceive other AI systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('8ua5vf', 'What is juice jacking?', 'Intermediate', '2.2', 2, 'Juice jacking installs malware through compromised USB charging ports.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ibqxhq', 'What is a security misconfiguration?', 'Beginner', '2.3', 2, 'Security misconfiguration is when security settings are incorrectly configured.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('15zvt81', 'What is a living off the land attack?', 'Advanced', '2.4', 2, 'Living off the land uses legitimate system tools to avoid detection.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1d4zl13', 'What is a DDoS attack?', 'Intermediate', '2.4', 2, 'DDoS attack uses multiple systems to overwhelm a target.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('14bd62m', 'What is vulnerability?', 'Beginner', '2.3', 2, 'A vulnerability is a weakness that can be exploited by threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('xzi63l', 'What is exploit kit?', 'Advanced', '2.4', 2, 'Exploit kit automates the exploitation of vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vjr30y', 'What is code injection?', 'Intermediate', '2.4', 2, 'Code injection inserts malicious code into vulnerable applications.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ym0d25', 'What is XML external entity attack?', 'Advanced', '2.4', 2, 'XXE attack exploits vulnerable XML processors.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('wtjjmg', 'What is LDAP injection?', 'Intermediate', '2.4', 2, 'LDAP injection manipulates LDAP queries to access unauthorized data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('t9zot2', 'What is command injection?', 'Beginner', '2.4', 2, 'Command injection executes arbitrary OS commands on system.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1cwfjrx', 'What is directory traversal?', 'Intermediate', '2.4', 2, 'Directory traversal accesses files outside intended directory.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('151j9fr', 'What is cross-site request forgery?', 'Beginner', '2.4', 2, 'CSRF tricks users into executing unwanted actions on websites.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7rbtwk', 'What is server-side request forgery?', 'Advanced', '2.4', 2, 'SSRF tricks server into making requests to unintended locations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1iy4wye', 'What is race condition?', 'Intermediate', '2.3', 2, 'Race condition occurs when timing affects correctness of operations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jedwbs', 'What is an APT?', 'Beginner', '2.1', 2, 'APT is prolonged targeted attack by sophisticated adversary.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1nxcxkk', 'What is fileless malware?', 'Advanced', '2.4', 2, 'Fileless malware runs in memory without touching disk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('13pyq76', 'What is logic bomb?', 'Intermediate', '2.4', 2, 'Logic bomb is malicious code activated by specific conditions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5ohjlv', 'What is a trojan?', 'Beginner', '2.4', 2, 'Trojan is malware disguised as legitimate software.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('wsnelc', 'What is rootkit?', 'Advanced', '2.4', 2, 'Rootkit is malware designed to hide its presence and activities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1j79gnz', 'What is spyware?', 'Advanced', '2.4', 2, 'Spyware secretly monitors and collects user information.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nv6cfu', 'What is a bot?', 'Intermediate', '2.4', 2, 'Bot is compromised computer controlled by attacker.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nusxb0', 'What is a RAT?', 'Advanced', '2.4', 2, 'RAT is malware providing remote control of infected system.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1m95pl9', 'What is ARP poisoning?', 'Advanced', '2.4', 2, 'ARP poisoning sends fake ARP messages to intercept traffic.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5ho6k7', 'What is MAC flooding?', 'Intermediate', '2.4', 2, 'MAC flooding overwhelms switch causing it to act as hub.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1l0c9kj', 'What is a rogue access point?', 'Beginner', '2.4', 2, 'Rogue access point is unauthorized wireless access point.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('bgqm9y', 'What is evil twin?', 'Advanced', '2.4', 2, 'Evil twin is rogue access point mimicking legitimate one.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1mtp07a', 'What is WPS attack?', 'Intermediate', '2.4', 2, 'WPS attack exploits weaknesses in Wi-Fi Protected Setup.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('rx6gcz', 'What is bluejacking?', 'Beginner', '2.4', 2, 'Bluejacking sends unsolicited messages via Bluetooth.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('11djlxw', 'What is bluesnarfing?', 'Advanced', '2.4', 2, 'Bluesnarfing steals information from Bluetooth devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('fo9qoz', 'What is RFID cloning?', 'Intermediate', '2.4', 2, 'RFID cloning copies RFID tags for unauthorized access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dtkbdv', 'What is NFC attack?', 'Beginner', '2.4', 2, 'NFC attack exploits near-field communication vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1oagxzr', 'What is jamming?', 'Advanced', '2.4', 2, 'Jamming intentionally disrupts wireless communications.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19hv92p', 'What is wardriving?', 'Intermediate', '2.2', 2, 'Wardriving searches for Wi-Fi networks while moving.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('yh6cne', 'What is a zero-day vulnerability?', 'Beginner', '2.3', 2, 'Zero-day is vulnerability unknown to vendor with no patch.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('11vx3jj', 'What is threat intelligence?', 'Advanced', '4.3', 2, 'Threat intelligence is evidence-based knowledge about threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('xf9kxq', 'What is indicator of attack?', 'Intermediate', '2.4', 2, 'IoA shows attack in progress or imminent.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('afrjuw', 'What is vulnerability scanner?', 'Beginner', '4.3', 2, 'Vulnerability scanner identifies security weaknesses in systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19ptl0c', 'What is weaponization?', 'Advanced', '2.4', 2, 'Weaponization combines malware with exploit into deliverable payload.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ovv2zw', 'What is network segmentation?', 'Beginner', '3.1', 3, 'Network segmentation is the practice of dividing a network into smaller, isolated segments to improve security and performance by limiting the spread of threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('onkdyc', 'What is a DMZ in network architecture?', 'Beginner', '3.2', 3, 'A DMZ (Demilitarized Zone) is a network segment that sits between an internal network and the internet, hosting public-facing services while protecting the internal network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('s3crdq', 'What is the purpose of data classification?', 'Intermediate', '3.3', 3, 'Data classification organizes data based on its sensitivity, value, and criticality to apply appropriate security controls and handling procedures.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('102dhui', 'In cloud architecture, what is the shared responsibility model?', 'Advanced', '3.1', 3, 'The shared responsibility model divides security responsibilities between the cloud provider (security OF the cloud) and the customer (security IN the cloud).', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nuwco9', 'What is a VPN?', 'Beginner', '3.2', 3, 'A VPN creates a secure encrypted tunnel over a public network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7c4fa4', 'What is microsegmentation?', 'Intermediate', '3.1', 3, 'Microsegmentation divides networks into very small, granular segments for better security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ge8q8p', 'What is software-defined networking (SDN)?', 'Advanced', '3.1', 3, 'SDN separates the network control plane from the data plane for centralized management.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('pbek6q', 'What is encryption at rest?', 'Beginner', '1.4', 3, 'Encryption at rest protects data stored on disks or other storage media.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1tm8rc8', 'What is a jump server?', 'Intermediate', '3.2', 3, 'A jump server is an intermediary used to securely access systems in different security zones.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('13hzns2', 'What is Infrastructure as Code (IaC)?', 'Advanced', '3.1', 3, 'IaC manages and provisions infrastructure through machine-readable definition files.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1txzs7i', 'What is a proxy server?', 'Beginner', '3.2', 3, 'A proxy server acts as an intermediary between clients and other servers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('k2oohf', 'What is load balancing?', 'Intermediate', '3.2', 3, 'Load balancing distributes network traffic across multiple servers for performance and reliability.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('u5n5qv', 'What is a security orchestration platform?', 'Advanced', '4.7', 3, 'Security orchestration platforms automate and coordinate security tools and workflows.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('dk9jec', 'What is network access control (NAC)?', 'Beginner', '4.5', 3, 'NAC controls which devices can access the network based on policies.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('10p9mnf', 'What is a honeypot?', 'Intermediate', '1.2', 3, 'A honeypot is a decoy system designed to attract and study attacker behavior.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1x7it9s', 'What is east-west traffic?', 'Advanced', '3.1', 3, 'East-west traffic moves laterally between servers within a data center or network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5zbn3a', 'What is a VLAN?', 'Beginner', '3.1', 3, 'A VLAN is a virtual network that logically segments a physical network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1y7u07', 'What is network address translation (NAT)?', 'Intermediate', '3.2', 3, 'NAT translates private IP addresses to public IP addresses for internet access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('itzq5c', 'What is perfect forward secrecy?', 'Advanced', '1.4', 3, 'Perfect forward secrecy generates unique session keys so compromising one doesn''t affect others.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ja6q0b', 'What is a firewall?', 'Beginner', '3.2', 3, 'A firewall is a network security device that monitors and controls incoming and outgoing traffic.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1roamlf', 'What is the difference between symmetric and asymmetric encryption?', 'Intermediate', '1.4', 3, 'Symmetric encryption uses the same key for encryption and decryption, while asymmetric uses public and private key pairs.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('q2bhwk', 'What is containerization in security?', 'Advanced', '3.1', 3, 'Containerization packages applications with dependencies in isolated environments for security and portability.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gjpg40', 'What does SSL/TLS provide?', 'Beginner', '1.4', 3, 'SSL/TLS protocols provide encrypted communication over networks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1od8gyr', 'What is a bastion host?', 'Intermediate', '3.2', 3, 'A bastion host is a specially hardened server designed to withstand attacks, typically in a DMZ.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1k1dssr', 'What is quantum cryptography?', 'Advanced', '1.4', 3, 'Quantum cryptography uses quantum mechanics principles for theoretically unbreakable encryption.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('3mzk9n', 'What is network topology?', 'Beginner', '3.1', 3, 'Network topology describes the arrangement of network elements and connections.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1x3bk4o', 'What is air gap?', 'Intermediate', '3.1', 3, 'An air gap physically isolates a system from unsecured networks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jvvu4p', 'What is network function virtualization?', 'Advanced', '3.1', 3, 'NFV runs network functions as virtualized software instead of dedicated hardware.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('w6c7ee', 'What is a router?', 'Beginner', '3.2', 3, 'A router forwards data packets between different networks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('4avbht', 'What is port security?', 'Intermediate', '3.2', 3, 'Port security restricts which devices can connect to network switch ports.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1qmpox', 'What is blockchain in security?', 'Advanced', '1.4', 3, 'Blockchain is a distributed, immutable ledger technology used for secure transactions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1mh689z', 'What is a switch?', 'Beginner', '3.2', 3, 'A switch connects devices within a network and forwards data to specific devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1xna7jd', 'What is geofencing?', 'Intermediate', '3.3', 3, 'Geofencing uses location to trigger security controls or access restrictions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('e1dx0w', 'What is steganography?', 'Advanced', '1.4', 3, 'Steganography hides messages or data within other non-secret files or media.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('p6hzb5', 'What is cloud computing?', 'Beginner', '3.1', 3, 'Cloud computing delivers computing services over the internet on-demand.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ah9hu', 'What is IaaS?', 'Intermediate', '3.1', 3, 'IaaS provides virtualized computing infrastructure over the internet.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('18vr794', 'What is serverless computing?', 'Advanced', '3.1', 3, 'Serverless computing abstracts server management from developers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ff6xl', 'What is PaaS?', 'Beginner', '3.1', 3, 'PaaS provides a platform for developing and running applications.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('hjg4c', 'What is SaaS?', 'Intermediate', '3.1', 3, 'SaaS delivers software applications over the internet.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('f0ia9r', 'What is edge computing?', 'Advanced', '3.1', 3, 'Edge computing processes data closer to where it is generated.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1gxzank', 'What is network protocol?', 'Beginner', '3.2', 3, 'Network protocol defines rules for data communication between devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('99j960', 'What is IPSec?', 'Intermediate', '3.2', 3, 'IPSec is a protocol suite for securing IP communications.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('jz99r', 'What is WPA3?', 'Advanced', '4.1', 3, 'WPA3 is the latest Wi-Fi security standard with enhanced protection.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('isk100', 'What is Wi-Fi?', 'Beginner', '4.1', 3, 'Wi-Fi is wireless networking technology using radio waves.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1rbcgw5', 'What is 802.1X?', 'Intermediate', '3.2', 3, '802.1X provides network access control based on port authentication.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1prfkpo', 'What is RADIUS?', 'Advanced', '4.1', 3, 'RADIUS is a protocol for centralized authentication and authorization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197g93t', 'What is DNS?', 'Beginner', '3.2', 3, 'DNS translates domain names to IP addresses.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jkvwxg', 'What is DNSSEC?', 'Intermediate', '4.5', 3, 'DNSSEC adds security to DNS with digital signatures.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1f8zbm0', 'What is DNS over HTTPS?', 'Advanced', '4.5', 3, 'DNS over HTTPS encrypts DNS queries for privacy.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('8p2e13', 'What is HTTPS?', 'Beginner', '4.5', 3, 'HTTPS is HTTP with encryption using SSL/TLS.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1cqrcga', 'What is certificate pinning?', 'Intermediate', '1.4', 3, 'Certificate pinning associates a host with expected certificate.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('9grau', 'What is HSTS?', 'Advanced', '4.5', 3, 'HSTS forces browsers to use HTTPS connections.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197dqct', 'What is AES?', 'Beginner', '1.4', 3, 'AES is a widely used symmetric encryption standard.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197r522', 'What is RSA?', 'Intermediate', '1.4', 3, 'RSA is a widely used asymmetric encryption algorithm.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('x0hhsr', 'What is elliptic curve cryptography?', 'Advanced', '1.4', 3, 'ECC uses elliptic curves for strong encryption with smaller keys.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dpnqx1', 'What is a digital signature?', 'Beginner', '1.4', 3, 'Digital signature verifies authenticity and integrity of digital messages.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197pf2w', 'What is PKI?', 'Intermediate', '1.4', 3, 'PKI manages digital certificates and public-key encryption.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('m9tpmo', 'What is certificate authority?', 'Advanced', '1.4', 3, 'Certificate authority issues and manages digital certificates.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wmoymn', 'What is secure boot?', 'Beginner', '1.4', 3, 'Secure boot ensures only trusted software loads during boot.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197smat', 'What is TPM?', 'Intermediate', '1.4', 3, 'TPM is hardware chip providing cryptographic functions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197jg2k', 'What is HSM?', 'Advanced', '1.4', 3, 'HSM is dedicated hardware for managing cryptographic keys.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('yw7bgd', 'What is full disk encryption?', 'Beginner', '1.4', 3, 'Full disk encryption encrypts all data on a storage device.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1p3tj27', 'What is file encryption?', 'Intermediate', '1.4', 3, 'File encryption protects individual files with encryption.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1nol0is', 'What is homomorphic encryption?', 'Advanced', '1.4', 3, 'Homomorphic encryption allows computation on encrypted data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1l1i4bq', 'What is a subnet?', 'Beginner', '3.1', 3, 'A subnet is a logical subdivision of an IP network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('a4n09', 'What is IPv6?', 'Intermediate', '3.2', 3, 'IPv6 is the latest Internet Protocol version with larger address space.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197ejot', 'What is BGP?', 'Advanced', '3.2', 3, 'BGP is the protocol routing traffic between autonomous systems on internet.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('sa4v4b', 'What is MAC address?', 'Beginner', '3.2', 3, 'MAC address is unique hardware identifier for network interfaces.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197e17b', 'What is ARP?', 'Intermediate', '3.2', 3, 'ARP maps IP addresses to MAC addresses on local networks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('htwul9', 'What is VXLAN?', 'Advanced', '3.1', 3, 'VXLAN is network virtualization technology for cloud environments.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('13k61ih', 'What is bandwidth?', 'Beginner', '3.1', 3, 'Bandwidth is the maximum data transmission rate of a network.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197r1bb', 'What is QoS?', 'Intermediate', '3.1', 3, 'QoS manages network traffic to ensure performance levels.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('cxcpc', 'What is MPLS?', 'Advanced', '3.2', 3, 'MPLS directs data using labels for efficient routing.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('blz4w1', 'What is redundancy?', 'Beginner', '3.4', 3, 'Redundancy provides backup systems to ensure availability.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('lwfk0f', 'What is high availability?', 'Intermediate', '3.4', 3, 'High availability ensures systems remain operational with minimal downtime.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('12pgvtd', 'What is active-active configuration?', 'Advanced', '3.4', 3, 'Active-active has all systems processing traffic simultaneously.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('j4zvv4', 'What is active-passive configuration?', 'Intermediate', '3.4', 3, 'Active-passive has one active system with standby backup.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1f9anjp', 'What is containerization?', 'Beginner', '3.1', 3, 'Containerization packages applications with dependencies in isolated containers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1905wol', 'What is microservices architecture?', 'Advanced', '3.1', 3, 'Microservices architecture structures app as collection of small services.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1k48jz4', 'What is API gateway?', 'Intermediate', '4.7', 3, 'API gateway manages and routes API requests to backend services.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('czbnik', 'What is REST API?', 'Beginner', '4.7', 3, 'REST API is web service architecture using HTTP methods.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1tbf6fm', 'What is service mesh?', 'Advanced', '3.1', 3, 'Service mesh manages microservice-to-microservice communication.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('q2acg4', 'What is infrastructure as code?', 'Intermediate', '3.1', 3, 'IaC manages infrastructure using configuration files and code.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('4c10l', 'What is DevOps?', 'Beginner', '4.7', 3, 'DevOps combines software development and IT operations practices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mn15s', 'What is DevSecOps?', 'Advanced', '4.7', 3, 'DevSecOps integrates security practices throughout DevOps lifecycle.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('57zxqu', 'What is CI/CD?', 'Intermediate', '4.7', 3, 'CI/CD automates code integration, testing, and deployment.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('17nbsu3', 'What is version control?', 'Beginner', '1.3', 3, 'Version control tracks and manages changes to code over time.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('15lv8ad', 'What is immutable infrastructure?', 'Advanced', '3.1', 3, 'Immutable infrastructure replaces rather than modifies systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('119p6hw', 'What is snapshot?', 'Intermediate', '3.4', 3, 'Snapshot captures system state at specific point in time.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('h0axu', 'What is SIEM?', 'Beginner', '4.4', 3, 'SIEM collects and analyzes security events from multiple sources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('h4u2x', 'What is SOAR?', 'Advanced', '4.7', 3, 'SOAR automates security operations and incident response.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197nn2e', 'What is NAC?', 'Intermediate', '4.5', 3, 'NAC controls device access to networks based on policies.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197g8fz', 'What is DMZ?', 'Beginner', '3.2', 3, 'DMZ is network segment isolating external-facing services.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1knh8b2', 'What is screened subnet?', 'Advanced', '3.2', 3, 'Screened subnet places DMZ between two firewalls for layered security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('18qu3gn', 'What is jump server?', 'Intermediate', '3.2', 3, 'Jump server provides secure access point for managing network devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gfke19', 'What is proxy server?', 'Beginner', '3.2', 3, 'Proxy server acts as intermediary between clients and servers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('xtp1xu', 'What is reverse proxy?', 'Advanced', '3.2', 3, 'Reverse proxy sits in front of servers handling client requests.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197ukpe', 'What is WAF?', 'Intermediate', '3.2', 3, 'WAF protects web applications from HTTP-based attacks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1fngq1c', 'What is next-gen firewall?', 'Beginner', '3.2', 3, 'Next-gen firewall includes deep packet inspection and application awareness.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('10j5p9', 'What is unified threat management?', 'Advanced', '3.2', 3, 'UTM combines multiple security functions in single appliance.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197g7ck', 'What is DLP?', 'Intermediate', '4.5', 3, 'DLP prevents unauthorized data transmission outside organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('17od631', 'What is endpoint security?', 'Beginner', '4.5', 3, 'Endpoint security protects end-user devices like laptops and phones.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197gsen', 'What is EDR?', 'Advanced', '4.5', 3, 'EDR monitors and responds to threats on endpoints.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197my42', 'What is MDM?', 'Intermediate', '4.1', 3, 'MDM manages and secures mobile devices in organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5cqpu', 'What is BYOD?', 'Beginner', '4.1', 3, 'BYOD allows employees to use personal devices for work.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5uhcr', 'What is COPE?', 'Advanced', '4.1', 3, 'COPE provides company devices for business and personal use.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('625s3', 'What is CYOD?', 'Intermediate', '4.1', 3, 'CYOD lets employees choose from approved devices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('197tvkn', 'What is VDI?', 'Beginner', '3.1', 3, 'VDI hosts desktop environments on centralized servers.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('yv1vc3', 'What is software-defined networking?', 'Advanced', '3.1', 3, 'SDN separates network control from physical infrastructure.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wughs8', 'What is software-defined perimeter?', 'Advanced', '3.2', 3, 'SDP creates identity-based network perimeter hiding infrastructure.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('b7xf68', 'What is multi-factor authentication (MFA)?', 'Beginner', '4.6', 4, 'Multi-factor authentication requires users to provide two or more different authentication factors (like password + fingerprint) to verify their identity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('yk37pg', 'What does IDS stand for?', 'Beginner', '4.5', 4, 'IDS stands for Intrusion Detection System, which monitors network traffic for suspicious activity and alerts administrators to potential threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('16u9xvt', 'What is the difference between IDS and IPS?', 'Intermediate', '4.5', 4, 'IDS (Intrusion Detection System) monitors and alerts on suspicious activity, while IPS (Intrusion Prevention System) can actively block or prevent threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1sfb798', 'What is SOAR in security operations?', 'Advanced', '4.7', 4, 'SOAR (Security Orchestration, Automation, and Response) platforms integrate security tools, automate workflows, and streamline incident response processes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('alw83l', 'What is patch management?', 'Beginner', '4.3', 4, 'Patch management is the process of applying updates to fix security vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gat1ig', 'What is a SIEM system?', 'Intermediate', '4.4', 4, 'SIEM collects, analyzes, and correlates security events from multiple sources.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('8qlwl5', 'What is threat hunting?', 'Advanced', '4.8', 4, 'Threat hunting proactively searches for hidden threats that evaded automated detection.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('kihqq9', 'What is security awareness training?', 'Beginner', '5.6', 4, 'Security awareness training educates users about security threats and best practices.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('4ej98e', 'What is log aggregation?', 'Intermediate', '4.4', 4, 'Log aggregation collects and centralizes logs from multiple systems for analysis.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('t1l4ah', 'What is behavioral analytics?', 'Advanced', '4.5', 4, 'Behavioral analytics uses machine learning to detect abnormal behavior patterns.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dihq2q', 'What is account lockout?', 'Beginner', '4.6', 4, 'Account lockout temporarily disables accounts after multiple failed login attempts.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('4e3lrx', 'What is privileged access management (PAM)?', 'Intermediate', '4.6', 4, 'PAM securely manages and monitors privileged accounts and access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ixsg4x', 'What is security orchestration?', 'Advanced', '4.7', 4, 'Security orchestration automates and coordinates security tools and processes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1obw01b', 'What is vulnerability scanning?', 'Intermediate', '4.3', 4, 'Vulnerability scanning automatically identifies security weaknesses in systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1nbvl69', 'What is continuous monitoring?', 'Advanced', '4.4', 4, 'Continuous monitoring provides ongoing real-time visibility into security posture.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('o7cplo', 'What is an audit log?', 'Beginner', '4.9', 4, 'An audit log records system activities for security review and compliance.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1tzwrgb', 'What is penetration testing?', 'Intermediate', '5.5', 4, 'Penetration testing simulates real attacks to identify security weaknesses.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mrz1v5', 'What is purple teaming?', 'Advanced', '5.5', 4, 'Purple teaming combines offensive (red) and defensive (blue) teams to improve security.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('viozd4', 'What is the purpose of antivirus software?', 'Beginner', '4.4', 4, 'Antivirus software detects, prevents, and removes malicious software.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6ckdnx', 'What is security automation?', 'Intermediate', '4.7', 4, 'Security automation uses technology to automatically perform repetitive security tasks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('jr2gcb', 'What is threat intelligence sharing?', 'Advanced', '4.3', 4, 'Threat intelligence sharing involves exchanging information about threats and vulnerabilities between organizations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('130q8le', 'What is endpoint detection and response (EDR)?', 'Intermediate', '4.5', 4, 'EDR solutions monitor endpoint devices for threats and provide response capabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('awjzvv', 'What is deception technology?', 'Advanced', '1.2', 4, 'Deception technology uses decoys like honeypots and fake data to detect and analyze attacker behavior.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nzu2q1', 'What is configuration management?', 'Beginner', '4.1', 4, 'Configuration management maintains systems in desired, consistent state.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1mlh2r3', 'What is baseline configuration?', 'Intermediate', '4.1', 4, 'Baseline configuration defines the minimum security standards for system setup.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1aj5q7f', 'What is threat modeling?', 'Advanced', '5.2', 4, 'Threat modeling systematically identifies and evaluates potential threats to systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1a3wfer', 'What is a firewall rule?', 'Beginner', '4.5', 4, 'A firewall rule defines how the firewall should handle specific network traffic.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mwsiw2', 'What is asset inventory?', 'Intermediate', '4.2', 4, 'Asset inventory tracks all hardware, software, and data assets in organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('m9h0j8', 'What is security analytics?', 'Advanced', '4.4', 4, 'Security analytics uses data analysis to identify patterns and threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('eu1j2y', 'What is user provisioning?', 'Beginner', '4.6', 4, 'User provisioning creates and configures user accounts with appropriate access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('14hk438', 'What is certificate management?', 'Intermediate', '1.4', 4, 'Certificate management handles the lifecycle of digital certificates.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1lowebg', 'What is security maturity model?', 'Advanced', '5.1', 4, 'Security maturity model measures and guides organization''s security program development.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('d1vcq0', 'What is backup testing?', 'Beginner', '3.4', 4, 'Backup testing verifies that backups can be successfully restored.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dbyce', 'What is security information sharing?', 'Advanced', '4.3', 4, 'Security information sharing exchanges threat and vulnerability data between organizations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('l80jus', 'What is vulnerability assessment?', 'Intermediate', '4.3', 4, 'Vulnerability assessment systematically identifies security weaknesses.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ey6kgi', 'What is security monitoring?', 'Beginner', '4.4', 4, 'Security monitoring continuously watches for security events and threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('103gvtz', 'What is the primary goal of risk management?', 'Beginner', '5.2', 5, 'Risk management identifies and reduces risks to acceptable levels, not to zero.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6p377n', 'What does compliance mean in cybersecurity?', 'Beginner', '5.4', 5, 'Compliance is the act of following legal, regulatory, and industry-required standards.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('45001p', 'What is a security policy?', 'Beginner', '5.1', 5, 'Security policies establish rules and expectations for secure behavior.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1gwei1y', 'What does PII stand for?', 'Beginner', '5.4', 5, 'PII refers to any information that can identify an individual, such as name or SSN.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('soxspw', 'Why is a Business Continuity Plan important?', 'Beginner', '5.1', 5, 'BCPs ensure organizations can continue essential operations during major disruptions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1m0nvzm', 'What does BYOD mean?', 'Beginner', '4.1', 5, 'BYOD allows employees to use personal devices for work tasks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1hydgcz', 'Why is security awareness training important?', 'Beginner', '5.6', 5, 'Awareness training helps users avoid risky behaviors and identify threats.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('11timio', 'Who approves high-level security decisions?', 'Beginner', '5.1', 5, 'Executives are responsible for governance and strategic security decisions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1td5j6u', 'What is data retention?', 'Beginner', '5.4', 5, 'Data retention defines how long data must be kept for legal or business purposes.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('17754pc', 'Why is documentation important?', 'Beginner', '5.1', 5, 'Documentation ensures consistent security practices and procedures.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('f5egxh', 'What does an Acceptable Use Policy (AUP) define?', 'Beginner', '5.1', 5, 'AUPs define what users may or may not do with company systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('2rxtyj', 'Why is physical security important?', 'Beginner', '1.2', 5, 'Physical access can lead to complete system compromise, so it must be protected.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1r4mwvp', 'What is an incident in cybersecurity?', 'Beginner', '4.8', 5, 'Incidents jeopardize confidentiality, integrity, or availability of systems or data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1hm844x', 'What is the first phase of the incident response lifecycle?', 'Beginner', '4.8', 5, 'Preparation ensures tools, procedures, and staff are ready before incidents occur.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1j9qp6o', 'Who is considered the weakest link in security?', 'Beginner', '5.6', 5, 'Human error causes the majority of breaches, making users the weakest link.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('qvfky', 'Why are audits performed?', 'Beginner', '5.5', 5, 'Audits ensure controls are implemented properly and compliance is met.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nk4z2p', 'Which of the following is considered regulated data?', 'Beginner', '3.3', 5, 'PHI is protected by laws such as HIPAA.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('12v0a0r', 'Why are backups important?', 'Beginner', '3.4', 5, 'Backups enable restoration after ransomware, deletion, or corruption.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('a7kt34', 'Which document explains how to protect sensitive data?', 'Beginner', '5.1', 5, 'Data handling policies define how sensitive information must be stored and protected.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gooxow', 'What is a security baseline?', 'Beginner', '4.1', 5, 'Baselines define minimum required system configurations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('8fp9aa', 'Who typically conducts risk assessments?', 'Beginner', '5.2', 5, 'Security specialists identify risks and evaluate their severity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('pb85w7', 'What is change management?', 'Beginner', '1.3', 5, 'Change management ensures changes are controlled, documented, and approved.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1vgzczp', 'What is a compliance violation?', 'Beginner', '5.4', 5, 'Compliance violations occur when required regulations are not followed.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ewx4j5', 'Who responds to cybersecurity incidents?', 'Beginner', '4.8', 5, 'The IR team handles detection, containment, eradication, and recovery.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mezrin', 'Why is data classification used?', 'Beginner', '3.3', 5, 'Classification identifies how sensitive data is and what protections are required.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('c8jbcu', 'What is a security standard?', 'Beginner', '5.1', 5, 'Standards provide technical or procedural guidelines for implementing security controls.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('j2wzqj', 'What is the goal of privacy?', 'Beginner', '5.4', 5, 'Privacy ensures personal and sensitive data is protected from unauthorized access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('i4i0a4', 'What is a corrective control?', 'Beginner', '1.1', 5, 'Corrective controls restore systems after incidents or failures.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('7yqh7j', 'What is the purpose of onboarding in cybersecurity?', 'Beginner', '5.1', 5, 'Onboarding ensures users receive the correct access and training.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1sp9xni', 'Offboarding ensures what?', 'Beginner', '5.1', 5, 'Offboarding removes access from users who leave the organization.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('e7g5ac', 'What is a security audit?', 'Intermediate', '5.5', 5, 'A security audit formally evaluates compliance and effectiveness of security controls.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('19yt4iz', 'What is a risk register used for?', 'Intermediate', '5.2', 5, 'A risk register documents risks, impact, likelihood, and mitigation strategies.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('13e9vee', 'What is due diligence?', 'Intermediate', '5.4', 5, 'Due diligence refers to taking reasonable steps to prevent or reduce risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1dy4ong', 'What does Data Loss Prevention (DLP) do?', 'Intermediate', '4.5', 5, 'DLP tools prevent sensitive data from being leaked or moved insecurely.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1wsd4wq', 'Why is vendor risk management important?', 'Intermediate', '5.3', 5, 'Vendor risk management ensures external partners do not introduce unacceptable risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('znclo6', 'What is qualitative risk analysis based on?', 'Intermediate', '5.2', 5, 'Qualitative analysis uses subjective ratings such as high, medium, or low risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jernlv', 'What is an SLA?', 'Intermediate', '5.3', 5, 'An SLA defines service expectations such as uptime, response times, and responsibilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('3mj420', 'Why is data minimization important?', 'Intermediate', '5.4', 5, 'Data minimization limits the amount of sensitive data collected and stored to reduce risk.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nxw62w', 'What is a tabletop exercise?', 'Intermediate', '4.8', 5, 'Tabletop exercises simulate incidents in a discussion format to evaluate preparedness.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1genyy0', 'What does a Privacy Impact Assessment (PIA) evaluate?', 'Intermediate', '5.4', 5, 'PIAs ensure personal data is used lawfully and securely.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('eenr27', 'Why are internal audits performed?', 'Intermediate', '5.5', 5, 'Internal audits ensure controls meet internal requirements and standards.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1qr2uz4', 'Why is encryption part of data protection?', 'Intermediate', '1.4', 5, 'Encryption ensures only authorized users can read sensitive data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('55bwv0', 'Why are disciplinary policies needed?', 'Intermediate', '5.1', 5, 'Disciplinary policies enforce accountability for security violations.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('rpg6gf', 'What is segregation of duties?', 'Intermediate', '5.1', 5, 'Segregation of duties prevents fraud by dividing critical responsibilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('ifiex2', 'Why is access recertification required?', 'Intermediate', '4.6', 5, 'Periodic recertification ensures users do not retain unnecessary or risky access.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1bt45nk', 'What is the purpose of a security exception?', 'Intermediate', '5.2', 5, 'Exceptions are formally approved deviations with defined justification and expiration.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('rrs9hq', 'Which document lists step-by-step procedures?', 'Intermediate', '5.1', 5, 'SOPs define step-by-step instructions for consistent execution.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1r89uue', 'Why is training part of compliance programs?', 'Intermediate', '5.6', 5, 'Training ensures employees follow regulatory and internal requirements.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1uwprek', 'What is a security control assessment (SCA)?', 'Intermediate', '5.5', 5, 'SCAs evaluate how well security controls function.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('hzqvez', 'Which document defines how long logs must be kept?', 'Intermediate', '5.4', 5, 'Retention policies determine how long logs and data must be preserved.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('zdryab', 'Why are mergers and acquisitions high-risk events?', 'Intermediate', '5.3', 5, 'Acquisitions merge systems, creating potential unknown vulnerabilities.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1lvrbjn', 'Why is onboarding important for access control?', 'Intermediate', '5.1', 5, 'Onboarding assigns the right access levels based on job role.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1rylonp', 'What is offboarding?', 'Intermediate', '5.1', 5, 'Offboarding removes accounts and permissions for departing users.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1azs8pk', 'What is the goal of business impact analysis (BIA)?', 'Intermediate', '5.2', 5, 'BIA determines which systems are mission-critical and the effect of outages.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1kf5eos', 'What does a data owner do?', 'Intermediate', '5.1', 5, 'Data owners define how data should be protected and who may access it.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('bmcsvv', 'What is continuous improvement in security programs?', 'Intermediate', '5.1', 5, 'Security programs must evolve and strengthen over time.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('18sisxs', 'Why are metrics important in security governance?', 'Intermediate', '5.1', 5, 'Metrics help leadership evaluate security performance.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1y2vj3k', 'What does risk appetite represent?', 'Advanced', '5.2', 5, 'Risk appetite defines how much risk an organization is willing to tolerate.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1h2ox65', 'Which framework focuses on continuous improvement of a security program?', 'Advanced', '5.1', 5, 'NIST CSF emphasizes continual refinement of Identify, Protect, Detect, Respond, and Recover functions.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('6ly5n', 'What is a Key Risk Indicator (KRI)?', 'Advanced', '5.2', 5, 'KRIs give early warning signs that risk levels may be increasing.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('hxwucg', 'The goal of governance frameworks is to:', 'Advanced', '5.1', 5, 'Governance ensures leadership provides oversight and strategic security direction.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1p0454j', 'Quantitative risk analysis is based on:', 'Advanced', '5.2', 5, 'Quantitative analysis uses numeric values like ALE to calculate impact.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('z6tfuf', 'Data sovereignty laws require organizations to:', 'Advanced', '3.3', 5, 'Data sovereignty requires compliance with laws where data physically resides.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mbnlxr', 'Master Data Management (MDM) primarily ensures:', 'Advanced', '3.3', 5, 'MDM ensures consistent, accurate, governed enterprise data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1spq5n3', 'Red team vs. blue team exercises focus on:', 'Advanced', '5.5', 5, 'Red teams attack; blue teams defend; these exercises improve real-world readiness.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('mfr4xq', 'Data classification helps determine:', 'Advanced', '3.3', 5, 'Classification determines the appropriate security controls based on sensitivity.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('11pivw5', 'Gap analysis compares:', 'Advanced', '1.2', 5, 'Gap analysis identifies deficiencies between current and required security posture.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1kptv9m', 'Annual Loss Expectancy (ALE) is calculated using:', 'Advanced', '5.2', 5, 'ALE = Single Loss Expectancy × Annual Rate of Occurrence.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('nq59bs', 'A security maturity model is used to:', 'Advanced', '5.1', 5, 'Maturity models evaluate how advanced and effective security processes are.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('gq5ess', 'A risk treatment plan describes:', 'Advanced', '5.2', 5, 'Risk treatment plans outline actions needed to reduce or mitigate risks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('5qvxyl', 'What is risk transference?', 'Advanced', '5.2', 5, 'Transference passes risk responsibility to a third party (e.g., cyber insurance).', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('b041w6', 'Which report details weaknesses after testing controls?', 'Advanced', '5.5', 5, 'A findings report documents weaknesses discovered during security assessments.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('8ese6k', 'Business Continuity Plans must include:', 'Advanced', '5.1', 5, 'BCPs define how to continue operations and recover critical systems.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('q5nuli', 'Privacy by design means:', 'Advanced', '5.4', 5, 'Privacy by design integrates privacy into system development from the start.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('91ri65', 'Risk aggregation allows organizations to:', 'Advanced', '5.2', 5, 'Risk aggregation examines combined risks to see overall impact.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('dmhrm5', 'A data custodian is responsible for:', 'Advanced', '5.1', 5, 'Custodians apply and maintain technical data protections.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('geu3eo', 'ERM (Enterprise Risk Management) focuses on:', 'Advanced', '5.2', 5, 'ERM considers risk at the organization-wide level.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1l50a2t', 'A compensating control is:', 'Advanced', '1.1', 5, 'Compensating controls substitute for primary controls when necessary.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1q8m168', 'MTTR refers to:', 'Advanced', '5.2', 5, 'MTTR measures average time to repair or restore systems after a failure.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1crm237', 'MTBF represents:', 'Advanced', '5.2', 5, 'MTBF predicts reliability by measuring time between failures.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('158nr9v', 'RPO (Recovery Point Objective) defines:', 'Advanced', '5.2', 5, 'RPO defines how much data loss is acceptable in a disaster scenario.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('x4ts70', 'RTO (Recovery Time Objective) defines:', 'Advanced', '5.2', 5, 'RTO is the maximum acceptable downtime for a system.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1qlzksu', 'Which strategy involves identifying and assessing threats to assets?', 'Advanced', '5.2', 5, 'Threat modeling identifies potential attacks and weaknesses.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1jmig0c', 'What is cyber resilience?', 'Advanced', '3.4', 5, 'Cyber resilience measures the ability to operate through cyberattacks.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1iy7yor', 'Residual risk refers to:', 'Advanced', '5.2', 5, 'Residual risk is the risk left after mitigation efforts.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('14twk3', 'Data masking is used to:', 'Advanced', '1.4', 5, 'Data masking protects sensitive information by replacing it with fake or obscured data.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();
insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values
  ('1pqrtog', 'An ISSP (Issue-Specific Security Policy) addresses:', 'Advanced', '5.1', 5, 'ISSPs provide guidelines for specific issues like email or internet usage.', 'published')
on conflict (legacy_hash) do update set
  text = excluded.text, difficulty = excluded.difficulty,
  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,
  explanation = excluded.explanation, status = 'published', updated_at = now();

-- choices, joined to their question by legacy_hash
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Confidentiality, Integrity, Availability', true, NULL from questions q where q.legacy_hash = 'iybhy3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Computer, Internet, Application', false, 'Those are parts of an IT environment, not security goals. The triad names what security protects.' from questions q where q.legacy_hash = 'iybhy3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Control, Identification, Authentication', false, 'These are access-control ideas that help achieve security, but they aren''t the three goals the triad names.' from questions q where q.legacy_hash = 'iybhy3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Cryptography, Identity, Access', false, 'Cryptography and identity are tools for reaching security goals. The triad lists the goals themselves.' from questions q where q.legacy_hash = 'iybhy3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical', false, 'Physical controls are tangible barriers like locks, fences and guards. A firewall enforces rules with technology.' from questions q where q.legacy_hash = 'z4etyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Technical', true, NULL from questions q where q.legacy_hash = 'z4etyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Administrative', false, 'Administrative (managerial) controls are policies and procedures written by people, not devices that filter traffic.' from questions q where q.legacy_hash = 'z4etyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Procedural', false, 'A procedure is a set of steps people follow. A firewall filters traffic automatically, which makes it technical.' from questions q where q.legacy_hash = 'z4etyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Granting access to resources', false, 'That''s authorization, which happens after authentication has proven who you are.' from questions q where q.legacy_hash = '1ljvpxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Verifying the identity of a user', true, NULL from questions q where q.legacy_hash = '1ljvpxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting sensitive data', false, 'Encryption keeps data confidential. It doesn''t confirm who a user is.' from questions q where q.legacy_hash = '1ljvpxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Logging user activities', false, 'That''s accounting: recording what an authenticated user did.' from questions q where q.legacy_hash = '1ljvpxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Something you know', false, 'Knowledge factors are secrets you remember, like passwords or PINs. A fingerprint is part of your body.' from questions q where q.legacy_hash = 'bx3kow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Something you have', false, 'Possession factors are objects you carry, like a smart card or hardware token.' from questions q where q.legacy_hash = 'bx3kow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Something you are', true, NULL from questions q where q.legacy_hash = 'bx3kow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Somewhere you are', false, 'Location factors check where you are (GPS, IP address), not a physical trait.' from questions q where q.legacy_hash = 'bx3kow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To prevent unauthorized access to systems', false, 'That''s the job of access controls. Encrypted data can still be reached; it just can''t be read without the key.' from questions q where q.legacy_hash = '1ls1n47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To ensure confidentiality of data', true, NULL from questions q where q.legacy_hash = '1ls1n47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To verify data integrity', false, 'Close, but integrity is checked with hashing or digital signatures. Encryption''s main goal is keeping data secret.' from questions q where q.legacy_hash = '1ls1n47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To improve system performance', false, 'Encryption adds processing overhead; it never speeds a system up.' from questions q where q.legacy_hash = '1ls1n47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Trust but verify', false, 'That''s the older mindset of trusting first and checking later. Zero trust grants nothing until each request is verified.' from questions q where q.legacy_hash = 'eg98n8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Never trust, always verify', true, NULL from questions q where q.legacy_hash = 'eg98n8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Trust all internal users', false, 'Zero trust rejects the idea that being inside the network makes a user trustworthy.' from questions q where q.legacy_hash = 'eg98n8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Verify once, trust forever', false, 'Zero trust keeps re-verifying throughout a session instead of trusting after one check.' from questions q where q.legacy_hash = 'eg98n8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To install software', false, 'Installing software is an operational task. A policy states the rules such tasks must follow.' from questions q where q.legacy_hash = 'jtwuox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To define security rules and procedures', true, NULL from questions q where q.legacy_hash = 'jtwuox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To encrypt data', false, 'Encryption is a technical control. A policy may require it, but doesn''t perform it.' from questions q where q.legacy_hash = 'jtwuox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To monitor networks', false, 'Monitoring is done by tools like a SIEM or IDS. A policy defines what should be monitored and why.' from questions q where q.legacy_hash = 'jtwuox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using one strong security control', false, 'One control is a single point of failure. Defense in depth assumes any single layer can be bypassed.' from questions q where q.legacy_hash = '1r5rau2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Layering multiple security controls', true, NULL from questions q where q.legacy_hash = '1r5rau2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Focusing only on perimeter security', false, 'A perimeter-only design leaves nothing behind the wall once an attacker gets through.' from questions q where q.legacy_hash = '1r5rau2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Relying solely on firewalls', false, 'A firewall is just one layer. Defense in depth combines it with endpoint protection, access control, monitoring and more.' from questions q where q.legacy_hash = '1r5rau2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Give everyone admin access', false, 'Universal admin rights are the opposite: one compromised account could control everything.' from questions q where q.legacy_hash = 'gut9gw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Grant minimum permissions needed', true, NULL from questions q where q.legacy_hash = 'gut9gw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Allow all access by default', false, 'Allowing everything is ''implicit allow''. Least privilege starts from nothing and adds only what''s needed.' from questions q where q.legacy_hash = 'gut9gw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Share passwords freely', false, 'Shared passwords break accountability and have nothing to do with limiting permissions.' from questions q where q.legacy_hash = 'gut9gw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Verifying identity', false, 'That''s authentication. Authorization comes next and decides what the verified user may access.' from questions q where q.legacy_hash = '1koobnp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Granting access to resources', true, NULL from questions q where q.legacy_hash = '1koobnp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting data', false, 'Encryption keeps data confidential. It doesn''t decide who may use a resource.' from questions q where q.legacy_hash = '1koobnp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Logging events', false, 'Logging is accounting: the record of what users did after being authorized.' from questions q where q.legacy_hash = '1koobnp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Denying access', false, 'Denying access is an authorization decision. Non-repudiation is proof that can''t be disputed later.' from questions q where q.legacy_hash = 'edqvw0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Proving someone did something', true, NULL from questions q where q.legacy_hash = 'edqvw0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting messages', false, 'Encryption hides content but doesn''t prove who sent it. Digital signatures provide non-repudiation.' from questions q where q.legacy_hash = 'edqvw0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backing up data', false, 'Backups support availability and recovery, not proof of who did what.' from questions q where q.legacy_hash = 'edqvw0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Working alone', false, 'One person handling a whole sensitive process is exactly the fraud risk this control removes.' from questions q where q.legacy_hash = '187s2rx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Dividing tasks among multiple people', true, NULL from questions q where q.legacy_hash = '187s2rx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Combining all tasks', false, 'Combining tasks concentrates power. Separation of duties splits critical steps between people.' from questions q where q.legacy_hash = '187s2rx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Eliminating oversight', false, 'It adds oversight: each person''s part acts as a check on the others.' from questions q where q.legacy_hash = '187s2rx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Selling assets', false, 'Selling is one possible end of an asset''s life. Asset management covers tracking it the whole way.' from questions q where q.legacy_hash = '1ve2es1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Tracking and protecting resources', true, NULL from questions q where q.legacy_hash = '1ve2es1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Buying hardware', false, 'Procurement is one step. Asset management is the ongoing inventory, ownership and protection of assets.' from questions q where q.legacy_hash = '1ve2es1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Disposing equipment', false, 'Secure disposal is the final lifecycle stage, not the whole practice.' from questions q where q.legacy_hash = '1ve2es1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Strong security practice', false, 'Hiding how something works isn''t strong security: once the secret leaks, nothing else protects the system.' from questions q where q.legacy_hash = '10jus1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Relying on secrecy instead of security', true, NULL from questions q where q.legacy_hash = '10jus1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Best practice approach', false, 'Best practice treats obscurity as, at most, an extra layer, never the main defense.' from questions q where q.legacy_hash = '10jus1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Required security measure', false, 'No framework requires it. A design should stay secure even when it''s public.' from questions q where q.legacy_hash = '10jus1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Opening doors', false, 'A door is one thing access control can govern. The concept covers any resource, physical or digital.' from questions q where q.legacy_hash = '9wryfb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Regulating who can access resources', true, NULL from questions q where q.legacy_hash = '9wryfb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Installing locks', false, 'Locks are one physical access control. Access control is the broader practice of deciding who may use what.' from questions q where q.legacy_hash = '9wryfb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating passwords', false, 'Passwords are an authentication method that supports access control, not access control itself.' from questions q where q.legacy_hash = '9wryfb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Access based on user roles', true, NULL from questions q where q.legacy_hash = '7ea9am'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on time', false, 'Time-of-day limits are a rule- or attribute-based condition, not a role.' from questions q where q.legacy_hash = '7ea9am'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Access based on location', false, 'Location is an attribute used by ABAC or conditional access, not by RBAC.' from questions q where q.legacy_hash = '7ea9am'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random access', false, 'Access control is never random. RBAC maps permissions to defined job roles.' from questions q where q.legacy_hash = '7ea9am'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Optional security', false, 'MAC is the strictest model. Users can''t opt out or change the labels.' from questions q where q.legacy_hash = 'fudefs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'System-enforced access control', true, NULL from questions q where q.legacy_hash = 'fudefs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'User-controlled access', false, 'That''s discretionary access control (DAC), where the owner decides. MAC is enforced by the system.' from questions q where q.legacy_hash = 'fudefs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No access control', false, 'MAC is an access control model: the most rigid one, based on classification labels.' from questions q where q.legacy_hash = 'fudefs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A safeguard or countermeasure', true, NULL from questions q where q.legacy_hash = '1v94t4e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A network device', false, 'A device like a firewall can implement a control, but controls also include policies and physical measures.' from questions q where q.legacy_hash = '1v94t4e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A password', false, 'A password is one example of a control. The term covers any safeguard that reduces risk.' from questions q where q.legacy_hash = '1v94t4e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'An encryption key', false, 'A key is part of one technical control, not the definition of a control.' from questions q where q.legacy_hash = '1v94t4e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No difference', false, 'They differ in timing: preventive controls act before an incident, detective controls during or after it.' from questions q where q.legacy_hash = 'c4jn86'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Preventive stops attacks, detective identifies them', true, NULL from questions q where q.legacy_hash = 'c4jn86'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Detective stops attacks', false, 'That''s reversed. Detective controls, like an IDS or audit logs, spot attacks; preventive ones block them.' from questions q where q.legacy_hash = 'c4jn86'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Both are the same', false, 'A lock prevents entry; a camera detects it. Related goal, different roles.' from questions q where q.legacy_hash = 'c4jn86'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To encrypt data', false, 'Hashing is one-way: you can''t get the original back. Encryption is reversible with the key.' from questions q where q.legacy_hash = '1jn1epm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To verify data integrity', true, NULL from questions q where q.legacy_hash = '1jn1epm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To compress files', false, 'A hash is a fixed-size fingerprint, not a smaller copy you can expand again.' from questions q where q.legacy_hash = '1jn1epm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To create backups', false, 'A hash can''t restore data. It only tells you whether data has changed.' from questions q where q.legacy_hash = '1jn1epm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Access based on job titles', false, 'Job titles point to RBAC. ABAC weighs several attributes together, such as role, time, location and device.' from questions q where q.legacy_hash = 'jpv9y7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on multiple attributes', true, NULL from questions q where q.legacy_hash = 'jpv9y7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Access based on passwords only', false, 'A password proves identity. ABAC decides access after that, using many attributes.' from questions q where q.legacy_hash = 'jpv9y7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No access control', false, 'ABAC is a fine-grained access control model, not the absence of one.' from questions q where q.legacy_hash = 'jpv9y7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'They are the same', false, 'Typing a username identifies you; entering the password proves it. They are separate steps.' from questions q where q.legacy_hash = 'xcnlz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identification claims identity, authentication proves it', true, NULL from questions q where q.legacy_hash = 'xcnlz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Authentication comes first', false, 'You have to claim an identity before you can prove it, so identification comes first.' from questions q where q.legacy_hash = 'xcnlz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Identification is stronger', false, 'Identification alone proves nothing, since anyone can type a username. Authentication supplies the proof.' from questions q where q.legacy_hash = 'xcnlz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Financial records', false, 'In AAA, accounting means recording user activity, not bookkeeping.' from questions q where q.legacy_hash = '1vrim8e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Tracking user activities', true, NULL from questions q where q.legacy_hash = '1vrim8e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating accounts', false, 'That''s provisioning. Accounting tracks what accounts do once they exist.' from questions q where q.legacy_hash = '1vrim8e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting logs', false, 'Deleting logs destroys the audit trail that accounting creates.' from questions q where q.legacy_hash = '1vrim8e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Allowing everything', false, 'That''s implicit allow, the opposite. Implicit deny blocks anything not explicitly permitted.' from questions q where q.legacy_hash = 'bvo1r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Denying all unless explicitly allowed', true, NULL from questions q where q.legacy_hash = 'bvo1r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Random access', false, 'Implicit deny is predictable: whatever no rule allows is blocked.' from questions q where q.legacy_hash = 'bvo1r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No rules', false, 'Implicit deny is itself a rule, usually the final ''deny all'' at the end of an ACL.' from questions q where q.legacy_hash = 'bvo1r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Primary control', false, 'A compensating control stands in when the primary control can''t be used.' from questions q where q.legacy_hash = '1la9v5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Alternative control for missing primary control', true, NULL from questions q where q.legacy_hash = '1la9v5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup system', false, 'A backup provides recovery. A compensating control is an alternative safeguard meeting the same requirement.' from questions q where q.legacy_hash = '1la9v5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Extra security', false, 'It isn''t an extra layer on top; it replaces a control that isn''t feasible.' from questions q where q.legacy_hash = '1la9v5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Data availability', false, 'Availability is a different part of the CIA triad: data being reachable when needed.' from questions q where q.legacy_hash = '10hd3tm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Protecting data from unauthorized access', true, NULL from questions q where q.legacy_hash = '10hd3tm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Data speed', false, 'Speed is performance, not a security goal.' from questions q where q.legacy_hash = '10hd3tm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Data location', false, 'Where data lives matters for sovereignty, but confidentiality is about who can read it.' from questions q where q.legacy_hash = '10hd3tm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical stance', false, 'Posture here is figurative: how well the organization is defended overall.' from questions q where q.legacy_hash = 'p8owzi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Overall security status of organization', true, NULL from questions q where q.legacy_hash = 'p8owzi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security job', false, 'A job is a role. Posture describes the organization''s overall security state.' from questions q where q.legacy_hash = 'p8owzi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network speed', false, 'Speed is performance. Posture is about controls, risks and readiness.' from questions q where q.legacy_hash = 'p8owzi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Honesty', false, 'In security, integrity describes data being accurate and unaltered, not a personal quality.' from questions q where q.legacy_hash = '18tlug2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Ensuring data accuracy and consistency', true, NULL from questions q where q.legacy_hash = '18tlug2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Data storage', false, 'Storing data doesn''t make it trustworthy. Integrity means it isn''t changed without authorization.' from questions q where q.legacy_hash = '18tlug2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network speed', false, 'Speed is performance, not a security property.' from questions q where q.legacy_hash = '18tlug2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Fear of risk', false, 'Appetite isn''t an emotion. It''s a deliberate statement of how much risk leadership will take on.' from questions q where q.legacy_hash = '1ra6j2h'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Amount of risk organization willing to accept', true, NULL from questions q where q.legacy_hash = '1ra6j2h'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No risk tolerance', false, 'Zero risk is impossible. Every organization accepts some, and appetite defines how much.' from questions q where q.legacy_hash = '1ra6j2h'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Maximum risk', false, 'Appetite is the level the organization is willing to accept, not the most it could face.' from questions q where q.legacy_hash = '1ra6j2h'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Not caring', false, 'Due care is the opposite: acting responsibly to protect assets.' from questions q where q.legacy_hash = '18o06q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Taking reasonable steps to protect assets', true, NULL from questions q where q.legacy_hash = '18o06q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Maximum effort', false, 'Due care asks for reasonable, prudent effort, not unlimited effort.' from questions q where q.legacy_hash = '18o06q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Minimal effort', false, 'The bare minimum can amount to negligence. Due care is what a reasonable person would do.' from questions q where q.legacy_hash = '18o06q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Data speed', false, 'A fast system can still be down. Availability means authorized users can reach data when they need it.' from questions q where q.legacy_hash = '1ljx9n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Ensuring authorized access when needed', true, NULL from questions q where q.legacy_hash = '1ljx9n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Data storage', false, 'Storing data doesn''t guarantee access. Availability is about uptime for authorized users.' from questions q where q.legacy_hash = '1ljx9n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Data encryption', false, 'Encryption serves confidentiality, a different part of the CIA triad.' from questions q where q.legacy_hash = '1ljx9n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'System-controlled access', false, 'System-enforced labels describe MAC. In DAC, the resource owner decides.' from questions q where q.legacy_hash = 'odzlpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Owner-controlled access', true, NULL from questions q where q.legacy_hash = 'odzlpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No access control', false, 'DAC is an access control model: the owner grants and revokes access.' from questions q where q.legacy_hash = 'odzlpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random access', false, 'DAC permissions are set deliberately by the owner.' from questions q where q.legacy_hash = 'odzlpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Basic login', false, 'A basic login checks only credentials. Context-aware authentication also weighs location, time and device.' from questions q where q.legacy_hash = '5awowm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Authentication based on user context', true, NULL from questions q where q.legacy_hash = '5awowm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No authentication', false, 'It''s a stronger form of authentication, not the absence of it.' from questions q where q.legacy_hash = '5awowm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Single factor', false, 'Single-factor login ignores context. Context-aware systems adapt to the circumstances of each login.' from questions q where q.legacy_hash = '5awowm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random rules', false, 'A policy is deliberate and consistent. Random rules couldn''t be enforced or audited.' from questions q where q.legacy_hash = '1uw4ou0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Rules for creating passwords', true, NULL from questions q where q.legacy_hash = '1uw4ou0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No rules', false, 'A password policy exists to set rules, such as length, complexity and reuse limits.' from questions q where q.legacy_hash = '1uw4ou0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Optional guidelines', false, 'Guidelines are recommendations. A policy is mandatory and enforced.' from questions q where q.legacy_hash = '1uw4ou0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Multiple logins', false, 'That''s life without SSO. With SSO, one authentication opens many systems.' from questions q where q.legacy_hash = '1lriks7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'One login for multiple systems', true, NULL from questions q where q.legacy_hash = '1lriks7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No login', false, 'You still log in once. SSO removes the repeat logins, not authentication.' from questions q where q.legacy_hash = '1lriks7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Complex authentication', false, 'SSO simplifies things for the user, even when it''s backed by strong MFA.' from questions q where q.legacy_hash = '1lriks7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single organization identity', false, 'An identity limited to one organization is local. Federation extends trust across organizations.' from questions q where q.legacy_hash = 'axy9nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Sharing identity across organizations', true, NULL from questions q where q.legacy_hash = 'axy9nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No identity', false, 'Federation relies on a verified identity and shares it with partners, using protocols like SAML.' from questions q where q.legacy_hash = 'axy9nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Local identity only', false, 'Local-only accounts are what federation replaces, so users don''t need a separate account everywhere.' from questions q where q.legacy_hash = 'axy9nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Password only', false, 'A password is something you know. Biometrics are something you are.' from questions q where q.legacy_hash = 'pmnspe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Authentication using physical characteristics', true, NULL from questions q where q.legacy_hash = 'pmnspe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Card reader', false, 'A card is something you have, a possession factor.' from questions q where q.legacy_hash = 'pmnspe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'PIN code', false, 'A PIN is a knowledge factor, like a password.' from questions q where q.legacy_hash = 'pmnspe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Permanent access', false, 'Time-based control is the opposite: access is valid only during set hours or periods.' from questions q where q.legacy_hash = '1x45qw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on time periods', true, NULL from questions q where q.legacy_hash = '1x45qw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No time limits', false, 'Time limits are the whole point of time-based access control.' from questions q where q.legacy_hash = '1x45qw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random timing', false, 'The time windows are defined by policy, not random.' from questions q where q.legacy_hash = '1x45qw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'One-time login', false, 'A single check at login is traditional authentication. Continuous authentication keeps checking during the session.' from questions q where q.legacy_hash = 'urtxwr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Ongoing verification during session', true, NULL from questions q where q.legacy_hash = 'urtxwr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No authentication', false, 'It''s more authentication, not none.' from questions q where q.legacy_hash = 'urtxwr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Login only', false, 'Checking only at login is what continuous authentication improves on.' from questions q where q.legacy_hash = 'urtxwr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single password', false, 'A password alone is single-factor authentication.' from questions q where q.legacy_hash = '1m944hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Multiple authentication methods', true, NULL from questions q where q.legacy_hash = '1m944hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No password', false, 'MFA may or may not include a password. What matters is combining factors from different categories.' from questions q where q.legacy_hash = '1m944hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Easy login', false, 'MFA adds a step to make logins harder to abuse, not easier.' from questions q where q.legacy_hash = '1m944hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring risks', false, 'Assessment is the opposite: finding and measuring risks so they can be handled.' from questions q where q.legacy_hash = 'ta2zf7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identifying and evaluating risks', true, NULL from questions q where q.legacy_hash = 'ta2zf7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating risks', false, 'It identifies existing risks. It doesn''t introduce new ones.' from questions q where q.legacy_hash = 'ta2zf7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Accepting all risks', false, 'Acceptance is one possible response decided after assessment, not the assessment itself.' from questions q where q.legacy_hash = 'ta2zf7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Password', false, 'A password is something you know. A token is something you have.' from questions q where q.legacy_hash = 'qe29ou'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Device generating codes', true, NULL from questions q where q.legacy_hash = 'qe29ou'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Username', false, 'A username only identifies you. It isn''t a device and proves nothing.' from questions q where q.legacy_hash = 'qe29ou'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email address', false, 'An email address is an identifier, not an authentication device.' from questions q where q.legacy_hash = 'qe29ou'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring risk', false, 'Ignoring a risk isn''t a valid response. Mitigation actively reduces it.' from questions q where q.legacy_hash = '1qn27nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Reducing risk impact', true, NULL from questions q where q.legacy_hash = '1qn27nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Increasing risk', false, 'Mitigation lowers a risk''s likelihood or impact.' from questions q where q.legacy_hash = '1qn27nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Accepting risk', false, 'Acceptance means living with the risk as it is. Mitigation adds controls to reduce it.' from questions q where q.legacy_hash = '1qn27nm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Accepting risk', false, 'Acceptance keeps the activity and its risk. Avoidance stops doing the activity.' from questions q where q.legacy_hash = 'imsxav'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Eliminating risk by not doing activity', true, NULL from questions q where q.legacy_hash = 'imsxav'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring risk', false, 'Ignoring isn''t a response. Avoidance is a deliberate decision to stop.' from questions q where q.legacy_hash = 'imsxav'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Increasing risk', false, 'Avoidance removes the risk entirely by not engaging in the activity.' from questions q where q.legacy_hash = 'imsxav'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random sorting', false, 'Classification follows defined labels (public, internal, confidential) based on sensitivity.' from questions q where q.legacy_hash = '1lxqyyi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Categorizing data by sensitivity', true, NULL from questions q where q.legacy_hash = '1lxqyyi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting data', false, 'Classification decides how data is handled. Deletion is a separate lifecycle step.' from questions q where q.legacy_hash = '1lxqyyi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Encrypting data', false, 'Some classifications require encryption, but labeling the data comes first.' from questions q where q.legacy_hash = '1lxqyyi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Staying in same job', false, 'Staying put is what job rotation changes, so fraud hidden in one role gets uncovered.' from questions q where q.legacy_hash = '188z4e7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Periodically changing job duties', true, NULL from questions q where q.legacy_hash = '188z4e7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Never changing', false, 'Rotation means moving people between roles periodically.' from questions q where q.legacy_hash = '188z4e7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random assignments', false, 'Rotation is planned and periodic, not random.' from questions q where q.legacy_hash = '188z4e7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Optional time off', false, 'It''s required, so someone else covers the role long enough to spot irregularities.' from questions q where q.legacy_hash = '1lxblq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Required time away from work', true, NULL from questions q where q.legacy_hash = '1lxblq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No vacation', false, 'Skipping vacations lets someone hide ongoing fraud, which this control prevents.' from questions q where q.legacy_hash = '1lxblq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Unlimited vacation', false, 'The control forces a minimum absence; it isn''t about unlimited leave.' from questions q where q.legacy_hash = '1lxblq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Deleting data', false, 'Encrypted data still exists. It''s just unreadable without the key.' from questions q where q.legacy_hash = '1fz631b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Converting data to unreadable format', true, NULL from questions q where q.legacy_hash = '1fz631b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Copying data', false, 'Encryption transforms data. It doesn''t duplicate it.' from questions q where q.legacy_hash = '1fz631b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Storing data', false, 'Storage is where data sits. Encryption is what makes it unreadable there.' from questions q where q.legacy_hash = '1fz631b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Deleting data', false, 'Masked data stays usable, like showing the last four digits of a card. Nothing is deleted.' from questions q where q.legacy_hash = '1jd7zdk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Hiding sensitive data parts', true, NULL from questions q where q.legacy_hash = '1jd7zdk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting everything', false, 'Masking hides only the sensitive parts and usually can''t be reversed, unlike encryption.' from questions q where q.legacy_hash = '1jd7zdk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Copying data', false, 'Masking changes what''s shown or shared, not how many copies exist.' from questions q where q.legacy_hash = '1jd7zdk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating coins', false, 'The tokens are random stand-in values, not cryptocurrency.' from questions q where q.legacy_hash = '1vc0eb7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Replacing sensitive data with tokens', true, NULL from questions q where q.legacy_hash = '1vc0eb7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting data', false, 'Close, but a token has no mathematical link to the original. The real value is kept in a secure token vault.' from questions q where q.legacy_hash = '1vc0eb7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting data', false, 'The original still exists in the vault. Tokens replace it everywhere else.' from questions q where q.legacy_hash = '1vc0eb7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Software only', false, 'Software protection is logical security. Physical security covers buildings, rooms and hardware.' from questions q where q.legacy_hash = 'tjgyg9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Protecting physical assets', true, NULL from questions q where q.legacy_hash = 'tjgyg9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network security', false, 'Network security protects data in transit. Physical security protects tangible assets.' from questions q where q.legacy_hash = 'tjgyg9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Cloud security', false, 'Cloud security covers hosted services. Physical security covers things like doors, guards and cameras.' from questions q where q.legacy_hash = 'tjgyg9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Outdoor security', false, 'Environmental controls manage conditions like temperature, humidity and fire suppression, not the outdoors.' from questions q where q.legacy_hash = 'zecg47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Managing physical environment factors', true, NULL from questions q where q.legacy_hash = 'zecg47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Software control', false, 'These are physical systems such as HVAC and fire suppression, not software.' from questions q where q.legacy_hash = 'zecg47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network control', false, 'Network controls filter traffic. Environmental controls keep equipment in safe operating conditions.' from questions q where q.legacy_hash = 'zecg47'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Separation', false, 'Convergence is the opposite: bringing physical and cyber security together.' from questions q where q.legacy_hash = '1scx1az'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Integrating physical and logical security', true, NULL from questions q where q.legacy_hash = '1scx1az'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical only', false, 'Convergence combines physical security with logical (information) security.' from questions q where q.legacy_hash = '1scx1az'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Logical only', false, 'Logical security alone isn''t convergence. The term means merging it with physical security.' from questions q where q.legacy_hash = '1scx1az'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Everyone knows everything', false, 'Need-to-know limits information to people whose job requires it.' from questions q where q.legacy_hash = '1mmg830'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access only to required information', true, NULL from questions q where q.legacy_hash = '1mmg830'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No restrictions', false, 'It''s a restriction, even for people who hold a high clearance.' from questions q where q.legacy_hash = '1mmg830'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Full access', false, 'Full access contradicts need-to-know, which grants only what a task requires.' from questions q where q.legacy_hash = '1mmg830'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring security', false, 'Awareness is the opposite: knowing the threats and how to respond.' from questions q where q.legacy_hash = '21ug6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Understanding security threats', true, NULL from questions q where q.legacy_hash = '21ug6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Technical skills only', false, 'Awareness is for everyone, not just technical staff, like recognizing a phishing email.' from questions q where q.legacy_hash = '21ug6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Programming', false, 'Programming is a technical skill. Awareness is understanding threats and safe behavior.' from questions q where q.legacy_hash = '21ug6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No oversight', false, 'Governance is oversight: leadership setting direction, policy and accountability.' from questions q where q.legacy_hash = 'tpnupg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Framework directing security program', true, NULL from questions q where q.legacy_hash = 'tpnupg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Random activities', false, 'Governance makes security work structured and aligned with business goals.' from questions q where q.legacy_hash = 'tpnupg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Technical tasks only', false, 'Governance works at the strategic level (policy, roles, accountability), not just technical work.' from questions q where q.legacy_hash = 'tpnupg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No rules', false, 'An AUP is a set of rules for how company resources may be used.' from questions q where q.legacy_hash = '1oc29ud'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Rules for using company resources', true, NULL from questions q where q.legacy_hash = '1oc29ud'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Optional guidelines', false, 'Users typically must agree to the AUP, and breaking it has consequences.' from questions q where q.legacy_hash = '1oc29ud'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Ignored document', false, 'An AUP is enforceable: users acknowledge it, and it backs disciplinary action.' from questions q where q.legacy_hash = '1oc29ud'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Never clean', false, 'The policy requires clearing sensitive material from workspaces.' from questions q where q.legacy_hash = 'o8iz9q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Securing materials when not in use', true, NULL from questions q where q.legacy_hash = 'o8iz9q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Messy workspace', false, 'Leaving papers and devices out is exactly what the policy prevents.' from questions q where q.legacy_hash = 'o8iz9q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No policy', false, 'It''s a named administrative policy covering documents, notes and unattended screens.' from questions q where q.legacy_hash = 'o8iz9q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No rules', false, 'Sovereignty means rules do apply: those of the country where the data resides.' from questions q where q.legacy_hash = '1hcc8zx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data subject to laws of location', true, NULL from questions q where q.legacy_hash = '1hcc8zx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Global rules only', false, 'There''s no single global law. Each country''s own laws govern data stored there.' from questions q where q.legacy_hash = '1hcc8zx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No restrictions', false, 'Sovereignty adds restrictions, such as limits on moving data across borders.' from questions q where q.legacy_hash = '1hcc8zx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Public information', false, 'Privacy concerns personal information and who controls it, not data that''s already public.' from questions q where q.legacy_hash = 'wy28qa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Controlling personal information', true, NULL from questions q where q.legacy_hash = 'wy28qa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No control', false, 'Privacy is about people having control over their personal data.' from questions q where q.legacy_hash = 'wy28qa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Sharing everything', false, 'Privacy limits sharing to what the person has agreed to.' from questions q where q.legacy_hash = 'wy28qa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Public data', false, 'Some PII is publicly visible, but PII is defined by identifying a person, not by being public.' from questions q where q.legacy_hash = 'h2vnjq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data identifying individuals', true, NULL from questions q where q.legacy_hash = 'h2vnjq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Anonymous data', false, 'Anonymized data has had its identifiers removed, so it no longer counts as PII.' from questions q where q.legacy_hash = 'h2vnjq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Corporate data', false, 'Business data like financials is sensitive, but PII is specifically about individuals.' from questions q where q.legacy_hash = 'h2vnjq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Added later', false, 'Bolting privacy on afterwards is what privacy by design avoids.' from questions q where q.legacy_hash = '1di01xj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Privacy built into systems from start', true, NULL from questions q where q.legacy_hash = '1di01xj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Optional privacy', false, 'Privacy by design makes privacy the default, not an opt-in.' from questions q where q.legacy_hash = '1di01xj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No privacy', false, 'It puts privacy at the center of system design.' from questions q where q.legacy_hash = '1di01xj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal operation', false, 'Normal activity is just an event. An incident threatens security and needs a response.' from questions q where q.legacy_hash = '19i58t7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Event requiring response', true, NULL from questions q where q.legacy_hash = '19i58t7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Routine task', false, 'Routine tasks are expected. Incidents are unexpected and potentially harmful.' from questions q where q.legacy_hash = '19i58t7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Scheduled activity', false, 'Scheduled work like maintenance is planned. An incident is unplanned.' from questions q where q.legacy_hash = '19i58t7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random changes', false, 'Change control makes changes planned, approved and documented.' from questions q where q.legacy_hash = 'e9md6j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Process managing system changes', true, NULL from questions q where q.legacy_hash = 'e9md6j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No oversight', false, 'It adds oversight through reviews and approvals, often by a change advisory board.' from questions q where q.legacy_hash = 'e9md6j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Breaking things', false, 'Change control exists to stop changes from breaking systems.' from questions q where q.legacy_hash = 'e9md6j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Desired state', false, 'The desired state is the baseline. Drift is movement away from it.' from questions q where q.legacy_hash = '2cfy11'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unintended configuration changes over time', true, NULL from questions q where q.legacy_hash = '2cfy11'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Planned changes', false, 'Planned changes go through change control and update the baseline. Drift is unplanned.' from questions q where q.legacy_hash = '2cfy11'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No changes', false, 'Drift is change: unapproved changes that build up over time.' from questions q where q.legacy_hash = '2cfy11'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Making difficult', false, 'Hardening makes a system harder to attack, not harder to use, by removing unneeded services and settings.' from questions q where q.legacy_hash = 'ctrzs4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Securing system by reducing vulnerabilities', true, NULL from questions q where q.legacy_hash = 'ctrzs4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Softening', false, 'Softening is the opposite. Hardening shrinks the attack surface.' from questions q where q.legacy_hash = 'ctrzs4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No security', false, 'Hardening is a core security practice, like disabling unused ports and applying secure baselines.' from questions q where q.legacy_hash = 'ctrzs4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical size', false, 'Attack surface counts entry points (ports, services, accounts, interfaces), not physical size.' from questions q where q.legacy_hash = '1f8f2ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'All possible attack points', true, NULL from questions q where q.legacy_hash = '1f8f2ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No vulnerabilities', false, 'Attack surface describes exposure, whether or not vulnerabilities have been found yet.' from questions q where q.legacy_hash = '1f8f2ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'One entry point', false, 'It''s the sum of all entry points, not just one.' from questions q where q.legacy_hash = '1f8f2ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Strong defense', false, 'The term describes attacker techniques for getting around defenses, not a defense.' from questions q where q.legacy_hash = 'q4bfpf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Techniques to avoid detection', true, NULL from questions q where q.legacy_hash = 'q4bfpf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No evasion', false, 'It''s specifically about evading detection, such as disabling logs or obfuscating code.' from questions q where q.legacy_hash = 'q4bfpf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Detection method', false, 'It''s the attacker''s side: techniques that defeat detection methods.' from questions q where q.legacy_hash = 'q4bfpf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Insecure start', false, 'Secure by default means the out-of-box settings are already secure.' from questions q where q.legacy_hash = '1vlcopn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Secure initial configuration', true, NULL from questions q where q.legacy_hash = '1vlcopn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No security', false, 'Security is on from the start, with nothing for the user to configure.' from questions q where q.legacy_hash = '1vlcopn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Optional security', false, 'Users shouldn''t have to opt in. Secure settings are the default.' from questions q where q.legacy_hash = '1vlcopn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Failing open', false, 'Fail open allows access when something breaks. Fail secure (fail closed) blocks it.' from questions q where q.legacy_hash = '13ovjpz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Defaulting to secure state on failure', true, NULL from questions q where q.legacy_hash = '13ovjpz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No security', false, 'Fail secure keeps protection in place even while the system is failing.' from questions q where q.legacy_hash = '13ovjpz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Breaking completely', false, 'The point is to fail into a controlled, locked-down state, not unpredictably.' from questions q where q.legacy_hash = '13ovjpz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Blind trust', false, 'Blind trust skips the ''verify'' half of the phrase.' from questions q where q.legacy_hash = 'b3d6ye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Trusting while validating', true, NULL from questions q where q.legacy_hash = 'b3d6ye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No verification', false, 'Verification is half of the principle.' from questions q where q.legacy_hash = 'b3d6ye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No trust', false, 'Starting with no trust at all is zero trust, not trust but verify.' from questions q where q.legacy_hash = 'b3d6ye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Maximum access', false, 'Least privilege is the opposite: the minimum access a job requires.' from questions q where q.legacy_hash = '6cmelw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Minimum necessary access', true, NULL from questions q where q.legacy_hash = '6cmelw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No access', false, 'Users still get what they need for their job, just nothing more.' from questions q where q.legacy_hash = '6cmelw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Full admin access', false, 'Admin rights for everyone violate least privilege.' from questions q where q.legacy_hash = '6cmelw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Trust everyone', false, 'Zero trust trusts no one by default, inside or outside the network.' from questions q where q.legacy_hash = '1p4inue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Never trust, always verify', true, NULL from questions q where q.legacy_hash = '1p4inue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Blind trust', false, 'Zero trust verifies every request, the opposite of blind trust.' from questions q where q.legacy_hash = '1p4inue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No security', false, 'Zero trust is a strict model built on continuous verification.' from questions q where q.legacy_hash = '1p4inue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Preventing attacks', false, 'Stopping attacks is preventive. Detective controls find attacks that are happening or have happened.' from questions q where q.legacy_hash = 'p3vaq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identifying security events', true, NULL from questions q where q.legacy_hash = 'p3vaq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Recovering systems', false, 'Recovery is corrective. Detective controls identify, alert and log.' from questions q where q.legacy_hash = 'p3vaq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No detection', false, 'Detection is the whole purpose, as with an IDS, SIEM or audit logs.' from questions q where q.legacy_hash = 'p3vaq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Preventing issues', false, 'Prevention is preventive. Corrective controls act after something has happened.' from questions q where q.legacy_hash = 'lho59n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Fixing problems after occurrence', true, NULL from questions q where q.legacy_hash = 'lho59n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Detecting issues', false, 'Detection comes first. Corrective controls then fix the damage, like restoring from backup.' from questions q where q.legacy_hash = 'lho59n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No action', false, 'Corrective controls take action to repair or limit damage.' from questions q where q.legacy_hash = 'lho59n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Detecting threats', false, 'Detection is the job of detective controls, which act during or after an event.' from questions q where q.legacy_hash = 'p2a6d9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Stopping threats before occurrence', true, NULL from questions q where q.legacy_hash = 'p2a6d9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Fixing issues', false, 'Fixing is corrective, which happens after an incident.' from questions q where q.legacy_hash = 'p2a6d9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Responding to threats', false, 'Response happens once a threat appears. Preventive controls stop it beforehand.' from questions q where q.legacy_hash = 'p2a6d9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encouraging attacks', false, 'Deterrents do the opposite: warning signs and visible cameras discourage attackers.' from questions q where q.legacy_hash = 'bs241u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Discouraging attacks', true, NULL from questions q where q.legacy_hash = 'bs241u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No effect', false, 'Deterrents work psychologically by making an attacker think twice.' from questions q where q.legacy_hash = 'bs241u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Attracting threats', false, 'Attracting attackers is what honeypots do. Deterrents push them away.' from questions q where q.legacy_hash = 'bs241u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Technical tools', false, 'Tools and software are technical controls.' from questions q where q.legacy_hash = '19pq5a1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Policies and procedures', true, NULL from questions q where q.legacy_hash = '19pq5a1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical barriers', false, 'Barriers like fences and locks are physical controls.' from questions q where q.legacy_hash = '19pq5a1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No controls', false, 'Administrative controls are real controls: policies, procedures, training and background checks.' from questions q where q.legacy_hash = '19pq5a1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Policies only', false, 'Policies are administrative (managerial) controls.' from questions q where q.legacy_hash = 'as63pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Technology-based safeguards', true, NULL from questions q where q.legacy_hash = 'as63pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical locks', false, 'Locks are physical controls.' from questions q where q.legacy_hash = 'as63pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Procedures', false, 'Procedures are administrative or operational controls carried out by people.' from questions q where q.legacy_hash = 'as63pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Software', false, 'Software-based safeguards are technical controls.' from questions q where q.legacy_hash = 'in9q8i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Physical security measures', true, NULL from questions q where q.legacy_hash = 'in9q8i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Policies', false, 'Policies are administrative controls.' from questions q where q.legacy_hash = 'in9q8i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Networks', false, 'Network safeguards like firewalls are technical controls.' from questions q where q.legacy_hash = 'in9q8i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Role-based only', false, 'Using only the role is RBAC. ABAC can combine role with many other attributes.' from questions q where q.legacy_hash = 'd7g9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on attributes', true, NULL from questions q where q.legacy_hash = 'd7g9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No attributes', false, 'Attributes are the basis of ABAC.' from questions q where q.legacy_hash = 'd7g9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Manual control', false, 'ABAC evaluates its policies automatically for every request.' from questions q where q.legacy_hash = 'd7g9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'User-based', false, 'Granting permissions to individual users one by one is closer to DAC. RBAC grants them to roles.' from questions q where q.legacy_hash = '1myfy2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on job role', true, NULL from questions q where q.legacy_hash = '1myfy2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No roles', false, 'Roles are the core of RBAC.' from questions q where q.legacy_hash = '1myfy2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random access', false, 'RBAC permissions follow defined job roles, not chance.' from questions q where q.legacy_hash = '1myfy2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Optional control', false, 'MAC is mandatory by definition. Users can''t change it.' from questions q where q.legacy_hash = 'wfkoie'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'System-enforced access control', true, NULL from questions q where q.legacy_hash = 'wfkoie'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'User choice', false, 'Letting users choose is DAC. MAC is enforced by the system using labels.' from questions q where q.legacy_hash = 'wfkoie'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No control', false, 'MAC is the strictest access control model.' from questions q where q.legacy_hash = 'wfkoie'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No rules', false, 'Rules are the basis of this model, like firewall ACLs or time-of-day rules.' from questions q where q.legacy_hash = '1pc1paj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Access based on rules', true, NULL from questions q where q.legacy_hash = '1pc1paj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Role-based', false, 'Easy to mix up, since both shorten to RBAC. Role-based uses job roles; rule-based applies the same rules to everyone.' from questions q where q.legacy_hash = '1pc1paj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random', false, 'Rule-based decisions follow predefined conditions.' from questions q where q.legacy_hash = '1pc1paj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random number', false, 'A one-time code can be used as a factor, but a factor is a category of evidence: know, have, are, and so on.' from questions q where q.legacy_hash = 'ie7xv7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Evidence proving identity', true, NULL from questions q where q.legacy_hash = 'ie7xv7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Username', false, 'A username is identification. It claims an identity but proves nothing.' from questions q where q.legacy_hash = 'ie7xv7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email', false, 'An email address is an identifier, not proof of identity.' from questions q where q.legacy_hash = 'ie7xv7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Something you have', false, 'That''s the possession factor, like a phone or token.' from questions q where q.legacy_hash = '1rpf672'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Knowledge-based factor like password', true, NULL from questions q where q.legacy_hash = '1rpf672'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Biometric', false, 'Biometrics are something you are.' from questions q where q.legacy_hash = '1rpf672'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Location', false, 'Location is somewhere you are.' from questions q where q.legacy_hash = '1rpf672'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Password', false, 'A password is something you know.' from questions q where q.legacy_hash = '1rn11yb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Possession-based factor like token', true, NULL from questions q where q.legacy_hash = '1rn11yb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Biometric', false, 'A biometric is something you are.' from questions q where q.legacy_hash = '1rn11yb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Knowledge', false, 'Knowledge is the something-you-know factor.' from questions q where q.legacy_hash = '1rn11yb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Username', false, 'A username is identification, not an authentication factor.' from questions q where q.legacy_hash = '1jqhqd3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Biometric characteristic', true, NULL from questions q where q.legacy_hash = '1jqhqd3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Password', false, 'A password is something you know.' from questions q where q.legacy_hash = '1jqhqd3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Token', false, 'A token is something you have.' from questions q where q.legacy_hash = '1jqhqd3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Home address', false, 'It isn''t a stored address. The system checks your current location, for example by GPS or IP.' from questions q where q.legacy_hash = '1ifpf4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Location-based authentication', true, NULL from questions q where q.legacy_hash = '1ifpf4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Office', false, 'An office is one possible location. The factor is the location check itself.' from questions q where q.legacy_hash = '1ifpf4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Country', false, 'Country can be one level of detail, but the factor is location-based authentication in general.' from questions q where q.legacy_hash = '1ifpf4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Job description', false, 'The factor measures behavior like typing rhythm or gait, not your job.' from questions q where q.legacy_hash = 'xz4mnm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Behavioral biometric like typing pattern', true, NULL from questions q where q.legacy_hash = 'xz4mnm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Daily routine', false, 'It uses measurable behavioral patterns, like keystroke dynamics, not your schedule.' from questions q where q.legacy_hash = 'xz4mnm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Hobby', false, 'It refers to behavioral biometrics, not your interests.' from questions q where q.legacy_hash = 'xz4mnm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single person', false, 'Dual control requires two people, so no one can act alone.' from questions q where q.legacy_hash = '1m213sr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Two people required for action', true, NULL from questions q where q.legacy_hash = '1m213sr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No control', false, 'It''s a control that requires two people to act together.' from questions q where q.legacy_hash = '1m213sr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Triple control', false, 'Dual means exactly two, as with two keys needed to open a vault.' from questions q where q.legacy_hash = '1m213sr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring security', false, 'A security culture is the opposite: everyone paying attention to security.' from questions q where q.legacy_hash = '1jdx46x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Organization-wide security mindset', true, NULL from questions q where q.legacy_hash = '1jdx46x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'IT only', false, 'Culture spans the whole organization, not just the IT team.' from questions q where q.legacy_hash = '1jdx46x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No culture', false, 'It''s a deliberate, shared mindset across the organization.' from questions q where q.legacy_hash = '1jdx46x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Share everything', false, 'Shared mechanisms give problems a path to spread. This principle minimizes sharing.' from questions q where q.legacy_hash = '1ncbkme'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Minimize shared resources', true, NULL from questions q where q.legacy_hash = '1ncbkme'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Maximum sharing', false, 'The principle calls for the least sharing of mechanisms between users or processes.' from questions q where q.legacy_hash = '1ncbkme'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No isolation', false, 'It favors isolation, so one user''s compromise doesn''t reach others.' from questions q where q.legacy_hash = '1ncbkme'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Never fail', false, 'Every system can fail. Fail safe is about failing without causing harm.' from questions q where q.legacy_hash = '184ka6n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Safe mode on failure', true, NULL from questions q where q.legacy_hash = '184ka6n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Complete failure', false, 'Fail safe means failing into a controlled, harmless state, not collapsing.' from questions q where q.legacy_hash = '184ka6n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No safety', false, 'Safety during failure is the whole point.' from questions q where q.legacy_hash = '184ka6n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Complex is better', false, 'Complexity hides bugs and misconfigurations. Simple designs are easier to secure.' from questions q where q.legacy_hash = '1oifmkg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Simplicity improves security', true, NULL from questions q where q.legacy_hash = '1oifmkg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Overcomplicate', false, 'Overcomplicating a design adds attack surface and room for mistakes.' from questions q where q.legacy_hash = '1oifmkg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random complexity', false, 'The principle calls for as little complexity as possible.' from questions q where q.legacy_hash = '1oifmkg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No assessment', false, 'A PTA is an assessment: the first screening step.' from questions q where q.legacy_hash = '5p2yt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Evaluating privacy impact', true, NULL from questions q where q.legacy_hash = '5p2yt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring privacy', false, 'A PTA checks whether a system handles PII.' from questions q where q.legacy_hash = '5p2yt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random check', false, 'A PTA is a structured screening that decides whether a full privacy impact assessment (PIA) is needed.' from questions q where q.legacy_hash = '5p2yt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Cash register', false, 'In risk management, a register is a record of risks, owners, ratings and responses.' from questions q where q.legacy_hash = '1l5mqia'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Document tracking risks', true, NULL from questions q where q.legacy_hash = '1l5mqia'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Shopping list', false, 'It''s a formal tracking document for risks.' from questions q where q.legacy_hash = '1l5mqia'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Phone book', false, 'It records risks, not contacts.' from questions q where q.legacy_hash = '1l5mqia'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring risk', false, 'Acceptance is a documented, deliberate decision. Ignoring a risk isn''t.' from questions q where q.legacy_hash = '1xtrc1g'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Acknowledging and accepting risk', true, NULL from questions q where q.legacy_hash = '1xtrc1g'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Avoiding risk', false, 'Avoidance stops the activity. Acceptance continues it knowingly.' from questions q where q.legacy_hash = '1xtrc1g'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Transferring risk', false, 'Transference shifts the risk elsewhere, like to an insurer. Acceptance keeps it.' from questions q where q.legacy_hash = '1xtrc1g'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No risk', false, 'Controls rarely remove risk entirely. What''s left over is residual risk.' from questions q where q.legacy_hash = '7n0thi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Risk remaining after controls', true, NULL from questions q where q.legacy_hash = '7n0thi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Original risk', false, 'Risk before any controls is inherent risk.' from questions q where q.legacy_hash = '7n0thi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Future risk', false, 'Residual risk is what remains now, after controls, not a forecast.' from questions q where q.legacy_hash = '7n0thi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Final risk', false, 'The risk left at the end, after controls, is residual risk.' from questions q where q.legacy_hash = '1wzxpuy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Risk before controls', true, NULL from questions q where q.legacy_hash = '1wzxpuy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No risk', false, 'Inherent risk is the full, untreated risk.' from questions q where q.legacy_hash = '1wzxpuy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Controlled risk', false, 'Once controls are applied, what remains is residual risk.' from questions q where q.legacy_hash = '1wzxpuy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Exact numbers', false, 'Exact figures are quantitative. Qualitative uses ratings like high, medium and low.' from questions q where q.legacy_hash = '1caei8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Subjective risk evaluation', true, NULL from questions q where q.legacy_hash = '1caei8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Mathematical only', false, 'Formula-based analysis, like ALE, is quantitative.' from questions q where q.legacy_hash = '1caei8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No assessment', false, 'Qualitative assessment is a real method based on expert judgment.' from questions q where q.legacy_hash = '1caei8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Subjective only', false, 'Subjective ratings are qualitative. Quantitative uses numbers like SLE, ARO and ALE.' from questions q where q.legacy_hash = 'zvhuvm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Numerical risk analysis', true, NULL from questions q where q.legacy_hash = 'zvhuvm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No numbers', false, 'Numbers are what make it quantitative.' from questions q where q.legacy_hash = 'zvhuvm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Guessing', false, 'It relies on data such as asset value and how often incidents occur.' from questions q where q.legacy_hash = 'zvhuvm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Total loss', false, 'The total over a year is ALE. SLE is the loss from one occurrence (asset value × exposure factor).' from questions q where q.legacy_hash = '1dzcj3f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Loss from single incident', true, NULL from questions q where q.legacy_hash = '1dzcj3f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No loss', false, 'SLE is the expected loss when the event happens once.' from questions q where q.legacy_hash = '1dzcj3f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Multiple losses', false, 'Multiple occurrences come in through ARO when you calculate ALE.' from questions q where q.legacy_hash = '1dzcj3f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Monthly loss', false, 'ALE is annual: SLE × ARO (annualized rate of occurrence).' from questions q where q.legacy_hash = '1uw8tyg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Expected yearly loss', true, NULL from questions q where q.legacy_hash = '1uw8tyg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Daily loss', false, 'The A stands for annual, so it''s a per-year figure.' from questions q where q.legacy_hash = '1uw8tyg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No loss', false, 'ALE is the expected yearly loss from a risk.' from questions q where q.legacy_hash = '1uw8tyg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Malicious software designed to harm systems', true, NULL from questions q where q.legacy_hash = '17eg0yl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A type of firewall', false, 'A firewall is a defensive control that filters traffic. Malware is the harmful code such controls try to stop.' from questions q where q.legacy_hash = '17eg0yl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A security protocol', false, 'Protocols like TLS protect communications. Malware is software built to cause harm.' from questions q where q.legacy_hash = '17eg0yl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'An encryption algorithm', false, 'Algorithms like AES protect data. Ransomware may use encryption, but malware itself is any malicious program.' from questions q where q.legacy_hash = '17eg0yl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A network scanning technique', false, 'Scanning probes systems for open ports and services. Phishing targets people with deceptive messages.' from questions q where q.legacy_hash = '3ph3u6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A social engineering attack using fake emails', true, NULL from questions q where q.legacy_hash = '3ph3u6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A type of encryption', false, 'Encryption protects data. Phishing is a social engineering attack.' from questions q where q.legacy_hash = '3ph3u6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A firewall configuration', false, 'Firewall rules filter traffic. Phishing tricks people into giving up information.' from questions q where q.legacy_hash = '3ph3u6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'SQL Injection', false, 'SQL injection sends crafted input to manipulate a database. It isn''t about traffic volume.' from questions q where q.legacy_hash = '1ous7n9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Cross-Site Scripting', false, 'XSS injects scripts into web pages that other users view. It doesn''t flood the target.' from questions q where q.legacy_hash = '1ous7n9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Denial of Service', true, NULL from questions q where q.legacy_hash = '1ous7n9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Man-in-the-Middle', false, 'An on-path attacker quietly intercepts traffic between two parties rather than flooding a system.' from questions q where q.legacy_hash = '1ous7n9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Software that monitors user activity', false, 'That describes spyware. Ransomware locks or encrypts your files and demands payment.' from questions q where q.legacy_hash = 'dqp7v7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware that encrypts files and demands payment', true, NULL from questions q where q.legacy_hash = 'dqp7v7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A type of firewall', false, 'A firewall is a defensive control, not malware.' from questions q where q.legacy_hash = 'dqp7v7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'An antivirus program', false, 'Antivirus defends against malware such as ransomware.' from questions q where q.legacy_hash = 'dqp7v7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Password encryption', false, 'ATT&CK is a knowledge base of attacker behavior. Passwords are protected with hashing, not a framework.' from questions q where q.legacy_hash = '1nxb28p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Categorizing and understanding adversary tactics and techniques', true, NULL from questions q where q.legacy_hash = '1nxb28p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network traffic filtering', false, 'Filtering is a firewall''s job. ATT&CK helps defenders understand and detect attacker techniques.' from questions q where q.legacy_hash = '1nxb28p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'User authentication', false, 'ATT&CK doesn''t authenticate anyone. It catalogs tactics, techniques and procedures (TTPs).' from questions q where q.legacy_hash = '1nxb28p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A type of malware', false, 'Malware is a threat that may exploit a vulnerability. The vulnerability is the weakness itself.' from questions q where q.legacy_hash = '14hvwdb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A weakness in a system', true, NULL from questions q where q.legacy_hash = '14hvwdb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A security control', false, 'A control reduces risk, often by fixing or shielding a vulnerability.' from questions q where q.legacy_hash = '14hvwdb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'An encryption method', false, 'Encryption is a control. A vulnerability is a flaw that could be exploited.' from questions q where q.legacy_hash = '14hvwdb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Exploit for known vulnerabilities', false, 'Known, disclosed flaws usually have patches available. Zero-days target flaws the vendor doesn''t know about yet.' from questions q where q.legacy_hash = 'wsgr6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploit for unknown vulnerabilities', true, NULL from questions q where q.legacy_hash = 'wsgr6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Expired exploit', false, '''Zero day'' means defenders have had zero days to fix the flaw, not that the exploit expired.' from questions q where q.legacy_hash = 'wsgr6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Slow exploit', false, 'The name is about how long the flaw has been known, not the attack''s speed.' from questions q where q.legacy_hash = 'wsgr6t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Quick attack', false, 'APTs are the opposite: they stay hidden in a network for months or longer.' from questions q where q.legacy_hash = 'on29ix'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Long-term targeted attack', true, NULL from questions q where q.legacy_hash = 'on29ix'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Automated attack', false, 'APTs are run by skilled, often nation-state, operators who adapt their approach, not by automation alone.' from questions q where q.legacy_hash = 'on29ix'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random attack', false, 'APTs choose their targets deliberately and pursue them persistently.' from questions q where q.legacy_hash = 'on29ix'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Building networks', false, 'Building networks is network engineering. Social engineering manipulates people.' from questions q where q.legacy_hash = 'ddefju'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Manipulating people to divulge information', true, NULL from questions q where q.legacy_hash = 'ddefju'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Installing software', false, 'Social engineering targets human behavior, not system setup.' from questions q where q.legacy_hash = 'ddefju'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Encrypting data', false, 'Encryption is a technical control. Social engineering works around technology by deceiving people.' from questions q where q.legacy_hash = 'ddefju'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'General phishing attack', false, 'Mass phishing sends the same lure to many people. Spear phishing is tailored to specific targets.' from questions q where q.legacy_hash = '1sfyjpl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Targeted phishing attack', true, NULL from questions q where q.legacy_hash = '1sfyjpl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical attack', false, 'Spear phishing is delivered digitally, usually by email, not in person.' from questions q where q.legacy_hash = '1sfyjpl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network attack', false, 'It targets a person through a personalized message, not network infrastructure.' from questions q where q.legacy_hash = '1sfyjpl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Gaining higher access rights', true, NULL from questions q where q.legacy_hash = '1saafku'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Reducing permissions', false, 'That''s the opposite. Escalation means gaining more rights than you were granted.' from questions q where q.legacy_hash = '1saafku'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating users', false, 'An attacker might create accounts afterwards, but escalation is about raising privilege levels.' from questions q where q.legacy_hash = '1saafku'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting accounts', false, 'Deleting accounts is a separate action, not the act of gaining elevated access.' from questions q where q.legacy_hash = '1saafku'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Antivirus software', false, 'Antivirus detects trojans. A trojan pretends to be legitimate software.' from questions q where q.legacy_hash = '5pw8dg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware disguised as legitimate software', true, NULL from questions q where q.legacy_hash = '5pw8dg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'A firewall is a defensive control, not malware.' from questions q where q.legacy_hash = '5pw8dg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Encryption tool', false, 'A trojan may pose as a useful tool, but it''s malware underneath.' from questions q where q.legacy_hash = '5pw8dg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Database optimization', false, 'Optimization improves performance. SQL injection abuses unsanitized input to run the attacker''s queries.' from questions q where q.legacy_hash = '1vkhvl3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Inserting malicious SQL code', true, NULL from questions q where q.legacy_hash = '1vkhvl3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating databases', false, 'Creating databases is normal administration, not an attack.' from questions q where q.legacy_hash = '1vkhvl3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backing up data', false, 'Backups protect data. SQL injection steals or alters it.' from questions q where q.legacy_hash = '1vkhvl3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Direct attack', false, 'A supply chain attack is indirect: it goes through a trusted vendor, software update or component.' from questions q where q.legacy_hash = '1wcs3q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Attack through trusted suppliers', true, NULL from questions q where q.legacy_hash = '1wcs3q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical theft', false, 'Stealing goods isn''t the point. The attack compromises something the target trusts and installs.' from questions q where q.legacy_hash = '1wcs3q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password attack', false, 'Password attacks target credentials directly. Supply chain attacks abuse a third party''s trust.' from questions q where q.legacy_hash = '1wcs3q5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hardware device', false, 'A virus is code, not hardware.' from questions q where q.legacy_hash = '5lhnri'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware that replicates itself', true, NULL from questions q where q.legacy_hash = '5lhnri'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security tool', false, 'Security tools remove viruses.' from questions q where q.legacy_hash = '5lhnri'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network protocol', false, 'Protocols define how systems communicate. A virus is malware that infects files.' from questions q where q.legacy_hash = '5lhnri'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Self-replicating malware', true, NULL from questions q where q.legacy_hash = '6nekmy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Physical device', false, 'A worm is malicious code, not hardware.' from questions q where q.legacy_hash = '6nekmy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encryption method', false, 'Encryption protects data. A worm spreads itself across networks.' from questions q where q.legacy_hash = '6nekmy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Access control', false, 'Access controls restrict who can use a resource. A worm is malware.' from questions q where q.legacy_hash = '6nekmy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Admin tool', false, 'A rootkit may grant root-level access, but it''s malware designed to hide that access.' from questions q where q.legacy_hash = '1rhxmdd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware that hides its presence', true, NULL from questions q where q.legacy_hash = '1rhxmdd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'A firewall filters traffic. A rootkit hides malicious activity deep in the system.' from questions q where q.legacy_hash = '1rhxmdd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus tries to find rootkits, which are built to evade exactly that.' from questions q where q.legacy_hash = '1rhxmdd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Online advertising', false, 'Ordinary online ads are legitimate. Malvertising uses ads to deliver malware.' from questions q where q.legacy_hash = 'q7w6o9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malicious advertising', true, NULL from questions q where q.legacy_hash = 'q7w6o9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ad blocker', false, 'An ad blocker can help defend against malvertising.' from questions q where q.legacy_hash = 'q7w6o9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Marketing tool', false, 'Malvertising abuses ad networks to attack users; it isn''t a marketing tool.' from questions q where q.legacy_hash = 'q7w6o9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical attack', false, 'A watering hole attack is online: it infects websites the targets already visit.' from questions q where q.legacy_hash = 'qlool1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Compromising frequently visited websites', true, NULL from questions q where q.legacy_hash = 'qlool1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email attack', false, 'No email is needed. The attacker waits on a compromised site the targets trust.' from questions q where q.legacy_hash = 'qlool1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Phone attack', false, 'It''s web-based, not phone-based.' from questions q where q.legacy_hash = 'qlool1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Fixing typos', false, 'Typosquatting exploits typos. It registers look-alike domains such as ''gooogle.com''.' from questions q where q.legacy_hash = '1alelvk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Registering misspelled domains', true, NULL from questions q where q.legacy_hash = '1alelvk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Correcting errors', false, 'Nothing gets corrected. Attackers profit from users'' typing mistakes.' from questions q where q.legacy_hash = '1alelvk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Domain protection', false, 'Registering common misspellings of your own domain is a defense, but typosquatting is the attack.' from questions q where q.legacy_hash = '1alelvk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single infected computer', false, 'One infected machine is a bot. A botnet is many bots under central control.' from questions q where q.legacy_hash = '19kk6w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network of infected computers', true, NULL from questions q where q.legacy_hash = '19kk6w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security tool', false, 'Botnets are attacker infrastructure, used for DDoS attacks, spam and more.' from questions q where q.legacy_hash = '19kk6w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall type', false, 'Firewalls defend networks. A botnet is a network of compromised machines.' from questions q where q.legacy_hash = '19kk6w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating passwords', false, 'Credential stuffing reuses passwords already leaked in breaches.' from questions q where q.legacy_hash = 'w2560l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Using stolen credentials on multiple sites', true, NULL from questions q where q.legacy_hash = 'w2560l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting passwords', false, 'Encryption protects passwords. Stuffing tries stolen ones on other sites.' from questions q where q.legacy_hash = 'w2560l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Resetting passwords', false, 'A reset is a recovery process. Stuffing is automated logins with stolen credentials.' from questions q where q.legacy_hash = 'w2560l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Attack using files', false, 'Fileless attacks deliberately avoid dropping files, which is why file scanners miss them.' from questions q where q.legacy_hash = 'elqgzx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Attack without writing files to disk', true, NULL from questions q where q.legacy_hash = 'elqgzx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting files', false, 'It runs in memory and in legitimate tools. It isn''t about deleting files.' from questions q where q.legacy_hash = 'elqgzx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backing up files', false, 'Backups are a defense. Fileless malware is an attack technique.' from questions q where q.legacy_hash = 'elqgzx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hardware component', false, 'Adware is software.' from questions q where q.legacy_hash = '1enioh4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Software that displays unwanted ads', true, NULL from questions q where q.legacy_hash = '1enioh4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus program', false, 'Antivirus can remove adware.' from questions q where q.legacy_hash = '1enioh4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email client', false, 'An email client handles mail. Adware pushes unwanted ads.' from questions q where q.legacy_hash = '1enioh4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical explosive', false, 'It''s code that ''detonates'' when a condition is met, such as a date or an employee being removed.' from questions q where q.legacy_hash = '1u6ldgj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malicious code triggered by conditions', true, NULL from questions q where q.legacy_hash = '1u6ldgj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network device', false, 'A logic bomb is hidden code inside software, not a device.' from questions q where q.legacy_hash = '1u6ldgj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security tool', false, 'It''s malicious code, often planted by an insider.' from questions q where q.legacy_hash = '1u6ldgj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Slow performance', false, 'The flaw is about the order and timing of operations, not speed. An attacker slips in between two steps.' from questions q where q.legacy_hash = '15s3nvl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Timing-dependent security flaw', true, NULL from questions q where q.legacy_hash = '15s3nvl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network congestion', false, 'Congestion is heavy traffic. A race condition is a software timing flaw, such as time-of-check to time-of-use (TOCTOU).' from questions q where q.legacy_hash = '15s3nvl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Disk error', false, 'Disk errors are hardware faults. Race conditions come from how code handles concurrent operations.' from questions q where q.legacy_hash = '15s3nvl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Agriculture practice', false, 'Pharming is a play on ''phishing'': it redirects traffic to fake sites.' from questions q where q.legacy_hash = '19dsfii'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Redirecting web traffic to fake sites', true, NULL from questions q where q.legacy_hash = '19dsfii'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email filtering', false, 'Filtering is a defense. Pharming poisons DNS or hosts files to send users to the wrong site.' from questions q where q.legacy_hash = '19dsfii'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password storage', false, 'Pharming steals credentials through fake sites; it doesn''t store them securely.' from questions q where q.legacy_hash = '19dsfii'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Writing code', false, 'Pretexting is social engineering: inventing a believable story, like posing as IT support.' from questions q where q.legacy_hash = 'o5rj5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Creating fabricated scenario to steal information', true, NULL from questions q where q.legacy_hash = 'o5rj5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Testing software', false, 'It targets people, not software.' from questions q where q.legacy_hash = 'o5rj5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Installing updates', false, 'An attacker might pretend to be installing updates, but pretexting is the made-up story itself.' from questions q where q.legacy_hash = 'o5rj5q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Following cars', false, 'In security, tailgating means slipping through a secured door behind an authorized person.' from questions q where q.legacy_hash = '1xxa8wo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Following someone through secure door', true, NULL from questions q where q.legacy_hash = '1xxa8wo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network attack', false, 'Tailgating is a physical intrusion.' from questions q where q.legacy_hash = '1xxa8wo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email attack', false, 'It happens in person at a door, not by email.' from questions q where q.legacy_hash = '1xxa8wo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'External hacker', false, 'An insider already has authorized access, such as an employee or contractor. External hackers don''t.' from questions q where q.legacy_hash = '1eq2ift'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Threat from within organization', true, NULL from questions q where q.legacy_hash = '1eq2ift'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Virus', false, 'A virus is malware. An insider threat is a person.' from questions q where q.legacy_hash = '1eq2ift'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall is a control, and it does little against someone already inside.' from questions q where q.legacy_hash = '1eq2ift'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Visual attack', false, 'The V stands for voice: phishing over phone calls.' from questions q where q.legacy_hash = 'r5atbg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Voice phishing over phone', true, NULL from questions q where q.legacy_hash = 'r5atbg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email attack', false, 'Email-based lures are regular phishing.' from questions q where q.legacy_hash = 'r5atbg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Text attack', false, 'Text-message phishing is smishing.' from questions q where q.legacy_hash = 'r5atbg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Smiling attack', false, 'Smishing combines SMS and phishing.' from questions q where q.legacy_hash = '28z3ti'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'SMS/text message phishing', true, NULL from questions q where q.legacy_hash = '28z3ti'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email attack', false, 'Email lures are regular phishing.' from questions q where q.legacy_hash = '28z3ti'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Phone call', false, 'Phone calls are vishing. Smishing uses text messages.' from questions q where q.legacy_hash = '28z3ti'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Static virus', false, 'Polymorphic means many forms: it changes its code to avoid signature detection.' from questions q where q.legacy_hash = 'b7lpr8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Virus that changes its code', true, NULL from questions q where q.legacy_hash = 'b7lpr8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Harmless program', false, 'A polymorphic virus is malware that is especially hard to detect.' from questions q where q.legacy_hash = 'b7lpr8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus struggles against polymorphic viruses because their signatures keep changing.' from questions q where q.legacy_hash = 'b7lpr8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Diving sport', false, 'It means literally searching trash for documents or media containing sensitive data.' from questions q where q.legacy_hash = 'qmfug9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Searching trash for sensitive information', true, NULL from questions q where q.legacy_hash = 'qmfug9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network attack', false, 'It''s physical: going through discarded papers and devices.' from questions q where q.legacy_hash = 'qmfug9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Software bug', false, 'It''s a reconnaissance technique, not a flaw in code.' from questions q where q.legacy_hash = 'qmfug9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Exercise', false, 'It means watching someone''s screen or keypad to steal information.' from questions q where q.legacy_hash = '1wyhni0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Observing someone to steal information', true, NULL from questions q where q.legacy_hash = '1wyhni0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical attack', false, 'It involves being physically nearby, but nothing is attacked. The attacker just watches.' from questions q where q.legacy_hash = '1wyhni0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network scan', false, 'It''s direct observation, not scanning systems.' from questions q where q.legacy_hash = '1wyhni0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Management structure', false, 'In security, C&C (C2) is the attacker''s infrastructure for directing compromised machines.' from questions q where q.legacy_hash = '1pyznes'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Server controlling compromised systems', true, NULL from questions q where q.legacy_hash = '1pyznes'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'A firewall may block C&C traffic, but C&C is the attacker''s server.' from questions q where q.legacy_hash = '1pyznes'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'A router forwards traffic. A C&C server sends commands to infected hosts.' from questions q where q.legacy_hash = '1pyznes'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Fishing', false, 'The bait is usually an infected USB drive left for someone to plug in.' from questions q where q.legacy_hash = 'umquqa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Leaving infected device to be found', true, NULL from questions q where q.legacy_hash = 'umquqa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email attack', false, 'Baiting typically uses physical media, relying on curiosity.' from questions q where q.legacy_hash = 'umquqa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Phone scam', false, 'Phone scams are vishing. Baiting leaves a tempting infected device.' from questions q where q.legacy_hash = 'umquqa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical door', false, 'It''s a hidden way into a system that bypasses normal authentication.' from questions q where q.legacy_hash = '175enyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Hidden access method', true, NULL from questions q where q.legacy_hash = '175enyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Front entrance', false, 'A backdoor is the opposite of the normal, authenticated way in.' from questions q where q.legacy_hash = '175enyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Window', false, 'It''s a covert software access path, not a building feature.' from questions q where q.legacy_hash = '175enyy'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Stealing wallets', false, 'Wallet theft takes existing coins. Cryptojacking secretly uses your computing power to mine new ones.' from questions q where q.legacy_hash = '15vmqy4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unauthorized cryptocurrency mining', true, NULL from questions q where q.legacy_hash = '15vmqy4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encryption', false, 'Mining involves cryptography, but cryptojacking is unauthorized mining, not encryption.' from questions q where q.legacy_hash = '15vmqy4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password theft', false, 'It hijacks computing resources, not credentials.' from questions q where q.legacy_hash = '15vmqy4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Password manager', false, 'A password manager protects passwords. A keylogger steals them by recording keystrokes.' from questions q where q.legacy_hash = '7fw65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Software recording keystrokes', true, NULL from questions q where q.legacy_hash = '7fw65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security tool', false, 'Keyloggers can be used in monitoring, but in this context they''re malware.' from questions q where q.legacy_hash = '7fw65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus tries to detect keyloggers.' from questions q where q.legacy_hash = '7fw65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ham', false, '''Ham'' is filter slang for wanted, legitimate email. Spam is the unwanted bulk kind.' from questions q where q.legacy_hash = '14gepx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unsolicited bulk email', true, NULL from questions q where q.legacy_hash = '14gepx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Legitimate email', false, 'Spam is unsolicited and often malicious.' from questions q where q.legacy_hash = '14gepx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Important messages', false, 'Spam is junk sent in bulk.' from questions q where q.legacy_hash = '14gepx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating sessions', false, 'Hijacking takes over someone else''s existing session, often by stealing its cookie.' from questions q where q.legacy_hash = 'hj21eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Taking over active session', true, NULL from questions q where q.legacy_hash = 'hj21eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Closing sessions', false, 'Logging out is a defense. Hijacking keeps the stolen session alive.' from questions q where q.legacy_hash = 'hj21eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Starting sessions', false, 'The attacker doesn''t start a session; they take over a valid one.' from questions q where q.legacy_hash = 'hj21eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Database attack', false, 'Attacking the database is SQL injection. XSS runs scripts in the victim''s browser.' from questions q where q.legacy_hash = 'kst05e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Injecting malicious scripts into websites', true, NULL from questions q where q.legacy_hash = 'kst05e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network attack', false, 'XSS is an application-layer web attack.' from questions q where q.legacy_hash = 'kst05e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Physical attack', false, 'XSS is delivered through web pages.' from questions q where q.legacy_hash = 'kst05e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Good service', false, 'DoS is the opposite: making a service unavailable.' from questions q where q.legacy_hash = 'ry6pnk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Making service unavailable', true, NULL from questions q where q.legacy_hash = 'ry6pnk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Better service', false, 'It degrades or blocks service.' from questions q where q.legacy_hash = 'ry6pnk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Faster service', false, 'It floods or crashes a service, making it slower or unusable.' from questions q where q.legacy_hash = 'ry6pnk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Too much data in buffer', true, NULL from questions q where q.legacy_hash = '9cj2aq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Empty buffer', false, 'An overflow writes more data than the buffer holds, spilling into nearby memory.' from questions q where q.legacy_hash = '9cj2aq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal operation', false, 'It''s a memory-safety flaw that can let attackers run code.' from questions q where q.legacy_hash = '9cj2aq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Fast buffer', false, 'Speed is irrelevant. The issue is data exceeding the buffer''s size.' from questions q where q.legacy_hash = '9cj2aq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Loud talking', false, 'It means secretly listening in on communications.' from questions q where q.legacy_hash = 'c0ppe3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Secretly listening to communications', true, NULL from questions q where q.legacy_hash = 'c0ppe3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Broadcasting', false, 'Broadcasting sends information openly. Eavesdropping intercepts it secretly.' from questions q where q.legacy_hash = 'c0ppe3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Announcing', false, 'Announcing is public. Eavesdropping is covert.' from questions q where q.legacy_hash = 'c0ppe3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Being yourself', false, 'Impersonation means pretending to be someone else, like IT support or an executive.' from questions q where q.legacy_hash = 'jdwi8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Pretending to be someone else', true, NULL from questions q where q.legacy_hash = 'jdwi8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Real identity', false, 'The attacker uses a false identity.' from questions q where q.legacy_hash = 'jdwi8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Honest behavior', false, 'It''s deception used to gain trust and access.' from questions q where q.legacy_hash = 'jdwi8s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Direct attack', false, 'Side channels are indirect: they infer secrets from timing, power use or emissions.' from questions q where q.legacy_hash = 'b4id20'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploiting implementation information', true, NULL from questions q where q.legacy_hash = 'b4id20'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Front attack', false, 'It doesn''t break the algorithm head-on; it watches physical side effects.' from questions q where q.legacy_hash = 'b4id20'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password attack', false, 'Side channels can leak keys or passwords, but the defining trait is measuring leaked signals.' from questions q where q.legacy_hash = 'b4id20'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random attack', false, 'Recon is deliberate information gathering before an attack.' from questions q where q.legacy_hash = '261cio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Information gathering', true, NULL from questions q where q.legacy_hash = '261cio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Direct attack', false, 'Recon happens before the attack, such as OSINT or scanning.' from questions q where q.legacy_hash = '261cio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Defense', false, 'Defenders do their own discovery too, but reconnaissance is the attacker''s first phase.' from questions q where q.legacy_hash = '261cio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using social media', false, 'Normal use isn''t a threat. The threat is attackers exploiting these platforms.' from questions q where q.legacy_hash = 'gtnl93'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Threats via social platforms', true, NULL from questions q where q.legacy_hash = 'gtnl93'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Posting photos', false, 'Oversharing can help attackers, but the threat is the exploitation, like OSINT or scams.' from questions q where q.legacy_hash = 'gtnl93'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Making friends', false, 'Fake friend requests can be a tactic, but the threat is the attack itself.' from questions q where q.legacy_hash = 'gtnl93'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Cleaning DNS', false, 'Flushing the DNS cache can clear poisoning. Poisoning inserts false records.' from questions q where q.legacy_hash = '1o89vpr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Corrupting DNS data', true, NULL from questions q where q.legacy_hash = '1o89vpr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Good DNS', false, 'Poisoned DNS sends users to malicious IP addresses.' from questions q where q.legacy_hash = '1o89vpr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Fast DNS', false, 'It corrupts answers; it has nothing to do with speed.' from questions q where q.legacy_hash = '1o89vpr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Real IP', false, 'Spoofing forges the source address.' from questions q where q.legacy_hash = '1sm99ki'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Faking source IP address', true, NULL from questions q where q.legacy_hash = '1sm99ki'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Valid IP', false, 'The forged address may look valid, but it isn''t the sender''s.' from questions q where q.legacy_hash = '1sm99ki'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Assigned IP', false, 'Spoofing uses an address the attacker wasn''t assigned.' from questions q where q.legacy_hash = '1sm99ki'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Changing password', false, 'Changing a password is routine. Attacks try to discover or crack someone else''s.' from questions q where q.legacy_hash = '1dvp6u7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Attempting to discover passwords', true, NULL from questions q where q.legacy_hash = '1dvp6u7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating password', false, 'Creating passwords is normal. The attack targets existing ones.' from questions q where q.legacy_hash = '1dvp6u7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Strong password', false, 'Strong passwords defend against these attacks.' from questions q where q.legacy_hash = '1dvp6u7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using password', false, 'The attacker never needs the plaintext password, just the stolen hash.' from questions q where q.legacy_hash = '1i3hyq2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Using hashed credentials', true, NULL from questions q where q.legacy_hash = '1i3hyq2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Cracking password', false, 'Cracking recovers the password. Pass-the-hash skips that and sends the hash directly.' from questions q where q.legacy_hash = '1i3hyq2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating hash', false, 'The hash is stolen from memory or storage, not created.' from questions q where q.legacy_hash = '1i3hyq2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Smart guessing', false, 'Informed guessing from wordlists is a dictionary attack. Brute force tries everything.' from questions q where q.legacy_hash = '1llgw9p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Trying all possible combinations', true, NULL from questions q where q.legacy_hash = '1llgw9p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Single attempt', false, 'Brute force makes huge numbers of attempts.' from questions q where q.legacy_hash = '1llgw9p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Social engineering', false, 'Brute force is purely computational; no people are tricked.' from questions q where q.legacy_hash = '1llgw9p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Forcing answers', false, 'Elicitation is subtle: casual conversation that draws information out.' from questions q where q.legacy_hash = '19l5zgp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Extracting information through conversation', true, NULL from questions q where q.legacy_hash = '19l5zgp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring people', false, 'It requires engaging people in friendly conversation.' from questions q where q.legacy_hash = '19l5zgp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Silent treatment', false, 'It relies on talking, often with flattery or false statements that invite correction.' from questions q where q.legacy_hash = '19l5zgp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Real threat', false, 'A hoax is fake, like a bogus virus warning, but it still causes disruption.' from questions q where q.legacy_hash = '6cswp1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'False threat causing disruption', true, NULL from questions q where q.legacy_hash = '6cswp1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security tool', false, 'Hoaxes are social engineering, not tools.' from questions q where q.legacy_hash = '6cswp1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Prevention method', false, 'Hoaxes cause harm, such as tricking users into deleting system files.' from questions q where q.legacy_hash = '6cswp1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Good clicks', false, 'Clickjacking hides a malicious element under something the user means to click.' from questions q where q.legacy_hash = '64pgnl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Tricking users into clicking', true, NULL from questions q where q.legacy_hash = '64pgnl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Fast clicking', false, 'Speed isn''t involved. It''s deception with layered or invisible page elements.' from questions q where q.legacy_hash = '64pgnl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Double clicking', false, 'It''s about what gets clicked, not how many times.' from questions q where q.legacy_hash = '64pgnl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ocean activity', false, 'Whaling is phishing aimed at ''big fish'' like executives.' from questions q where q.legacy_hash = '1nrpyny'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Targeting high-profile individuals', true, NULL from questions q where q.legacy_hash = '1nrpyny'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Regular phishing', false, 'Regular phishing is broad. Whaling targets senior, high-value individuals.' from questions q where q.legacy_hash = '1nrpyny'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Fishing', false, 'It''s phishing, spelled with ''ph'', aimed at executives.' from questions q where q.legacy_hash = '1nrpyny'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Buying domain', false, 'A legitimate purchase isn''t hijacking. Hijacking takes control without authorization.' from questions q where q.legacy_hash = 'uywxsk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unauthorized domain control', true, NULL from questions q where q.legacy_hash = 'uywxsk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Registering domain', false, 'Registration is lawful. Hijacking steals an existing domain, often through the registrar account.' from questions q where q.legacy_hash = 'uywxsk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Legal ownership', false, 'Hijacking is unauthorized control.' from questions q where q.legacy_hash = 'uywxsk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Correct URLs', false, 'It exploits incorrect URLs that users mistype.' from questions q where q.legacy_hash = 'g74utr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploiting misspelled URLs', true, NULL from questions q where q.legacy_hash = 'g74utr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating URLs', false, 'The attacker registers look-alike domains specifically to capture mistakes.' from questions q where q.legacy_hash = 'g74utr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Valid URLs', false, 'Users meant to reach the valid URL but land on the attacker''s look-alike.' from questions q where q.legacy_hash = 'g74utr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Real invoice', false, 'The invoice is fake, made to look like a real supplier''s.' from questions q where q.legacy_hash = '10kt1r9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Fake invoice for payment', true, NULL from questions q where q.legacy_hash = '10kt1r9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Legitimate bill', false, 'A legitimate bill is owed. The scam invoice isn''t.' from questions q where q.legacy_hash = '10kt1r9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Receipt', false, 'A receipt confirms a payment. The scam tries to trigger one.' from questions q where q.legacy_hash = '10kt1r9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Direct path', false, '''On-path'' means the attacker sits between two parties and intercepts traffic.' from questions q where q.legacy_hash = 'rkhf5v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Intercepting communications', true, NULL from questions q where q.legacy_hash = 'rkhf5v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Straight line', false, 'The name describes the attacker''s position between communicating parties.' from questions q where q.legacy_hash = 'rkhf5v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Open path', false, 'It''s interception, formerly called man-in-the-middle.' from questions q where q.legacy_hash = 'rkhf5v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Playing music', false, 'The attacker captures valid traffic, like an auth token, and sends it again.' from questions q where q.legacy_hash = 'o6vv89'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Retransmitting captured data', true, NULL from questions q where q.legacy_hash = 'o6vv89'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting data', false, 'Replay reuses captured data; it doesn''t delete it.' from questions q where q.legacy_hash = 'o6vv89'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating data', false, 'Nothing new is created. Valid data is resent.' from questions q where q.legacy_hash = 'o6vv89'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Party planning', false, 'It''s named after the birthday paradox, which makes hash collisions more likely than you''d expect.' from questions q where q.legacy_hash = '1s87hlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Cryptographic collision attack', true, NULL from questions q where q.legacy_hash = '1s87hlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Annual event', false, 'It''s a probability-based attack on hash functions.' from questions q where q.legacy_hash = '1s87hlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Calendar attack', false, 'It targets hash collisions, not calendars.' from questions q where q.legacy_hash = '1s87hlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Upgrading', false, 'A downgrade attack forces an older, weaker version, such as SSL instead of modern TLS.' from questions q where q.legacy_hash = '1ljorhj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Forcing use of weaker security', true, NULL from questions q where q.legacy_hash = '1ljorhj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Improving security', false, 'It deliberately weakens the security in use.' from questions q where q.legacy_hash = '1ljorhj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Latest version', false, 'The attacker pushes toward an older, vulnerable version.' from questions q where q.legacy_hash = '1ljorhj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Finding water', false, 'The name is a metaphor: predators wait at the watering hole. Attackers infect sites their targets visit.' from questions q where q.legacy_hash = '1izp0lt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Compromising frequently visited sites', true, NULL from questions q where q.legacy_hash = '1izp0lt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Direct attack', false, 'It''s indirect: the site is compromised and the targets come to it.' from questions q where q.legacy_hash = '1izp0lt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email campaign', false, 'No email is needed. The trap is a trusted website.' from questions q where q.legacy_hash = '1izp0lt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Giving rides', false, 'Piggybacking means an unauthorized person entering with an authorized person, often with their consent.' from questions q where q.legacy_hash = '136ztab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unauthorized person following through access point', true, NULL from questions q where q.legacy_hash = '136ztab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network protocol', false, 'It''s a physical access breach.' from questions q where q.legacy_hash = '136ztab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'File sharing', false, 'It''s about secured entrances, not files.' from questions q where q.legacy_hash = '136ztab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Friendly AI', false, 'Adversarial AI is used to attack or fool AI systems, for example with manipulated inputs.' from questions q where q.legacy_hash = 'gp4i98'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'AI attacking other AI systems', true, NULL from questions q where q.legacy_hash = 'gp4i98'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Helpful AI', false, 'It aims to make AI systems misbehave.' from questions q where q.legacy_hash = 'gp4i98'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe AI', false, 'It''s a threat to AI safety, not a form of it.' from questions q where q.legacy_hash = 'gp4i98'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Stealing juice', false, '''Juice'' means power: public USB charging ports rigged to steal data or install malware.' from questions q where q.legacy_hash = '8ua5vf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware via USB charging ports', true, NULL from questions q where q.legacy_hash = '8ua5vf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Power surge', false, 'A surge damages hardware. Juice jacking uses the USB data lines to attack.' from questions q where q.legacy_hash = '8ua5vf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Battery drain', false, 'The threat is data theft or malware over USB, not draining the battery.' from questions q where q.legacy_hash = '8ua5vf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Perfect setup', false, 'A misconfiguration is a setting that''s wrong or insecure, like default passwords.' from questions q where q.legacy_hash = 'ibqxhq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Incorrect security settings', true, NULL from questions q where q.legacy_hash = 'ibqxhq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Best configuration', false, 'It''s the opposite of a secure baseline.' from questions q where q.legacy_hash = 'ibqxhq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Optimized settings', false, 'It''s an insecure setting that attackers can exploit.' from questions q where q.legacy_hash = 'ibqxhq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using new tools', false, 'The attacker avoids bringing tools, using built-in ones like PowerShell to blend in.' from questions q where q.legacy_hash = '15zvt81'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Using legitimate system tools', true, NULL from questions q where q.legacy_hash = '15zvt81'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical attack', false, 'It''s a digital technique using legitimate admin tools.' from questions q where q.legacy_hash = '15zvt81'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'External tools', false, 'Dropping outside tools risks detection. Living off the land uses what''s already installed.' from questions q where q.legacy_hash = '15zvt81'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single source attack', false, 'A single source is plain DoS. DDoS comes from many distributed systems, often a botnet.' from questions q where q.legacy_hash = '1d4zl13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Distributed denial of service', true, NULL from questions q where q.legacy_hash = '1d4zl13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Direct attack', false, 'The extra ''D'' is for distributed: traffic comes from many hosts at once.' from questions q where q.legacy_hash = '1d4zl13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Data attack', false, 'DDoS targets availability by flooding, not the data itself.' from questions q where q.legacy_hash = '1d4zl13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Strength', false, 'A vulnerability is a weakness.' from questions q where q.legacy_hash = '14bd62m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Weakness that can be exploited', true, NULL from questions q where q.legacy_hash = '14bd62m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Feature', false, 'Features can be abused, but a vulnerability is a flaw that can be exploited.' from questions q where q.legacy_hash = '14bd62m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Benefit', false, 'A vulnerability creates risk, not benefit.' from questions q where q.legacy_hash = '14bd62m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Security tool', false, 'Exploit kits are attacker toolkits that automatically exploit browser and plugin flaws.' from questions q where q.legacy_hash = 'xzi63l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Automated attack tools', true, NULL from questions q where q.legacy_hash = 'xzi63l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus', false, 'Antivirus defends against exploit kits.' from questions q where q.legacy_hash = 'xzi63l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall filters traffic. An exploit kit attacks visitors'' systems.' from questions q where q.legacy_hash = 'xzi63l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Writing code', false, 'Normal development isn''t injection. The attacker slips their own code into a vulnerable application.' from questions q where q.legacy_hash = '1vjr30y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Inserting malicious code', true, NULL from questions q where q.legacy_hash = '1vjr30y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting code', false, 'Injection adds malicious code.' from questions q where q.legacy_hash = '1vjr30y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Debugging', false, 'Debugging fixes flaws. Injection exploits them.' from questions q where q.legacy_hash = '1vjr30y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal XML', false, 'XXE abuses a parser that resolves external entities to read files or reach internal systems.' from questions q where q.legacy_hash = 'ym0d25'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploiting XML parsers', true, NULL from questions q where q.legacy_hash = 'ym0d25'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'XML feature', false, 'External entities are a real XML feature, but XXE is the attack that abuses them.' from questions q where q.legacy_hash = 'ym0d25'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe operation', false, 'XXE can leak files or enable SSRF.' from questions q where q.legacy_hash = 'ym0d25'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal query', false, 'The attacker injects crafted input into LDAP queries to change what they return.' from questions q where q.legacy_hash = 'wtjjmg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Injecting malicious LDAP statements', true, NULL from questions q where q.legacy_hash = 'wtjjmg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Database backup', false, 'It''s an injection attack on directory services.' from questions q where q.legacy_hash = 'wtjjmg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security feature', false, 'It exploits missing input validation.' from questions q where q.legacy_hash = 'wtjjmg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal command', false, 'The attacker adds their own OS commands through unsanitized input.' from questions q where q.legacy_hash = 't9zot2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Injecting OS commands', true, NULL from questions q where q.legacy_hash = 't9zot2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Help command', false, 'It runs arbitrary commands on the server.' from questions q where q.legacy_hash = 't9zot2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe operation', false, 'It can give an attacker control of the host.' from questions q where q.legacy_hash = 't9zot2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal navigation', false, 'Traversal uses sequences like ''../'' to escape the allowed folder.' from questions q where q.legacy_hash = '1cwfjrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Accessing unauthorized directories', true, NULL from questions q where q.legacy_hash = '1cwfjrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'File system feature', false, 'Relative paths are a feature, but traversal abuses them to reach restricted files.' from questions q where q.legacy_hash = '1cwfjrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe browsing', false, 'It exposes files the application was never meant to serve.' from questions q where q.legacy_hash = '1cwfjrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal request', false, 'CSRF forges a request from the victim''s logged-in browser without their knowledge.' from questions q where q.legacy_hash = '151j9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unauthorized actions on behalf of user', true, NULL from questions q where q.legacy_hash = '151j9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe request', false, 'It performs unwanted actions, like changing an email or sending money.' from questions q where q.legacy_hash = '151j9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Good practice', false, 'Anti-CSRF tokens are the good practice. CSRF is the attack.' from questions q where q.legacy_hash = '151j9fr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Client attack', false, 'Unlike CSRF, SSRF makes the server itself send requests, often to internal systems.' from questions q where q.legacy_hash = '7rbtwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Making server send malicious requests', true, NULL from questions q where q.legacy_hash = '7rbtwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal operation', false, 'SSRF abuses a server feature that fetches URLs.' from questions q where q.legacy_hash = '7rbtwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe request', false, 'SSRF can reach internal services or cloud metadata endpoints.' from questions q where q.legacy_hash = '7rbtwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Running race', false, 'It''s a timing flaw where the order of operations can be exploited.' from questions q where q.legacy_hash = '1iy4wye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Timing-dependent vulnerability', true, NULL from questions q where q.legacy_hash = '1iy4wye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal operation', false, 'It''s a bug that attackers can exploit, such as TOCTOU.' from questions q where q.legacy_hash = '1iy4wye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe condition', false, 'Race conditions are vulnerabilities.' from questions q where q.legacy_hash = '1iy4wye'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Simple attack', false, 'APTs are advanced: skilled, well-funded and stealthy.' from questions q where q.legacy_hash = '1jedwbs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Advanced Persistent Threat', true, NULL from questions q where q.legacy_hash = '1jedwbs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Quick attack', false, 'Persistent means they stay in a network for a long time.' from questions q where q.legacy_hash = '1jedwbs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Basic threat', false, 'APTs are among the most sophisticated threat actors.' from questions q where q.legacy_hash = '1jedwbs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'File-based', false, 'Fileless malware avoids writing files and lives in memory and trusted tools.' from questions q where q.legacy_hash = '1nxcxkk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware running in memory', true, NULL from questions q where q.legacy_hash = '1nxcxkk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Regular malware', false, 'Traditional malware drops files. Fileless malware deliberately doesn''t.' from questions q where q.legacy_hash = '1nxcxkk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Stored malware', false, 'It isn''t stored on disk, which is what makes it hard to detect.' from questions q where q.legacy_hash = '1nxcxkk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical bomb', false, 'It''s code that activates when a condition is met, such as a certain date.' from questions q where q.legacy_hash = '13pyq76'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malicious code triggered by condition', true, NULL from questions q where q.legacy_hash = '13pyq76'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe code', false, 'It''s malicious code hidden inside legitimate software.' from questions q where q.legacy_hash = '13pyq76'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Normal program', false, 'It looks normal until its trigger condition is met.' from questions q where q.legacy_hash = '13pyq76'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Safe program', false, 'A trojan only looks safe; it hides malware.' from questions q where q.legacy_hash = '5ohjlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware disguised as legitimate', true, NULL from questions q where q.legacy_hash = '5ohjlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus', false, 'Antivirus detects trojans. Some trojans even pose as antivirus.' from questions q where q.legacy_hash = '5ohjlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall is a defensive control, not malware.' from questions q where q.legacy_hash = '5ohjlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'System tool', false, 'Rootkits often replace system tools to hide themselves, but they''re malware.' from questions q where q.legacy_hash = 'wsnelc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Malware hiding itself', true, NULL from questions q where q.legacy_hash = 'wsnelc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security software', false, 'Security software tries to find rootkits.' from questions q where q.legacy_hash = 'wsnelc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Rootkits are designed to evade antivirus.' from questions q where q.legacy_hash = 'wsnelc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Security tool', false, 'Spyware secretly collects user information without consent.' from questions q where q.legacy_hash = '1j79gnz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Software secretly monitoring user', true, NULL from questions q where q.legacy_hash = '1j79gnz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus', false, 'Antivirus removes spyware.' from questions q where q.legacy_hash = '1j79gnz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe program', false, 'Spyware is malicious because it monitors covertly.' from questions q where q.legacy_hash = '1j79gnz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Legitimate program', false, 'Some bots are legitimate, like chatbots, but here a bot is a compromised machine in a botnet.' from questions q where q.legacy_hash = 'nv6cfu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Compromised computer in botnet', true, NULL from questions q where q.legacy_hash = 'nv6cfu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus', false, 'Antivirus helps clean bots from infected machines.' from questions q where q.legacy_hash = 'nv6cfu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall can block bot traffic. The bot is the infected host.' from questions q where q.legacy_hash = 'nv6cfu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Animal', false, 'RAT stands for remote access trojan: malware that gives an attacker remote control.' from questions q where q.legacy_hash = 'nusxb0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Remote Access Trojan', true, NULL from questions q where q.legacy_hash = 'nusxb0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe tool', false, 'Legitimate remote tools exist, but a RAT is installed covertly.' from questions q where q.legacy_hash = 'nusxb0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus tries to detect RATs.' from questions q where q.legacy_hash = 'nusxb0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Clean ARP', false, 'Poisoning sends forged ARP replies so traffic flows through the attacker.' from questions q where q.legacy_hash = '1m95pl9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Corrupting ARP cache', true, NULL from questions q where q.legacy_hash = '1m95pl9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal ARP', false, 'Normal ARP maps IPs to MAC addresses. Poisoning falsifies that mapping.' from questions q where q.legacy_hash = '1m95pl9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe operation', false, 'It enables on-path interception on a local network.' from questions q where q.legacy_hash = '1m95pl9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal traffic', false, 'Flooding sends huge numbers of fake MAC addresses to overflow the switch''s table.' from questions q where q.legacy_hash = '5ho6k7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Overwhelming switch MAC table', true, NULL from questions q where q.legacy_hash = '5ho6k7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Slow traffic', false, 'The goal is to make the switch send traffic out every port, like a hub, so it can be sniffed.' from questions q where q.legacy_hash = '5ho6k7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe operation', false, 'It''s an attack. Port security helps prevent it.' from questions q where q.legacy_hash = '5ho6k7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Authorized AP', false, 'A rogue AP is one installed without authorization, often by an employee.' from questions q where q.legacy_hash = '1l0c9kj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unauthorized wireless AP', true, NULL from questions q where q.legacy_hash = '1l0c9kj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Secure AP', false, 'Rogue APs bypass network security controls.' from questions q where q.legacy_hash = '1l0c9kj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Company AP', false, 'Company-managed APs are authorized. Rogue ones aren''t.' from questions q where q.legacy_hash = '1l0c9kj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Good AP', false, 'An evil twin copies a legitimate network''s name to lure users.' from questions q where q.legacy_hash = 'bgqm9y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Fake AP mimicking legitimate', true, NULL from questions q where q.legacy_hash = 'bgqm9y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Secure AP', false, 'It''s an attacker-controlled AP used to intercept traffic.' from questions q where q.legacy_hash = 'bgqm9y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Authorized AP', false, 'The evil twin imitates the authorized AP.' from questions q where q.legacy_hash = 'bgqm9y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Secure method', false, 'WPS was meant to make setup easier, but its PIN method is weak and can be brute-forced.' from questions q where q.legacy_hash = '1mtp07a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploiting Wi-Fi Protected Setup', true, NULL from questions q where q.legacy_hash = '1mtp07a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe feature', false, 'The feature exists, but the attack exploits its weak PIN design.' from questions q where q.legacy_hash = '1mtp07a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Good practice', false, 'Good practice is to disable WPS.' from questions q where q.legacy_hash = '1mtp07a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Serious attack', false, 'Bluejacking is mostly a nuisance: unsolicited messages over Bluetooth. Data theft is bluesnarfing.' from questions q where q.legacy_hash = 'rx6gcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Sending unsolicited Bluetooth messages', true, NULL from questions q where q.legacy_hash = 'rx6gcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Wired attack', false, 'It uses Bluetooth, which is wireless.' from questions q where q.legacy_hash = 'rx6gcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe practice', false, 'It''s unsolicited contact, even if the harm is usually low.' from questions q where q.legacy_hash = 'rx6gcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Safe feature', false, 'Bluesnarfing steals data like contacts and messages over Bluetooth.' from questions q where q.legacy_hash = '11djlxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Stealing data via Bluetooth', true, NULL from questions q where q.legacy_hash = '11djlxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal operation', false, 'It exploits Bluetooth flaws to access data without authorization.' from questions q where q.legacy_hash = '11djlxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Authorized access', false, 'The access is unauthorized.' from questions q where q.legacy_hash = '11djlxw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal copy', false, 'Cloning copies a badge''s credential so an attacker can get in.' from questions q where q.legacy_hash = 'fo9qoz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Copying RFID credentials', true, NULL from questions q where q.legacy_hash = 'fo9qoz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Authorized backup', false, 'It''s unauthorized duplication.' from questions q where q.legacy_hash = 'fo9qoz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe practice', false, 'It defeats RFID-based access control.' from questions q where q.legacy_hash = 'fo9qoz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal use', false, 'The attack exploits NFC for skimming, relaying or intercepting data.' from questions q where q.legacy_hash = '1dtkbdv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exploiting near-field communication', true, NULL from questions q where q.legacy_hash = '1dtkbdv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe feature', false, 'NFC itself is a feature. The attack abuses it.' from questions q where q.legacy_hash = '1dtkbdv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Authorized access', false, 'The access is unauthorized.' from questions q where q.legacy_hash = '1dtkbdv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Music', false, 'Jamming floods radio frequencies with interference to block wireless communication.' from questions q where q.legacy_hash = '1oagxzr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Disrupting wireless signals', true, NULL from questions q where q.legacy_hash = '1oagxzr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Amplifying signals', false, 'It disrupts signals rather than boosting them.' from questions q where q.legacy_hash = '1oagxzr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Normal operation', false, 'It''s a deliberate denial-of-service against wireless networks.' from questions q where q.legacy_hash = '1oagxzr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Driving safely', false, 'Wardriving means moving around, often by car, to map Wi-Fi networks.' from questions q where q.legacy_hash = '19hv92p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Searching for Wi-Fi networks', true, NULL from questions q where q.legacy_hash = '19hv92p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Normal driving', false, 'The purpose is discovering wireless networks.' from questions q where q.legacy_hash = '19hv92p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'GPS navigation', false, 'GPS may tag the locations, but the goal is finding Wi-Fi networks.' from questions q where q.legacy_hash = '19hv92p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old vulnerability', false, 'An old, known flaw is usually patchable. A zero-day is unknown to the vendor.' from questions q where q.legacy_hash = 'yh6cne'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Unknown vulnerability', true, NULL from questions q where q.legacy_hash = 'yh6cne'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Patched vulnerability', false, 'Once patched, it''s no longer a zero-day.' from questions q where q.legacy_hash = 'yh6cne'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Safe code', false, 'A zero-day is a real, unpatched flaw.' from questions q where q.legacy_hash = 'yh6cne'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No information', false, 'Threat intelligence is evidence-based information about threats.' from questions q where q.legacy_hash = '11vx3jj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Information about threats', true, NULL from questions q where q.legacy_hash = '11vx3jj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Random data', false, 'It''s curated and analyzed, such as IoCs and actor profiles.' from questions q where q.legacy_hash = '11vx3jj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Guessing', false, 'It relies on evidence from feeds, research and observation.' from questions q where q.legacy_hash = '11vx3jj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Past event', false, 'Evidence of a past compromise is an indicator of compromise (IoC). IoAs show an attack in progress.' from questions q where q.legacy_hash = 'xf9kxq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Real-time attack evidence', true, NULL from questions q where q.legacy_hash = 'xf9kxq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No indication', false, 'An IoA is a sign that an attack is happening or about to.' from questions q where q.legacy_hash = 'xf9kxq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Historical data', false, 'Historical artifacts are IoCs. IoAs focus on current behavior.' from questions q where q.legacy_hash = 'xf9kxq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating vulnerabilities', false, 'Scanners find existing weaknesses; they don''t create them.' from questions q where q.legacy_hash = 'afrjuw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Tool finding vulnerabilities', true, NULL from questions q where q.legacy_hash = 'afrjuw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Exploit tool', false, 'Exploiting is penetration testing. A scanner identifies and reports weaknesses.' from questions q where q.legacy_hash = 'afrjuw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Malware', false, 'Scanners are legitimate security tools, such as Nessus.' from questions q where q.legacy_hash = 'afrjuw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal code', false, 'In the Cyber Kill Chain, weaponization pairs an exploit with a payload to deliver.' from questions q where q.legacy_hash = '19ptl0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Creating exploit payload', true, NULL from questions q where q.legacy_hash = '19ptl0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe development', false, 'It''s an attacker''s preparation step.' from questions q where q.legacy_hash = '19ptl0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security measure', false, 'It''s a phase of an attack, not a defense.' from questions q where q.legacy_hash = '19ptl0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Combining multiple networks into one', false, 'That''s the opposite. Segmentation splits a network so a breach in one part can''t spread freely.' from questions q where q.legacy_hash = 'ovv2zw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Dividing a network into smaller parts', true, NULL from questions q where q.legacy_hash = 'ovv2zw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting network traffic', false, 'Encryption protects data in transit. Segmentation limits which systems can reach each other.' from questions q where q.legacy_hash = 'ovv2zw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monitoring network activity', false, 'Monitoring observes traffic. Segmentation is an architectural design choice.' from questions q where q.legacy_hash = 'ovv2zw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A demilitarized zone that isolates public-facing services', true, NULL from questions q where q.legacy_hash = 'onkdyc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A data management zone for backups', false, 'DMZ stands for demilitarized zone: a buffer network for internet-facing services, not backups.' from questions q where q.legacy_hash = 'onkdyc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A domain management zone for Active Directory', false, 'Domain controllers belong deep inside the internal network, never in the DMZ.' from questions q where q.legacy_hash = 'onkdyc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A disaster management zone for recovery', false, 'Recovery uses DR sites. A DMZ isolates public services like web and mail servers.' from questions q where q.legacy_hash = 'onkdyc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To encrypt all data', false, 'Classification decides which data needs strong protection. Encrypting everything the same way isn''t the goal.' from questions q where q.legacy_hash = 's3crdq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To organize data based on sensitivity and importance', true, NULL from questions q where q.legacy_hash = 's3crdq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To backup data regularly', false, 'Backups support availability. Classification labels data by sensitivity.' from questions q where q.legacy_hash = 's3crdq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To delete old data', false, 'Retention and disposal are separate lifecycle steps, though classification may inform them.' from questions q where q.legacy_hash = 's3crdq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'All security is the cloud provider''s responsibility', false, 'Providers secure the cloud itself. Customers still secure their data, identities and configurations.' from questions q where q.legacy_hash = '102dhui'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'All security is the customer''s responsibility', false, 'The provider handles physical data centers and underlying infrastructure.' from questions q where q.legacy_hash = '102dhui'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Security responsibilities are divided between provider and customer', true, NULL from questions q where q.legacy_hash = '102dhui'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security is optional in cloud environments', false, 'Security is required in the cloud; the model just divides who does what.' from questions q where q.legacy_hash = '102dhui'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Virtual Private Network', true, NULL from questions q where q.legacy_hash = 'nuwco9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Very Public Network', false, 'VPN means virtual private network: an encrypted tunnel across a public network.' from questions q where q.legacy_hash = 'nuwco9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Variable Password Network', false, 'A VPN is about encrypted tunnels, not passwords.' from questions q where q.legacy_hash = 'nuwco9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Verified Personal Network', false, 'The P is private, and the V is virtual.' from questions q where q.legacy_hash = 'nuwco9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Large network segments', false, 'Microsegmentation is very fine-grained, often down to individual workloads.' from questions q where q.legacy_hash = '7c4fa4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Dividing networks into very small segments', true, NULL from questions q where q.legacy_hash = '7c4fa4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Removing segmentation', false, 'It adds more segmentation, not less.' from questions q where q.legacy_hash = '7c4fa4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Physical separation', false, 'It''s usually done in software, with policies per workload, not physical separation.' from questions q where q.legacy_hash = '7c4fa4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hardware-based networking', false, 'SDN moves control into software, separate from the hardware that forwards traffic.' from questions q where q.legacy_hash = 'ge8q8p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Centrally managed programmable networks', true, NULL from questions q where q.legacy_hash = 'ge8q8p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Manual network configuration', false, 'SDN is centrally programmed and automated, rather than configured box by box.' from questions q where q.legacy_hash = 'ge8q8p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Legacy networking', false, 'Legacy networks tie control to each device. SDN separates the control plane from the data plane.' from questions q where q.legacy_hash = 'ge8q8p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encrypting moving data', false, 'Data that''s moving is ''in transit'', protected by protocols like TLS. ''At rest'' means stored.' from questions q where q.legacy_hash = 'pbek6q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encrypting stored data', true, NULL from questions q where q.legacy_hash = 'pbek6q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No encryption', false, 'At rest describes where encryption is applied: to stored data.' from questions q where q.legacy_hash = 'pbek6q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Temporary encryption', false, 'It protects stored data for as long as it''s stored.' from questions q where q.legacy_hash = 'pbek6q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular server', false, 'A jump server is a hardened, tightly controlled gateway for admin access.' from questions q where q.legacy_hash = '1tm8rc8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Intermediary server for secure access', true, NULL from questions q where q.legacy_hash = '1tm8rc8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup server', false, 'Backups store copies of data. A jump server brokers access into a secure zone.' from questions q where q.legacy_hash = '1tm8rc8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Web server', false, 'Web servers serve content to users. A jump server is for administrators.' from questions q where q.legacy_hash = '1tm8rc8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual configuration', false, 'IaC replaces manual setup with version-controlled definition files.' from questions q where q.legacy_hash = '13hzns2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Managing infrastructure through code', true, NULL from questions q where q.legacy_hash = '13hzns2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical hardware', false, 'IaC describes infrastructure in code, even when it runs on hardware.' from questions q where q.legacy_hash = '13hzns2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Traditional setup', false, 'Traditional setup is hand-configured. IaC is automated and repeatable.' from questions q where q.legacy_hash = '13hzns2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Direct connection', false, 'A proxy sits in the middle, so the client doesn''t connect directly.' from questions q where q.legacy_hash = '1txzs7i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Intermediary between client and server', true, NULL from questions q where q.legacy_hash = '1txzs7i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall type', false, 'Some firewalls include proxy features, but a proxy is defined by making requests on a client''s behalf.' from questions q where q.legacy_hash = '1txzs7i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'A router forwards packets between networks. A proxy handles application requests for clients.' from questions q where q.legacy_hash = '1txzs7i'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Overloading servers', false, 'Load balancing prevents overload by spreading requests out.' from questions q where q.legacy_hash = 'k2oohf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Distributing traffic across servers', true, NULL from questions q where q.legacy_hash = 'k2oohf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Blocking traffic', false, 'It distributes traffic; it doesn''t filter it.' from questions q where q.legacy_hash = 'k2oohf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Routing errors', false, 'It''s a deliberate method for reliability, not a fault.' from questions q where q.legacy_hash = 'k2oohf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual security tool', false, 'Orchestration automates and connects tools. It replaces manual steps.' from questions q where q.legacy_hash = 'u5n5qv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Automated security workflow system', true, NULL from questions q where q.legacy_hash = 'u5n5qv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus software', false, 'Antivirus protects one endpoint. Orchestration coordinates many tools and playbooks.' from questions q where q.legacy_hash = 'u5n5qv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall is one control that an orchestration platform might trigger.' from questions q where q.legacy_hash = 'u5n5qv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Unrestricted access', false, 'NAC restricts access, checking device identity and health before letting it connect.' from questions q where q.legacy_hash = 'dk9jec'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Controlling network device access', true, NULL from questions q where q.legacy_hash = 'dk9jec'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Internet service', false, 'NAC is a control on your own network, not an ISP service.' from questions q where q.legacy_hash = 'dk9jec'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email filtering', false, 'Email filtering handles messages. NAC decides which devices may join the network.' from questions q where q.legacy_hash = 'dk9jec'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Production system', false, 'A honeypot is a decoy with no real business use, so any activity on it is suspicious.' from questions q where q.legacy_hash = '10p9mnf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Decoy system to attract attackers', true, NULL from questions q where q.legacy_hash = '10p9mnf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup server', false, 'A honeypot lures attackers; it doesn''t store backups.' from questions q where q.legacy_hash = '10p9mnf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Mail server', false, 'A honeypot might imitate a mail server, but its purpose is to attract and study attackers.' from questions q where q.legacy_hash = '10p9mnf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Internet traffic', false, 'Traffic entering or leaving the data center is north-south. East-west moves between internal servers.' from questions q where q.legacy_hash = '1x7it9s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Traffic between servers within data center', true, NULL from questions q where q.legacy_hash = '1x7it9s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'User traffic', false, 'Client-to-server traffic is usually north-south.' from questions q where q.legacy_hash = '1x7it9s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backup traffic', false, 'Backup jobs may be east-west, but the term covers all lateral traffic within the data center.' from questions q where q.legacy_hash = '1x7it9s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical LAN', false, 'A VLAN is virtual: it splits one physical network into logical segments.' from questions q where q.legacy_hash = '5zbn3a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Virtual Local Area Network', true, NULL from questions q where q.legacy_hash = '5zbn3a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Wide Area Network', false, 'A WAN spans large distances. A VLAN segments a local network.' from questions q where q.legacy_hash = '5zbn3a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Internet connection', false, 'A VLAN is internal segmentation, not internet access.' from questions q where q.legacy_hash = '5zbn3a'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encrypting addresses', false, 'NAT rewrites addresses; it doesn''t encrypt them.' from questions q where q.legacy_hash = '1y7u07'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Translating IP addresses', true, NULL from questions q where q.legacy_hash = '1y7u07'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating addresses', false, 'Assigning addresses is DHCP''s job. NAT translates existing ones.' from questions q where q.legacy_hash = '1y7u07'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting addresses', false, 'NAT maps private addresses to public ones rather than removing them.' from questions q where q.legacy_hash = '1y7u07'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using same key forever', false, 'PFS does the opposite: each session gets a fresh key, so one leaked key exposes only one session.' from questions q where q.legacy_hash = 'itzq5c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Generating unique session keys', true, NULL from questions q where q.legacy_hash = 'itzq5c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No encryption', false, 'PFS strengthens encryption by using ephemeral session keys.' from questions q where q.legacy_hash = 'itzq5c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Weak encryption', false, 'PFS improves security by limiting what a single stolen key can unlock.' from questions q where q.legacy_hash = 'itzq5c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical barrier', false, 'In building design a firewall stops fire. In networking it''s a device that filters traffic.' from questions q where q.legacy_hash = 'ja6q0b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network security device controlling traffic', true, NULL from questions q where q.legacy_hash = 'ja6q0b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Fire suppression system', false, 'Fire suppression is an environmental control. A network firewall filters traffic.' from questions q where q.legacy_hash = 'ja6q0b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backup device', false, 'Firewalls control traffic; they don''t store backups.' from questions q where q.legacy_hash = 'ja6q0b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No difference', false, 'They differ in keys: symmetric uses one shared key; asymmetric uses a public/private pair.' from questions q where q.legacy_hash = '1roamlf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Symmetric uses one key, asymmetric uses key pairs', true, NULL from questions q where q.legacy_hash = '1roamlf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Asymmetric is faster', false, 'It''s the reverse. Symmetric is much faster, which is why it encrypts bulk data.' from questions q where q.legacy_hash = '1roamlf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Symmetric is newer', false, 'Symmetric ciphers are much older. Public-key (asymmetric) cryptography came in the 1970s.' from questions q where q.legacy_hash = '1roamlf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical packaging', false, 'Containers here are software units that isolate an application and its dependencies.' from questions q where q.legacy_hash = 'q2bhwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Isolating applications in containers', true, NULL from questions q where q.legacy_hash = 'q2bhwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Data compression', false, 'Compression shrinks data. Containers isolate running applications.' from questions q where q.legacy_hash = 'q2bhwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'File archiving', false, 'Archives bundle files for storage. Containers run isolated workloads.' from questions q where q.legacy_hash = 'q2bhwk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Speed improvement', false, 'TLS adds a little overhead. Its purpose is secure communication.' from questions q where q.legacy_hash = 'gjpg40'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encrypted communication', true, NULL from questions q where q.legacy_hash = 'gjpg40'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'File storage', false, 'TLS protects data in transit, not stored files.' from questions q where q.legacy_hash = 'gjpg40'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Email filtering', false, 'TLS can encrypt mail in transit, but filtering is a different control.' from questions q where q.legacy_hash = 'gjpg40'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular server', false, 'A bastion host is specially hardened because it''s deliberately exposed to attack.' from questions q where q.legacy_hash = '1od8gyr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Hardened server exposed to internet', true, NULL from questions q where q.legacy_hash = '1od8gyr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup server', false, 'It''s a hardened, exposed gateway, not a storage system.' from questions q where q.legacy_hash = '1od8gyr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Database server', false, 'Databases belong inside the network. A bastion host faces the internet.' from questions q where q.legacy_hash = '1od8gyr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old encryption method', false, 'It''s cutting-edge, based on quantum physics.' from questions q where q.legacy_hash = '1k1dssr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encryption using quantum mechanics', true, NULL from questions q where q.legacy_hash = '1k1dssr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Slow encryption', false, 'Speed isn''t what defines it. It uses quantum mechanics, for example to detect eavesdropping.' from questions q where q.legacy_hash = '1k1dssr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Weak encryption', false, 'It aims for very strong, physics-based security.' from questions q where q.legacy_hash = '1k1dssr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Network speed', false, 'Speed is bandwidth or throughput. Topology is the layout, such as star or mesh.' from questions q where q.legacy_hash = '3mzk9n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Physical or logical network layout', true, NULL from questions q where q.legacy_hash = '3mzk9n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network color', false, 'Topology describes how nodes are connected.' from questions q where q.legacy_hash = '3mzk9n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Network cost', false, 'Cost is a budget question. Topology is the physical or logical arrangement.' from questions q where q.legacy_hash = '3mzk9n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Window opening', false, 'An air gap means a system has no network connection to other networks.' from questions q where q.legacy_hash = '1x3bk4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Physical isolation from networks', true, NULL from questions q where q.legacy_hash = '1x3bk4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network bridge', false, 'A bridge connects networks, the opposite of an air gap.' from questions q where q.legacy_hash = '1x3bk4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Wireless connection', false, 'Wireless is still a connection. Air-gapped systems have none.' from questions q where q.legacy_hash = '1x3bk4o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical hardware', false, 'NFV replaces dedicated appliances with software running on standard servers.' from questions q where q.legacy_hash = '1jvvu4p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Running network functions as software', true, NULL from questions q where q.legacy_hash = '1jvvu4p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Manual configuration', false, 'NFV is about virtualizing functions like firewalls and load balancers, not manual setup.' from questions q where q.legacy_hash = '1jvvu4p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Old technology', false, 'NFV is a modern approach that replaces hardware appliances.' from questions q where q.legacy_hash = '1jvvu4p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Security tool', false, 'Routers can filter with ACLs, but their main job is forwarding packets between networks.' from questions q where q.legacy_hash = 'w6c7ee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Device that forwards packets between networks', true, NULL from questions q where q.legacy_hash = 'w6c7ee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Storage device', false, 'Routers move data; they don''t store it.' from questions q where q.legacy_hash = 'w6c7ee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Display', false, 'A router is a network device, not a screen.' from questions q where q.legacy_hash = 'w6c7ee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical door locks', false, 'Here ''port'' means a switch port. Port security limits which devices can plug in.' from questions q where q.legacy_hash = '4avbht'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Restricting network port access', true, NULL from questions q where q.legacy_hash = '4avbht'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Airport security', false, 'It controls network switch ports, often by MAC address.' from questions q where q.legacy_hash = '4avbht'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Ship security', false, 'It''s about switch ports, not harbors.' from questions q where q.legacy_hash = '4avbht'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical chain', false, 'The ''chain'' is blocks linked by cryptographic hashes.' from questions q where q.legacy_hash = '1qmpox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Distributed immutable ledger', true, NULL from questions q where q.legacy_hash = '1qmpox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Database', false, 'It''s a distributed ledger that can''t be changed once written, unlike a normal editable database.' from questions q where q.legacy_hash = '1qmpox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Spreadsheet', false, 'A spreadsheet can be edited freely. Blockchain entries can''t be changed after the fact.' from questions q where q.legacy_hash = '1qmpox'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Light control', false, 'A network switch connects devices on a LAN and forwards frames by MAC address.' from questions q where q.legacy_hash = '1mh689z'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network device connecting devices', true, NULL from questions q where q.legacy_hash = '1mh689z'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router', false, 'Routers connect different networks at Layer 3. Switches connect devices within one network at Layer 2.' from questions q where q.legacy_hash = '1mh689z'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'A firewall filters traffic by rules. A switch forwards traffic between local devices.' from questions q where q.legacy_hash = '1mh689z'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical fence', false, 'Geofencing is a virtual boundary based on GPS or network location.' from questions q where q.legacy_hash = '1xna7jd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Location-based access control', true, NULL from questions q where q.legacy_hash = '1xna7jd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'Firewalls filter by rules. Geofencing triggers actions based on where a device is.' from questions q where q.legacy_hash = '1xna7jd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus scans for malware. Geofencing uses location.' from questions q where q.legacy_hash = '1xna7jd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encryption', false, 'Encryption scrambles data but it''s visibly encrypted. Steganography hides that a message exists at all.' from questions q where q.legacy_hash = 'e1dx0w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Hiding data within other files', true, NULL from questions q where q.legacy_hash = 'e1dx0w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Compression', false, 'Compression shrinks data. Steganography hides data inside other files, like images.' from questions q where q.legacy_hash = 'e1dx0w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deletion', false, 'Nothing is deleted. Data is hidden within a cover file.' from questions q where q.legacy_hash = 'e1dx0w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Weather prediction', false, '''Cloud'' means on-demand computing services delivered over the internet.' from questions q where q.legacy_hash = 'p6hzb5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Delivering computing services over internet', true, NULL from questions q where q.legacy_hash = 'p6hzb5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Local storage', false, 'Local storage is on-premises. The cloud is remote and provider-hosted.' from questions q where q.legacy_hash = 'p6hzb5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Physical servers', false, 'Cloud services run on physical servers, but you consume them as on-demand services.' from questions q where q.legacy_hash = 'p6hzb5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Software service', false, 'Software as a service is SaaS. IaaS provides virtual machines, storage and networks.' from questions q where q.legacy_hash = 'ah9hu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Infrastructure as a Service', true, NULL from questions q where q.legacy_hash = 'ah9hu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Internet service', false, 'The I is for infrastructure.' from questions q where q.legacy_hash = 'ah9hu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Information service', false, 'IaaS rents out compute infrastructure, not information.' from questions q where q.legacy_hash = 'ah9hu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No servers exist', false, 'Servers still exist; the provider manages them so you only deploy code.' from questions q where q.legacy_hash = '18vr794'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Cloud provider manages servers', true, NULL from questions q where q.legacy_hash = '18vr794'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Local servers', false, 'Serverless is a cloud model where the provider handles the servers.' from questions q where q.legacy_hash = '18vr794'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Physical servers', false, 'You never manage any servers, physical or virtual.' from questions q where q.legacy_hash = '18vr794'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Platform as a Service', true, NULL from questions q where q.legacy_hash = 'ff6xl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Personal application service', false, 'PaaS means platform as a service: a managed environment for building and running apps.' from questions q where q.legacy_hash = 'ff6xl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Private access service', false, 'The P is platform.' from questions q where q.legacy_hash = 'ff6xl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Public area service', false, 'PaaS provides a development and runtime platform.' from questions q where q.legacy_hash = 'ff6xl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Software as a Service', true, NULL from questions q where q.legacy_hash = 'hjg4c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security as service', false, 'Security as a service is sometimes called SECaaS. SaaS is software delivered over the internet.' from questions q where q.legacy_hash = 'hjg4c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Server as service', false, 'Renting servers is closer to IaaS.' from questions q where q.legacy_hash = 'hjg4c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Storage as service', false, 'Storage services are usually counted as IaaS. SaaS is complete applications, like email.' from questions q where q.legacy_hash = 'hjg4c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Central computing', false, 'Edge computing moves processing away from the center, closer to where data is created.' from questions q where q.legacy_hash = 'f0ia9r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Processing data near source', true, NULL from questions q where q.legacy_hash = 'f0ia9r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Cloud only', false, 'It complements the cloud by processing some data locally first.' from questions q where q.legacy_hash = 'f0ia9r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Server room', false, 'The edge is out near devices, not in a central server room.' from questions q where q.legacy_hash = 'f0ia9r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical cable', false, 'Cables carry signals. A protocol is the set of rules for communicating.' from questions q where q.legacy_hash = '1gxzank'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Rules for data communication', true, NULL from questions q where q.legacy_hash = '1gxzank'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Computer', false, 'Computers follow protocols; a protocol isn''t a device.' from questions q where q.legacy_hash = '1gxzank'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Software', false, 'Software implements protocols, but the protocol is the agreed set of rules.' from questions q where q.legacy_hash = '1gxzank'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Internet Protocol Security', true, NULL from questions q where q.legacy_hash = '99j960'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Image processing', false, 'IPSec means Internet Protocol Security: authentication and encryption for IP traffic.' from questions q where q.legacy_hash = '99j960'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Internal protocol', false, 'IPSec secures IP traffic, often across the internet for VPNs.' from questions q where q.legacy_hash = '99j960'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Identity protection', false, 'It protects packets, not identities.' from questions q where q.legacy_hash = '99j960'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old security', false, 'WPA3 is the newest Wi-Fi security standard, replacing WPA2.' from questions q where q.legacy_hash = 'jz99r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Latest Wi-Fi security protocol', true, NULL from questions q where q.legacy_hash = 'jz99r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Wired protection', false, 'WPA3 secures wireless networks.' from questions q where q.legacy_hash = 'jz99r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Web protocol', false, 'It''s a Wi-Fi standard, not a web protocol.' from questions q where q.legacy_hash = 'jz99r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Wired connection', false, 'Wi-Fi is wireless, using radio waves.' from questions q where q.legacy_hash = 'isk100'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Wireless network technology', true, NULL from questions q where q.legacy_hash = 'isk100'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical cable', false, 'No cable is needed for Wi-Fi.' from questions q where q.legacy_hash = 'isk100'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Fiber optic', false, 'Fiber is a wired medium using light.' from questions q where q.legacy_hash = 'isk100'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Network cable', false, '802.1X is an IEEE standard for port-based network access control.' from questions q where q.legacy_hash = '1rbcgw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Port-based access control', true, NULL from questions q where q.legacy_hash = '1rbcgw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router model', false, 'It''s a standard, often used with RADIUS, not a product.' from questions q where q.legacy_hash = '1rbcgw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall type', false, 'It authenticates devices before they can use a port, rather than filtering traffic.' from questions q where q.legacy_hash = '1rbcgw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Circle measurement', false, 'RADIUS is a protocol for centralized authentication, authorization and accounting.' from questions q where q.legacy_hash = '1prfkpo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Authentication protocol', true, NULL from questions q where q.legacy_hash = '1prfkpo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router', false, 'Routers may send authentication requests to a RADIUS server, but RADIUS is the protocol.' from questions q where q.legacy_hash = '1prfkpo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall', false, 'RADIUS handles authentication, not traffic filtering.' from questions q where q.legacy_hash = '1prfkpo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Domain Name System', true, NULL from questions q where q.legacy_hash = '197g93t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data network system', false, 'DNS stands for Domain Name System, which translates names into IP addresses.' from questions q where q.legacy_hash = '197g93t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Direct name service', false, 'The D is domain.' from questions q where q.legacy_hash = '197g93t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Digital network system', false, 'DNS is the internet''s naming system.' from questions q where q.legacy_hash = '197g93t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'DNS backup', false, 'DNSSEC adds digital signatures so DNS answers can be verified.' from questions q where q.legacy_hash = '1jkvwxg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'DNS security extensions', true, NULL from questions q where q.legacy_hash = '1jkvwxg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'DNS speed', false, 'DNSSEC adds authenticity checks, not speed.' from questions q where q.legacy_hash = '1jkvwxg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'DNS software', false, 'It''s a set of security extensions to DNS, not a program.' from questions q where q.legacy_hash = '1jkvwxg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular DNS', false, 'Regular DNS is sent in plaintext. DoH encrypts it inside HTTPS.' from questions q where q.legacy_hash = '1f8zbm0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encrypted DNS queries', true, NULL from questions q where q.legacy_hash = '1f8zbm0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Slow DNS', false, 'Its purpose is privacy through encryption, not speed.' from questions q where q.legacy_hash = '1f8zbm0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Local DNS', false, 'DoH usually sends queries to a remote resolver over HTTPS.' from questions q where q.legacy_hash = '1f8zbm0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'HTTP Secure', true, NULL from questions q where q.legacy_hash = '8p2e13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'High transfer protocol', false, 'HTTPS is HTTP Secure: HTTP over TLS.' from questions q where q.legacy_hash = '8p2e13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Home terminal', false, 'It''s a web protocol.' from questions q where q.legacy_hash = '8p2e13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Host transfer', false, 'The S stands for secure.' from questions q where q.legacy_hash = '8p2e13'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical pins', false, 'Pinning ties an app to a specific expected certificate or public key.' from questions q where q.legacy_hash = '1cqrcga'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Associating host with certificate', true, NULL from questions q where q.legacy_hash = '1cqrcga'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Unpinning certificate', false, 'Pinning is the security control. Attackers try to bypass it.' from questions q where q.legacy_hash = '1cqrcga'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No certificates', false, 'Pinning depends on certificates.' from questions q where q.legacy_hash = '1cqrcga'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'HTTP transfer', false, 'HSTS stands for HTTP Strict Transport Security: it forces browsers to use HTTPS.' from questions q where q.legacy_hash = '9grau'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'HTTP Strict Transport Security', true, NULL from questions q where q.legacy_hash = '9grau'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Host security', false, 'It''s a web security header, not general host security.' from questions q where q.legacy_hash = '9grau'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Home security', false, 'It''s a browser policy, set by a response header.' from questions q where q.legacy_hash = '9grau'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Advanced Encryption Standard', true, NULL from questions q where q.legacy_hash = '197dqct'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Application entry system', false, 'AES is the Advanced Encryption Standard, a symmetric block cipher.' from questions q where q.legacy_hash = '197dqct'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Automatic encryption', false, 'AES is a specific algorithm, not a feature.' from questions q where q.legacy_hash = '197dqct'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Access entry system', false, 'It''s an encryption standard, not an access system.' from questions q where q.legacy_hash = '197dqct'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Random security', false, 'RSA is named after its creators, Rivest, Shamir and Adleman. It''s an asymmetric algorithm.' from questions q where q.legacy_hash = '197r522'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Asymmetric encryption algorithm', true, NULL from questions q where q.legacy_hash = '197r522'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router security', false, 'RSA is a public-key algorithm, not a network device feature.' from questions q where q.legacy_hash = '197r522'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Storage algorithm', false, 'RSA encrypts and signs data; it doesn''t store it.' from questions q where q.legacy_hash = '197r522'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old method', false, 'ECC is newer than RSA and gives equal strength with smaller keys.' from questions q where q.legacy_hash = 'x0hhsr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Public key cryptography using curves', true, NULL from questions q where q.legacy_hash = 'x0hhsr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Simple encryption', false, 'ECC relies on hard elliptic-curve math.' from questions q where q.legacy_hash = 'x0hhsr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Weak security', false, 'ECC is strong and efficient, which suits mobile and IoT devices.' from questions q where q.legacy_hash = 'x0hhsr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Handwritten signature', false, 'A digital signature is cryptographic: a hash encrypted with the sender''s private key.' from questions q where q.legacy_hash = '1dpnqx1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Cryptographic signature', true, NULL from questions q where q.legacy_hash = '1dpnqx1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Photo', false, 'It''s cryptographic proof of origin and integrity, not an image.' from questions q where q.legacy_hash = '1dpnqx1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password', false, 'A password proves identity at login. A signature proves who sent a message and that it''s unchanged.' from questions q where q.legacy_hash = '1dpnqx1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Public Key Infrastructure', true, NULL from questions q where q.legacy_hash = '197pf2w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Private key internet', false, 'PKI stands for Public Key Infrastructure: CAs, certificates and key management.' from questions q where q.legacy_hash = '197pf2w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Password key information', false, 'PKI is certificate-based, not password-based.' from questions q where q.legacy_hash = '197pf2w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Personal key identity', false, 'PKI is an organization-wide trust system, not a personal identity.' from questions q where q.legacy_hash = '197pf2w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Government only', false, 'CAs can be commercial companies, like DigiCert, or internal to an organization.' from questions q where q.legacy_hash = 'm9tpmo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Trusted entity issuing certificates', true, NULL from questions q where q.legacy_hash = 'm9tpmo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Local authority', false, 'A CA is a trusted issuer of digital certificates, not a local government body.' from questions q where q.legacy_hash = 'm9tpmo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No authority', false, 'The CA is the trusted anchor of PKI.' from questions q where q.legacy_hash = 'm9tpmo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Fast boot', false, 'Secure boot checks signatures during startup. Fast boot just skips steps for speed.' from questions q where q.legacy_hash = '1wmoymn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Verified boot process', true, NULL from questions q where q.legacy_hash = '1wmoymn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Slow boot', false, 'It''s about verification, not speed.' from questions q where q.legacy_hash = '1wmoymn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No boot', false, 'It still boots, but only software that is signed and trusted.' from questions q where q.legacy_hash = '1wmoymn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Trusted Platform Module', true, NULL from questions q where q.legacy_hash = '197smat'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Total protection method', false, 'TPM stands for Trusted Platform Module, a chip on the motherboard.' from questions q where q.legacy_hash = '197smat'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Technical process management', false, 'TPM is hardware that stores keys and supports secure boot.' from questions q where q.legacy_hash = '197smat'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Transfer protocol module', false, 'It isn''t a protocol. It''s a cryptographic hardware chip.' from questions q where q.legacy_hash = '197smat'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hardware Security Module', true, NULL from questions q where q.legacy_hash = '197jg2k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'High speed memory', false, 'HSM stands for Hardware Security Module, which protects and manages keys.' from questions q where q.legacy_hash = '197jg2k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Host security management', false, 'An HSM is a dedicated cryptographic device, not a management process.' from questions q where q.legacy_hash = '197jg2k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Home security monitor', false, 'HSMs are enterprise devices for key management.' from questions q where q.legacy_hash = '197jg2k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Partial encryption', false, 'FDE encrypts the entire drive, not just part of it.' from questions q where q.legacy_hash = 'yw7bgd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encrypting entire disk', true, NULL from questions q where q.legacy_hash = 'yw7bgd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'File encryption only', false, 'File-level encryption protects individual files. FDE covers everything on the disk.' from questions q where q.legacy_hash = 'yw7bgd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No encryption', false, 'FDE is a strong form of encryption at rest.' from questions q where q.legacy_hash = 'yw7bgd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Disk encryption', false, 'Disk encryption covers the whole drive. File encryption targets individual files.' from questions q where q.legacy_hash = '1p3tj27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Encrypting individual files', true, NULL from questions q where q.legacy_hash = '1p3tj27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network encryption', false, 'Network encryption protects data in transit.' from questions q where q.legacy_hash = '1p3tj27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No encryption', false, 'It encrypts selected files.' from questions q where q.legacy_hash = '1p3tj27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Normal encryption', false, 'Normal encryption must be decrypted before you can compute on the data. Homomorphic encryption doesn''t.' from questions q where q.legacy_hash = '1nol0is'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Computing on encrypted data', true, NULL from questions q where q.legacy_hash = '1nol0is'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Weak encryption', false, 'Its distinguishing feature is computing on data while it stays encrypted.' from questions q where q.legacy_hash = '1nol0is'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No encryption', false, 'The data stays encrypted the whole time.' from questions q where q.legacy_hash = '1nol0is'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Main network', false, 'A subnet is a smaller piece of a larger network.' from questions q where q.legacy_hash = '1l1i4bq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network subdivision', true, NULL from questions q where q.legacy_hash = '1l1i4bq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Internet', false, 'The internet is a global network of networks. A subnet is a local subdivision.' from questions q where q.legacy_hash = '1l1i4bq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'Routers connect subnets; they aren''t subnets.' from questions q where q.legacy_hash = '1l1i4bq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old protocol', false, 'IPv6 is the newer version, with 128-bit addresses.' from questions q where q.legacy_hash = 'a4n09'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Latest IP version', true, NULL from questions q where q.legacy_hash = 'a4n09'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'IPv4 backup', false, 'IPv6 is a successor, not a backup, though they often run side by side.' from questions q where q.legacy_hash = 'a4n09'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Local network', false, 'IPv6 is an internet protocol used everywhere, not just locally.' from questions q where q.legacy_hash = 'a4n09'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Border Gateway Protocol', true, NULL from questions q where q.legacy_hash = '197ejot'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Basic gateway process', false, 'BGP stands for Border Gateway Protocol, which routes traffic between autonomous systems.' from questions q where q.legacy_hash = '197ejot'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup general protocol', false, 'BGP is the internet''s routing protocol.' from questions q where q.legacy_hash = '197ejot'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Bridge group protocol', false, 'BGP operates between networks, not within a bridge.' from questions q where q.legacy_hash = '197ejot'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Apple computer', false, 'Here MAC means Media Access Control, a network card''s hardware address.' from questions q where q.legacy_hash = 'sa4v4b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Media Access Control address', true, NULL from questions q where q.legacy_hash = 'sa4v4b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Main access code', false, 'It''s a Layer 2 hardware identifier, not a code you enter.' from questions q where q.legacy_hash = 'sa4v4b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Master authentication code', false, 'A MAC address identifies an interface; it doesn''t authenticate anyone. (A message authentication code is different.)' from questions q where q.legacy_hash = 'sa4v4b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Address Resolution Protocol', true, NULL from questions q where q.legacy_hash = '197e17b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Automatic routing protocol', false, 'ARP is the Address Resolution Protocol, which maps IP addresses to MAC addresses.' from questions q where q.legacy_hash = '197e17b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Access route process', false, 'ARP resolves addresses on a local network.' from questions q where q.legacy_hash = '197e17b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Application retrieval protocol', false, 'ARP works at the network layers, not with applications.' from questions q where q.legacy_hash = '197e17b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Virtual Extensible LAN', true, NULL from questions q where q.legacy_hash = 'htwul9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Very external LAN', false, 'VXLAN stands for Virtual Extensible LAN, which carries Layer 2 networks over Layer 3.' from questions q where q.legacy_hash = 'htwul9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Visual extension LAN', false, 'The V is virtual.' from questions q where q.legacy_hash = 'htwul9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Verified extra LAN', false, 'It''s a network virtualization technology, not a verification feature.' from questions q where q.legacy_hash = 'htwul9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Network cable width', false, 'Bandwidth is capacity: how much data a link can carry per second.' from questions q where q.legacy_hash = '13k61ih'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data transmission capacity', true, NULL from questions q where q.legacy_hash = '13k61ih'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router size', false, 'Bandwidth describes a link''s capacity, not a device''s size.' from questions q where q.legacy_hash = '13k61ih'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Switch speed', false, 'A switch port has a speed, but bandwidth is the link''s data capacity.' from questions q where q.legacy_hash = '13k61ih'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Quality of Service', true, NULL from questions q where q.legacy_hash = '197r1bb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Quick operation system', false, 'QoS means Quality of Service: prioritizing important traffic.' from questions q where q.legacy_hash = '197r1bb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Queue order service', false, 'QoS uses queues, but the name means Quality of Service.' from questions q where q.legacy_hash = '197r1bb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Quota of storage', false, 'QoS manages network traffic, not storage.' from questions q where q.legacy_hash = '197r1bb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Multi-Protocol Label Switching', true, NULL from questions q where q.legacy_hash = 'cxcpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Main protocol layer system', false, 'MPLS stands for Multi-Protocol Label Switching, which forwards traffic using labels.' from questions q where q.legacy_hash = 'cxcpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Manual process label service', false, 'MPLS is an automated forwarding technique.' from questions q where q.legacy_hash = 'cxcpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Multiple path load service', false, 'MPLS may use several paths, but it''s defined by label switching.' from questions q where q.legacy_hash = 'cxcpc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single point', false, 'Redundancy removes single points of failure.' from questions q where q.legacy_hash = 'blz4w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Backup systems', true, NULL from questions q where q.legacy_hash = 'blz4w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No backup', false, 'Redundancy means having duplicate components ready.' from questions q where q.legacy_hash = 'blz4w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'One system', false, 'It requires more than one system or component.' from questions q where q.legacy_hash = 'blz4w1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Sometimes working', false, 'High availability aims for near-constant uptime, like 99.999%.' from questions q where q.legacy_hash = 'lwfk0f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Minimizing downtime', true, NULL from questions q where q.legacy_hash = 'lwfk0f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Always broken', false, 'HA is designed to keep services running.' from questions q where q.legacy_hash = 'lwfk0f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No service', false, 'HA maximizes service uptime.' from questions q where q.legacy_hash = 'lwfk0f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'One active', false, 'One active node with a standby is active-passive.' from questions q where q.legacy_hash = '12pgvtd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'All systems active simultaneously', true, NULL from questions q where q.legacy_hash = '12pgvtd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'All standby', false, 'In active-active, every node handles traffic.' from questions q where q.legacy_hash = '12pgvtd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No redundancy', false, 'Active-active is a redundant design.' from questions q where q.legacy_hash = '12pgvtd'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'All active', false, 'All nodes working at once is active-active.' from questions q where q.legacy_hash = 'j4zvv4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Primary active, backup standby', true, NULL from questions q where q.legacy_hash = 'j4zvv4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'All standby', false, 'One node is active; the other waits to take over.' from questions q where q.legacy_hash = 'j4zvv4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No backup', false, 'The passive node is the backup.' from questions q where q.legacy_hash = 'j4zvv4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical boxes', false, 'Containers package software, not goods.' from questions q where q.legacy_hash = '1f9anjp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Lightweight virtualization', true, NULL from questions q where q.legacy_hash = '1f9anjp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Full VM', false, 'A VM includes a full guest OS. Containers share the host''s kernel, which makes them lighter.' from questions q where q.legacy_hash = '1f9anjp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No isolation', false, 'Containers do isolate applications, though less strongly than VMs.' from questions q where q.legacy_hash = '1f9anjp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Monolithic app', false, 'A monolith is one large codebase. Microservices split an app into small independent services.' from questions q where q.legacy_hash = '1905wol'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Application as independent services', true, NULL from questions q where q.legacy_hash = '1905wol'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Single service', false, 'Microservices are many small services working together.' from questions q where q.legacy_hash = '1905wol'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No architecture', false, 'It''s a specific architectural style.' from questions q where q.legacy_hash = '1905wol'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular gateway', false, 'An API gateway is specialized: it handles API authentication, rate limiting and routing.' from questions q where q.legacy_hash = '1k48jz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Entry point for APIs', true, NULL from questions q where q.legacy_hash = '1k48jz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'It can enforce API security, but its main role is being the single entry point for APIs.' from questions q where q.legacy_hash = '1k48jz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'A router forwards packets. An API gateway routes API calls to backend services.' from questions q where q.legacy_hash = '1k48jz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'SOAP only', false, 'SOAP is a different, XML-based web service style. REST uses standard HTTP methods.' from questions q where q.legacy_hash = 'czbnik'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Web service using HTTP', true, NULL from questions q where q.legacy_hash = 'czbnik'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Database', false, 'A REST API may front a database, but it''s a web service interface.' from questions q where q.legacy_hash = 'czbnik'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Programming language', false, 'REST is an architectural style usable from any language.' from questions q where q.legacy_hash = 'czbnik'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical network', false, 'A service mesh is a software layer, often sidecar proxies, between microservices.' from questions q where q.legacy_hash = '1tbf6fm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Infrastructure layer for microservices', true, NULL from questions q where q.legacy_hash = '1tbf6fm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Single service', false, 'It manages communication between many services.' from questions q where q.legacy_hash = '1tbf6fm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No networking', false, 'It is entirely about service-to-service networking.' from questions q where q.legacy_hash = '1tbf6fm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual configuration', false, 'IaC replaces manual setup with code.' from questions q where q.legacy_hash = 'q2acg4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Managing infrastructure via code', true, NULL from questions q where q.legacy_hash = 'q2acg4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical only', false, 'IaC defines infrastructure in files, whether it runs on cloud or on-premises hardware.' from questions q where q.legacy_hash = 'q2acg4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No automation', false, 'Automation is the main benefit of IaC.' from questions q where q.legacy_hash = 'q2acg4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Development only', false, 'DevOps joins development with operations.' from questions q where q.legacy_hash = '4c10l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Combining development and operations', true, NULL from questions q where q.legacy_hash = '4c10l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Operations only', false, 'It combines operations with development.' from questions q where q.legacy_hash = '4c10l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No collaboration', false, 'Collaboration between the two teams is the core of DevOps.' from questions q where q.legacy_hash = '4c10l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No security', false, 'The ''Sec'' means security is built into DevOps.' from questions q where q.legacy_hash = 'mn15s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Integrating security into DevOps', true, NULL from questions q where q.legacy_hash = 'mn15s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Development only', false, 'It spans development, security and operations.' from questions q where q.legacy_hash = 'mn15s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security later', false, 'DevSecOps ''shifts security left'', to the start of development.' from questions q where q.legacy_hash = 'mn15s'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual deployment', false, 'CI/CD automates building, testing and deploying code.' from questions q where q.legacy_hash = '57zxqu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Continuous integration and deployment', true, NULL from questions q where q.legacy_hash = '57zxqu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No automation', false, 'Automation is the heart of CI/CD pipelines.' from questions q where q.legacy_hash = '57zxqu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random releases', false, 'CI/CD releases are frequent, automated and repeatable.' from questions q where q.legacy_hash = '57zxqu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No tracking', false, 'Version control tracks every change, like Git does.' from questions q where q.legacy_hash = '17nbsu3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Tracking code changes', true, NULL from questions q where q.legacy_hash = '17nbsu3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting code', false, 'It preserves history, so old versions can be restored.' from questions q where q.legacy_hash = '17nbsu3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random changes', false, 'Changes are recorded, reviewed and attributed.' from questions q where q.legacy_hash = '17nbsu3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Changing systems', false, 'Immutable systems aren''t changed after deployment; they''re replaced with new builds.' from questions q where q.legacy_hash = '15lv8ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Never modifying deployed systems', true, NULL from questions q where q.legacy_hash = '15lv8ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Regular updates', false, 'Updates happen by deploying a fresh image, not by patching in place.' from questions q where q.legacy_hash = '15lv8ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Constant changes', false, 'Immutability prevents configuration drift by never modifying running systems.' from questions q where q.legacy_hash = '15lv8ad'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Photo', false, 'A snapshot captures a system''s state at a moment in time.' from questions q where q.legacy_hash = '119p6hw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Point-in-time system copy', true, NULL from questions q where q.legacy_hash = '119p6hw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Live system', false, 'It''s a saved copy of the system at one point, not the running system.' from questions q where q.legacy_hash = '119p6hw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No backup', false, 'Snapshots are a quick form of backup and recovery point.' from questions q where q.legacy_hash = '119p6hw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Simple tool', false, 'A SIEM gathers and correlates logs from across the whole environment.' from questions q where q.legacy_hash = 'h0axu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security Information and Event Management', true, NULL from questions q where q.legacy_hash = 'h0axu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall', false, 'A firewall is one log source that feeds a SIEM.' from questions q where q.legacy_hash = 'h0axu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Antivirus', false, 'Antivirus protects endpoints. A SIEM analyzes events from many sources.' from questions q where q.legacy_hash = 'h0axu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Flying', false, 'SOAR means Security Orchestration, Automation and Response.' from questions q where q.legacy_hash = 'h4u2x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security Orchestration Automation Response', true, NULL from questions q where q.legacy_hash = 'h4u2x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Manual only', false, 'SOAR automates response playbooks.' from questions q where q.legacy_hash = 'h4u2x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No automation', false, 'Automation is the A in SOAR.' from questions q where q.legacy_hash = 'h4u2x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'National code', false, 'NAC stands for Network Access Control.' from questions q where q.legacy_hash = '197nn2e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network Access Control', true, NULL from questions q where q.legacy_hash = '197nn2e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No control', false, 'NAC enforces who and what may connect.' from questions q where q.legacy_hash = '197nn2e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Cable type', false, 'NAC is a security control, not cabling.' from questions q where q.legacy_hash = '197nn2e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Military zone', false, 'The term is borrowed from the military, but in networking it''s a buffer segment for public services.' from questions q where q.legacy_hash = '197g8fz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Demilitarized Zone network segment', true, NULL from questions q where q.legacy_hash = '197g8fz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Safe zone', false, 'The DMZ is semi-trusted: more exposed than the internal network.' from questions q where q.legacy_hash = '197g8fz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Internal network', false, 'The DMZ is deliberately separated from the internal network.' from questions q where q.legacy_hash = '197g8fz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No firewall', false, 'A screened subnet sits between firewalls.' from questions q where q.legacy_hash = '1knh8b2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'DMZ between two firewalls', true, NULL from questions q where q.legacy_hash = '1knh8b2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Single firewall', false, 'The classic design uses two firewalls, one on each side of the DMZ.' from questions q where q.legacy_hash = '1knh8b2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No security', false, 'It''s a layered security design.' from questions q where q.legacy_hash = '1knh8b2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Exercise equipment', false, 'A jump server is a hardened host that admins go through to reach secure systems.' from questions q where q.legacy_hash = '18qu3gn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Secure access point to network', true, NULL from questions q where q.legacy_hash = '18qu3gn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Router', false, 'A router forwards packets. A jump server brokers admin sessions.' from questions q where q.legacy_hash = '18qu3gn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Switch', false, 'A switch connects local devices. A jump server controls privileged access.' from questions q where q.legacy_hash = '18qu3gn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Direct connection', false, 'A proxy sits between client and server, so the connection isn''t direct.' from questions q where q.legacy_hash = 'gfke19'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Intermediary server', true, NULL from questions q where q.legacy_hash = 'gfke19'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'End device', false, 'A proxy is an intermediary, not an endpoint.' from questions q where q.legacy_hash = 'gfke19'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'Routers forward packets. Proxies make requests on behalf of clients.' from questions q where q.legacy_hash = 'gfke19'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Forward proxy', false, 'A forward proxy represents clients. A reverse proxy sits in front of servers.' from questions q where q.legacy_hash = 'xtp1xu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Protects backend servers', true, NULL from questions q where q.legacy_hash = 'xtp1xu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Client proxy', false, 'A client-side proxy is a forward proxy. A reverse proxy protects the backend.' from questions q where q.legacy_hash = 'xtp1xu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No proxy', false, 'A reverse proxy is a proxy, facing the server side.' from questions q where q.legacy_hash = 'xtp1xu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular firewall', false, 'A regular firewall filters by IP and port. A WAF inspects HTTP traffic for attacks like SQL injection.' from questions q where q.legacy_hash = '197ukpe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Web Application Firewall', true, NULL from questions q where q.legacy_hash = '197ukpe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network firewall', false, 'Network firewalls work at Layers 3 and 4. A WAF works at Layer 7 for web apps.' from questions q where q.legacy_hash = '197ukpe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No protection', false, 'A WAF protects web applications.' from questions q where q.legacy_hash = '197ukpe'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Old firewall', false, 'NGFWs are the modern generation, with application awareness.' from questions q where q.legacy_hash = '1fngq1c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Advanced firewall with deep inspection', true, NULL from questions q where q.legacy_hash = '1fngq1c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Basic firewall', false, 'Basic firewalls filter by port. NGFWs add deep inspection, IPS and app control.' from questions q where q.legacy_hash = '1fngq1c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No firewall', false, 'An NGFW is a firewall with extra capabilities.' from questions q where q.legacy_hash = '1fngq1c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Single threat', false, 'UTM covers many threats with many functions in one device.' from questions q where q.legacy_hash = '10j5p9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Multiple security functions in one', true, NULL from questions q where q.legacy_hash = '10j5p9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No management', false, 'UTM centralizes management of several security functions.' from questions q where q.legacy_hash = '10j5p9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Separate tools', false, 'Separate tools are what UTM consolidates into one appliance.' from questions q where q.legacy_hash = '10j5p9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Data creation', false, 'DLP means Data Loss Prevention: stopping sensitive data from leaving.' from questions q where q.legacy_hash = '197g7ck'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data Loss Prevention', true, NULL from questions q where q.legacy_hash = '197g7ck'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Data deletion', false, 'DLP prevents data from leaking out, not deletion.' from questions q where q.legacy_hash = '197g7ck'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No protection', false, 'DLP is a protective control.' from questions q where q.legacy_hash = '197g7ck'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Server only', false, 'Endpoints include laptops, phones and workstations, not only servers.' from questions q where q.legacy_hash = '17od631'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Protecting end-user devices', true, NULL from questions q where q.legacy_hash = '17od631'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network only', false, 'Network security protects the network. Endpoint security protects the devices.' from questions q where q.legacy_hash = '17od631'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No protection', false, 'It''s protection for user devices.' from questions q where q.legacy_hash = '17od631'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Endpoint Data Recovery', false, 'The DR stands for detection and response: monitoring endpoints and reacting to threats.' from questions q where q.legacy_hash = '197gsen'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Endpoint Detection and Response', true, NULL from questions q where q.legacy_hash = '197gsen'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Email delivery', false, 'EDR runs on endpoints, not mail systems.' from questions q where q.legacy_hash = '197gsen'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No detection', false, 'Detection is the D in EDR.' from questions q where q.legacy_hash = '197gsen'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Master data', false, 'Master data management is a data practice. MDM here is Mobile Device Management.' from questions q where q.legacy_hash = '197my42'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Mobile Device Management', true, NULL from questions q where q.legacy_hash = '197my42'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Memory device', false, 'MDM is software for managing and securing mobile devices.' from questions q where q.legacy_hash = '197my42'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No management', false, 'MDM is all about managing devices.' from questions q where q.legacy_hash = '197my42'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Company devices only', false, 'BYOD means employees bring their own devices.' from questions q where q.legacy_hash = '5cqpu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Bring Your Own Device', true, NULL from questions q where q.legacy_hash = '5cqpu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No personal devices', false, 'BYOD specifically allows personal devices.' from questions q where q.legacy_hash = '5cqpu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Banned devices', false, 'BYOD allows personal devices under a policy.' from questions q where q.legacy_hash = '5cqpu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'BYOD', false, 'With BYOD the employee owns the device. With COPE the company does.' from questions q where q.legacy_hash = '5uhcr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Corporate Owned Personally Enabled', true, NULL from questions q where q.legacy_hash = '5uhcr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Personal only', false, 'COPE devices are corporate-owned, with personal use allowed.' from questions q where q.legacy_hash = '5uhcr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No devices', false, 'COPE is a device ownership model.' from questions q where q.legacy_hash = '5uhcr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'No choice', false, 'CYOD gives employees a choice from an approved list.' from questions q where q.legacy_hash = '625s3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Choose Your Own Device', true, NULL from questions q where q.legacy_hash = '625s3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Company decides', false, 'The company sets the list, but the employee picks the device.' from questions q where q.legacy_hash = '625s3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random device', false, 'The choice is limited to approved devices.' from questions q where q.legacy_hash = '625s3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical desktop', false, 'VDI desktops run as virtual machines on central servers.' from questions q where q.legacy_hash = '197tvkn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Virtual Desktop Infrastructure', true, NULL from questions q where q.legacy_hash = '197tvkn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Video display', false, 'VDI means Virtual Desktop Infrastructure.' from questions q where q.legacy_hash = '197tvkn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No desktops', false, 'VDI delivers desktops remotely.' from questions q where q.legacy_hash = '197tvkn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hardware networking', false, 'SDN moves network control into software.' from questions q where q.legacy_hash = 'yv1vc3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Network control via software', true, NULL from questions q where q.legacy_hash = 'yv1vc3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Physical only', false, 'SDN separates control from the physical devices that forward traffic.' from questions q where q.legacy_hash = 'yv1vc3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No software', false, 'Software is the defining feature of SDN.' from questions q where q.legacy_hash = 'yv1vc3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Physical perimeter', false, 'An SDP is a logical boundary based on identity, not a physical one.' from questions q where q.legacy_hash = '1wughs8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identity-based network boundary', true, NULL from questions q where q.legacy_hash = '1wughs8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Traditional firewall', false, 'Traditional firewalls protect a network edge. An SDP hides resources until the user is verified.' from questions q where q.legacy_hash = '1wughs8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No boundary', false, 'An SDP creates a dynamic, per-user boundary.' from questions q where q.legacy_hash = '1wughs8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using multiple passwords', false, 'Two passwords are both something you know, so that''s still one factor type. MFA needs different types.' from questions q where q.legacy_hash = 'b7xf68'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Requiring two or more authentication factors', true, NULL from questions q where q.legacy_hash = 'b7xf68'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Logging in multiple times', false, 'Repeated logins add nothing. MFA combines different kinds of proof in a single login.' from questions q where q.legacy_hash = 'b7xf68'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Using different usernames', false, 'Usernames only identify you. MFA is about adding different authentication factors.' from questions q where q.legacy_hash = 'b7xf68'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Internet Data Service', false, 'IDS stands for Intrusion Detection System, which watches for suspicious activity.' from questions q where q.legacy_hash = 'yk37pg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Intrusion Detection System', true, NULL from questions q where q.legacy_hash = 'yk37pg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Internal Defense System', false, 'The I and D are intrusion and detection.' from questions q where q.legacy_hash = 'yk37pg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Identity Directory Service', false, 'Directory services like LDAP store identities. An IDS detects intrusions.' from questions q where q.legacy_hash = 'yk37pg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'IDS detects threats, IPS prevents them', true, NULL from questions q where q.legacy_hash = '16u9xvt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'IDS prevents threats, IPS detects them', false, 'That''s reversed. An IDS detects and alerts; an IPS sits inline and blocks.' from questions q where q.legacy_hash = '16u9xvt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'There is no difference', false, 'The key difference is action: an IPS can block traffic, an IDS only alerts.' from questions q where q.legacy_hash = '16u9xvt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'IDS is for internal networks, IPS is for external', false, 'Either can be deployed anywhere. They differ in detecting versus preventing.' from questions q where q.legacy_hash = '16u9xvt'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Security Operations and Response', false, 'Close, but it leaves out orchestration and automation, which are SOAR''s core.' from questions q where q.legacy_hash = '1sfb798'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security Orchestration, Automation, and Response', true, NULL from questions q where q.legacy_hash = '1sfb798'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'System Operations and Recovery', false, 'SOAR is about security response automation, not system recovery.' from questions q where q.legacy_hash = '1sfb798'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Secure Online Access Resource', false, 'SOAR isn''t an access resource. It automates security workflows.' from questions q where q.legacy_hash = '1sfb798'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Breaking software', false, 'Patches fix software, though testing is needed so updates don''t break anything.' from questions q where q.legacy_hash = 'alw83l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Updating software to fix vulnerabilities', true, NULL from questions q where q.legacy_hash = 'alw83l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Deleting software', false, 'Patching updates software; it doesn''t remove it.' from questions q where q.legacy_hash = 'alw83l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Installing malware', false, 'Patch management closes the holes malware exploits.' from questions q where q.legacy_hash = 'alw83l'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Firewall', false, 'A firewall is one of many log sources that feed a SIEM.' from questions q where q.legacy_hash = 'gat1ig'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security Information and Event Management', true, NULL from questions q where q.legacy_hash = 'gat1ig'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Antivirus', false, 'Antivirus protects endpoints. A SIEM correlates events from across the environment.' from questions q where q.legacy_hash = 'gat1ig'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Router', false, 'A router forwards traffic and can send logs to a SIEM.' from questions q where q.legacy_hash = 'gat1ig'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Waiting for alerts', false, 'Waiting for alerts is reactive. Threat hunting is proactive: searching before anything alerts.' from questions q where q.legacy_hash = '8qlwl5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Proactively searching for threats', true, NULL from questions q where q.legacy_hash = '8qlwl5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring threats', false, 'Hunting actively searches for threats.' from questions q where q.legacy_hash = '8qlwl5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Automatic detection', false, 'Automated tools raise alerts. Hunters look for what those tools missed.' from questions q where q.legacy_hash = '8qlwl5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Technical training only', false, 'Awareness training is for all staff, covering things like phishing and password habits.' from questions q where q.legacy_hash = 'kihqq9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Educating users about security', true, NULL from questions q where q.legacy_hash = 'kihqq9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring users', false, 'It focuses on users, who are often the first target.' from questions q where q.legacy_hash = 'kihqq9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Complex coding', false, 'It''s about recognizing threats, not programming.' from questions q where q.legacy_hash = 'kihqq9'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Deleting logs', false, 'Aggregation collects logs; retention policies decide deletion.' from questions q where q.legacy_hash = '4ej98e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Collecting logs from multiple sources', true, NULL from questions q where q.legacy_hash = '4ej98e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring logs', false, 'Aggregating logs makes them easier to analyze.' from questions q where q.legacy_hash = '4ej98e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating logs', false, 'Systems create logs. Aggregation gathers them in one place.' from questions q where q.legacy_hash = '4ej98e'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'User surveys', false, 'It analyzes activity data automatically, not survey answers.' from questions q where q.legacy_hash = 't1l4ah'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Analyzing patterns to detect anomalies', true, NULL from questions q where q.legacy_hash = 't1l4ah'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Personality tests', false, 'It builds a baseline of normal activity and flags deviations.' from questions q where q.legacy_hash = 't1l4ah'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random checks', false, 'It continuously compares behavior against a baseline.' from questions q where q.legacy_hash = 't1l4ah'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Opening accounts', false, 'Lockout disables an account after repeated failed logins.' from questions q where q.legacy_hash = '1dihq2q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Disabling accounts after failed logins', true, NULL from questions q where q.legacy_hash = '1dihq2q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating accounts', false, 'Creating accounts is provisioning. Lockout blocks brute-force attempts.' from questions q where q.legacy_hash = '1dihq2q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Sharing accounts', false, 'Lockout protects accounts; sharing them weakens security.' from questions q where q.legacy_hash = '1dihq2q'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Regular user access', false, 'PAM focuses on elevated accounts like administrators and service accounts.' from questions q where q.legacy_hash = '4e3lrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Managing elevated access rights', true, NULL from questions q where q.legacy_hash = '4e3lrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Public access', false, 'PAM tightly controls high-risk access.' from questions q where q.legacy_hash = '4e3lrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No access control', false, 'PAM is a strict access control, with password vaulting and session monitoring.' from questions q where q.legacy_hash = '4e3lrx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual processes', false, 'Orchestration connects tools so workflows run automatically.' from questions q where q.legacy_hash = 'ixsg4x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Automating security workflows', true, NULL from questions q where q.legacy_hash = 'ixsg4x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring security', false, 'It makes security operations faster and more consistent.' from questions q where q.legacy_hash = 'ixsg4x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random actions', false, 'Orchestration follows defined playbooks.' from questions q where q.legacy_hash = 'ixsg4x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating vulnerabilities', false, 'Scanning finds existing weaknesses; it doesn''t create them.' from questions q where q.legacy_hash = '1obw01b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identifying security weaknesses', true, NULL from questions q where q.legacy_hash = '1obw01b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Exploiting systems', false, 'Exploitation is penetration testing. Scanning identifies and reports.' from questions q where q.legacy_hash = '1obw01b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Installing malware', false, 'Scanners are legitimate security tools.' from questions q where q.legacy_hash = '1obw01b'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Checking once yearly', false, 'A yearly check is a point-in-time audit. Continuous monitoring is ongoing.' from questions q where q.legacy_hash = '1nbvl69'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Ongoing real-time security monitoring', true, NULL from questions q where q.legacy_hash = '1nbvl69'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No monitoring', false, 'It''s constant monitoring.' from questions q where q.legacy_hash = '1nbvl69'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random checks', false, 'Spot checks leave gaps. Continuous monitoring doesn''t stop.' from questions q where q.legacy_hash = '1nbvl69'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Shopping list', false, 'An audit log records system and user activity.' from questions q where q.legacy_hash = 'o7cplo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Record of system activities', true, NULL from questions q where q.legacy_hash = 'o7cplo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Phone book', false, 'It records events, not contacts.' from questions q where q.legacy_hash = 'o7cplo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Calendar', false, 'Log entries are timestamped, but a log records activity, not appointments.' from questions q where q.legacy_hash = 'o7cplo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Breaking systems intentionally', false, 'Pen tests are authorized and scoped to find weaknesses, not to cause damage.' from questions q where q.legacy_hash = '1tzwrgb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Authorized simulated attacks', true, NULL from questions q where q.legacy_hash = '1tzwrgb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Installing software', false, 'Testers may use tools, but the goal is to simulate attacks.' from questions q where q.legacy_hash = '1tzwrgb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating users', false, 'Pen testing assesses security; it isn''t account administration.' from questions q where q.legacy_hash = '1tzwrgb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Using purple color', false, 'Purple mixes red (attack) and blue (defense): the two teams working together.' from questions q where q.legacy_hash = 'mrz1v5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Collaboration between red and blue teams', true, NULL from questions q where q.legacy_hash = 'mrz1v5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Single team', false, 'It brings two teams together.' from questions q where q.legacy_hash = 'mrz1v5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No teamwork', false, 'Collaboration is the whole point.' from questions q where q.legacy_hash = 'mrz1v5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Speed up computer', false, 'Antivirus uses resources; its job is catching malware.' from questions q where q.legacy_hash = 'viozd4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Detect and remove malware', true, NULL from questions q where q.legacy_hash = 'viozd4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Create backups', false, 'Backup software makes copies. Antivirus detects and removes malware.' from questions q where q.legacy_hash = 'viozd4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Browse internet', false, 'Browsers do that. Antivirus protects against malicious code.' from questions q where q.legacy_hash = 'viozd4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Manual processes', false, 'Automation replaces repetitive manual steps.' from questions q where q.legacy_hash = '6ckdnx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Using technology to perform security tasks', true, NULL from questions q where q.legacy_hash = '6ckdnx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring security', false, 'Automation speeds up security work.' from questions q where q.legacy_hash = '6ckdnx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random actions', false, 'Automated tasks follow defined rules and playbooks.' from questions q where q.legacy_hash = '6ckdnx'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Keeping threats secret', false, 'Sharing helps everyone defend faster, for example through ISACs.' from questions q where q.legacy_hash = 'jr2gcb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exchanging threat information between organizations', true, NULL from questions q where q.legacy_hash = 'jr2gcb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating threats', false, 'It''s about sharing information on existing threats.' from questions q where q.legacy_hash = 'jr2gcb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Ignoring threats', false, 'Sharing is an active defense practice.' from questions q where q.legacy_hash = 'jr2gcb'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Email filtering', false, 'Email filtering happens at the mail gateway. EDR runs on the endpoints.' from questions q where q.legacy_hash = '130q8le'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Monitoring and responding to endpoint threats', true, NULL from questions q where q.legacy_hash = '130q8le'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Network router', false, 'Routers forward traffic. EDR monitors activity on devices.' from questions q where q.legacy_hash = '130q8le'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Backup system', false, 'Backups support recovery. EDR detects and responds to threats.' from questions q where q.legacy_hash = '130q8le'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Lying to users', false, 'It deceives attackers, using decoys like honeypots, not users.' from questions q where q.legacy_hash = 'awjzvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Using decoys to detect attackers', true, NULL from questions q where q.legacy_hash = 'awjzvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Hiding systems', false, 'Hiding is obscurity. Deception adds fake targets that trigger alerts.' from questions q where q.legacy_hash = 'awjzvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Fake security', false, 'The decoys are fake, but the detection they provide is real.' from questions q where q.legacy_hash = 'awjzvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring settings', false, 'It tracks and controls settings.' from questions q where q.legacy_hash = 'nzu2q1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Maintaining consistent system configurations', true, NULL from questions q where q.legacy_hash = 'nzu2q1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Random changes', false, 'Changes are planned and documented against a baseline.' from questions q where q.legacy_hash = 'nzu2q1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Breaking systems', false, 'It keeps systems stable and consistent.' from questions q where q.legacy_hash = 'nzu2q1'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Minimum standard configuration', true, NULL from questions q where q.legacy_hash = '1mlh2r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Random settings', false, 'A baseline is a defined, approved standard.' from questions q where q.legacy_hash = '1mlh2r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Maximum settings', false, 'It''s the minimum secure standard every system must meet.' from questions q where q.legacy_hash = '1mlh2r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No configuration', false, 'The baseline is a specific configuration.' from questions q where q.legacy_hash = '1mlh2r3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Fashion modeling', false, 'It''s a structured analysis of how a system could be attacked, as with STRIDE.' from questions q where q.legacy_hash = '1aj5q7f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identifying and prioritizing threats', true, NULL from questions q where q.legacy_hash = '1aj5q7f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring threats', false, 'It identifies and prioritizes threats.' from questions q where q.legacy_hash = '1aj5q7f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Creating threats', false, 'It anticipates threats; it doesn''t create them.' from questions q where q.legacy_hash = '1aj5q7f'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Legal regulation', false, 'A firewall rule is a technical entry saying which traffic to allow or deny.' from questions q where q.legacy_hash = '1a3wfer'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Configuration defining traffic handling', true, NULL from questions q where q.legacy_hash = '1a3wfer'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Fire code', false, 'It''s about network traffic, not fire safety.' from questions q where q.legacy_hash = '1a3wfer'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Building code', false, 'It''s a network policy entry, like an ACL line.' from questions q where q.legacy_hash = '1a3wfer'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Shopping list', false, 'An asset inventory lists what the organization owns and must protect.' from questions q where q.legacy_hash = 'mwsiw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'List of organizational assets', true, NULL from questions q where q.legacy_hash = 'mwsiw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Price list', false, 'Value may be recorded, but the inventory tracks assets, owners and locations.' from questions q where q.legacy_hash = 'mwsiw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Phone book', false, 'It lists hardware, software and data assets.' from questions q where q.legacy_hash = 'mwsiw2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring data', false, 'Analytics digs into data to find threats.' from questions q where q.legacy_hash = 'm9h0j8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Analyzing security data for insights', true, NULL from questions q where q.legacy_hash = 'm9h0j8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating reports', false, 'Reports may result, but analytics is the analysis that finds patterns.' from questions q where q.legacy_hash = 'm9h0j8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting logs', false, 'Analytics depends on keeping logs.' from questions q where q.legacy_hash = 'm9h0j8'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Deleting users', false, 'Removing access is deprovisioning.' from questions q where q.legacy_hash = 'eu1j2y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Creating and configuring user accounts', true, NULL from questions q where q.legacy_hash = 'eu1j2y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Locking accounts', false, 'Lockout is a separate control against failed logins.' from questions q where q.legacy_hash = 'eu1j2y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Sharing passwords', false, 'Provisioning creates individual accounts; sharing passwords breaks accountability.' from questions q where q.legacy_hash = 'eu1j2y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Paper certificates', false, 'It manages digital certificates: issuing, renewing and revoking them.' from questions q where q.legacy_hash = '14hk438'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Managing digital certificates lifecycle', true, NULL from questions q where q.legacy_hash = '14hk438'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Printing documents', false, 'It''s about the digital certificate lifecycle.' from questions q where q.legacy_hash = '14hk438'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Filing papers', false, 'It tracks digital certificates so none expire unexpectedly.' from questions q where q.legacy_hash = '14hk438'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Age of security', false, 'Maturity describes how capable a program is, not how old it is.' from questions q where q.legacy_hash = '1lowebg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Framework for measuring security progress', true, NULL from questions q where q.legacy_hash = '1lowebg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Old security', false, 'It measures progress through defined levels.' from questions q where q.legacy_hash = '1lowebg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'New security', false, 'It assesses where a program stands and how to improve it.' from questions q where q.legacy_hash = '1lowebg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring backups', false, 'Testing proves backups can actually be restored.' from questions q where q.legacy_hash = 'd1vcq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Verifying backups work correctly', true, NULL from questions q where q.legacy_hash = 'd1vcq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating backups', false, 'Creating backups comes first. Testing checks that they work.' from questions q where q.legacy_hash = 'd1vcq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Deleting backups', false, 'Testing verifies backups; it doesn''t remove them.' from questions q where q.legacy_hash = 'd1vcq0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Keeping secrets', false, 'It means exchanging threat data with trusted partners.' from questions q where q.legacy_hash = '1dbyce'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Exchanging threat data', true, NULL from questions q where q.legacy_hash = '1dbyce'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No sharing', false, 'Sharing is the whole practice.' from questions q where q.legacy_hash = '1dbyce'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Private only', false, 'It''s shared, often through industry groups like ISACs.' from questions q where q.legacy_hash = '1dbyce'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Creating vulnerabilities', false, 'An assessment finds weaknesses; it doesn''t add them.' from questions q where q.legacy_hash = 'l80jus'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identifying security weaknesses', true, NULL from questions q where q.legacy_hash = 'l80jus'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring weaknesses', false, 'It exists to find and rank weaknesses.' from questions q where q.legacy_hash = 'l80jus'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'No assessment', false, 'It''s a systematic evaluation.' from questions q where q.legacy_hash = 'l80jus'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring security', false, 'Monitoring watches continuously for threats.' from questions q where q.legacy_hash = 'ey6kgi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Watching for security events', true, NULL from questions q where q.legacy_hash = 'ey6kgi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'No oversight', false, 'Monitoring is ongoing oversight.' from questions q where q.legacy_hash = 'ey6kgi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Random checks', false, 'It''s continuous, not random spot checks.' from questions q where q.legacy_hash = 'ey6kgi'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Eliminate all risks', false, 'Zero risk is impossible, or too expensive to be practical. The aim is to bring risk down to an acceptable level.' from questions q where q.legacy_hash = '103gvtz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identify and reduce risks to acceptable levels', true, NULL from questions q where q.legacy_hash = '103gvtz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Remove all vulnerabilities', false, 'Not every vulnerability can or should be fixed. Risk management prioritizes by likelihood and impact.' from questions q where q.legacy_hash = '103gvtz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Perform daily security audits', false, 'Audits are one activity. Risk management is the overall process of identifying and treating risk.' from questions q where q.legacy_hash = '103gvtz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring security controls', false, 'Compliance means meeting required controls, not ignoring them.' from questions q where q.legacy_hash = '6p377n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Following required laws and standards', true, NULL from questions q where q.legacy_hash = '6p377n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Creating new vulnerabilities', false, 'Compliance aims to reduce risk.' from questions q where q.legacy_hash = '6p377n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monitoring social media', false, 'Monitoring may be one control, but compliance means following laws and standards.' from questions q where q.legacy_hash = '6p377n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A firewall rule', false, 'A firewall rule is a technical setting. A policy is the high-level document the rule should reflect.' from questions q where q.legacy_hash = '45001p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A formal document defining rules and expectations', true, NULL from questions q where q.legacy_hash = '45001p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A network diagram', false, 'A diagram documents the architecture. A policy sets rules and expectations.' from questions q where q.legacy_hash = '45001p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A software patch', false, 'A patch fixes code. A policy governs behavior and requirements.' from questions q where q.legacy_hash = '45001p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Primary Internal Information', false, 'PII stands for Personally Identifiable Information.' from questions q where q.legacy_hash = '1gwei1y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Personally Identifiable Information', true, NULL from questions q where q.legacy_hash = '1gwei1y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Protected Infrastructure Index', false, 'PII is about people''s data, not infrastructure.' from questions q where q.legacy_hash = '1gwei1y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Public Internet Identifier', false, 'PII can be private and sensitive; the I''s stand for identifiable information.' from questions q where q.legacy_hash = '1gwei1y'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It prevents phishing attacks', false, 'Phishing prevention comes from training and filtering. A BCP keeps the business running through a disruption.' from questions q where q.legacy_hash = 'soxspw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It ensures critical operations continue during disruptions', true, NULL from questions q where q.legacy_hash = 'soxspw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It monitors emails', false, 'A BCP is a plan, not a monitoring tool.' from questions q where q.legacy_hash = 'soxspw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It encrypts data', false, 'Encryption is a technical control. A BCP covers continuing operations.' from questions q where q.legacy_hash = 'soxspw'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Bring Your Own Device', true, NULL from questions q where q.legacy_hash = '1m0nvzm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Backup Your Operational Data', false, 'BYOD stands for Bring Your Own Device.' from questions q where q.legacy_hash = '1m0nvzm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Build Your Onsite Datacenter', false, 'BYOD is about personal devices used for work.' from questions q where q.legacy_hash = '1m0nvzm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Block Your Online Downloads', false, 'BYOD is a device ownership policy, not download control.' from questions q where q.legacy_hash = '1m0nvzm'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It teaches hacking', false, 'It teaches staff to recognize and avoid threats, not to attack.' from questions q where q.legacy_hash = '1hydgcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It helps users recognize security threats', true, NULL from questions q where q.legacy_hash = '1hydgcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It replaces antivirus software', false, 'Training complements technical controls; it can''t replace them.' from questions q where q.legacy_hash = '1hydgcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It increases server speed', false, 'It changes human behavior, not system performance.' from questions q where q.legacy_hash = '1hydgcz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Interns', false, 'Strategic security decisions need executive authority and accountability.' from questions q where q.legacy_hash = '11timio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security analysts', false, 'Analysts advise and carry out the work, but leadership owns strategic decisions and risk acceptance.' from questions q where q.legacy_hash = '11timio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Executive leadership', true, NULL from questions q where q.legacy_hash = '11timio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Janitorial staff', false, 'Governance decisions belong to executive leadership.' from questions q where q.legacy_hash = '11timio'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Storing data for required periods', true, NULL from questions q where q.legacy_hash = '1td5j6u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Deleting data immediately', false, 'Retention means keeping data for a required period before disposal.' from questions q where q.legacy_hash = '1td5j6u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Encrypting all data', false, 'Encryption protects data. Retention decides how long it''s kept.' from questions q where q.legacy_hash = '1td5j6u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Copying data to USB drives', false, 'That''s a data-handling risk, not a retention policy.' from questions q where q.legacy_hash = '1td5j6u'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It fixes vulnerabilities', false, 'Documentation guides people. Patches and configuration changes fix vulnerabilities.' from questions q where q.legacy_hash = '17754pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It provides guidance and consistency', true, NULL from questions q where q.legacy_hash = '17754pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It speeds up Wi-Fi', false, 'Documentation doesn''t change network performance.' from questions q where q.legacy_hash = '17754pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It blocks malware', false, 'Technical controls block malware. Documentation makes practices consistent.' from questions q where q.legacy_hash = '17754pc'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Employee dress code', false, 'An AUP covers how company IT resources may be used, not clothing.' from questions q where q.legacy_hash = 'f5egxh'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'How employees may use company assets', true, NULL from questions q where q.legacy_hash = 'f5egxh'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'How to configure servers', false, 'Server settings belong in baselines and procedures. The AUP is for users.' from questions q where q.legacy_hash = 'f5egxh'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'How to schedule vacations', false, 'That''s HR policy, not acceptable use.' from questions q where q.legacy_hash = 'f5egxh'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It increases Wi-Fi bandwidth', false, 'Physical security protects facilities and hardware, not network speed.' from questions q where q.legacy_hash = '2rxtyj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It prevents unauthorized physical access', true, NULL from questions q where q.legacy_hash = '2rxtyj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It replaces encryption', false, 'It works alongside technical controls like encryption, not instead of them.' from questions q where q.legacy_hash = '2rxtyj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It prevents phishing', false, 'Phishing is countered with training and filtering. Physical security stops people walking in.' from questions q where q.legacy_hash = '2rxtyj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A planned change', false, 'Planned changes go through change management. Incidents are unplanned and harmful.' from questions q where q.legacy_hash = '1r4mwvp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'An unauthorized event impacting security', true, NULL from questions q where q.legacy_hash = '1r4mwvp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A software update', false, 'Routine updates are expected events, not incidents.' from questions q where q.legacy_hash = '1r4mwvp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A user request', false, 'User requests are service tickets, not security incidents.' from questions q where q.legacy_hash = '1r4mwvp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Detection', false, 'Detection is second. You have to prepare tools, plans and people first.' from questions q where q.legacy_hash = '1hm844x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Eradication', false, 'Eradication comes after detection and containment.' from questions q where q.legacy_hash = '1hm844x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Preparation', true, NULL from questions q where q.legacy_hash = '1hm844x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Recovery', false, 'Recovery is near the end, after eradication.' from questions q where q.legacy_hash = '1hm844x'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Servers', false, 'Servers can be hardened and patched. People are harder to secure and are often targeted first.' from questions q where q.legacy_hash = '1j9qp6o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Firewalls', false, 'Firewalls enforce rules consistently. Human error causes more breaches.' from questions q where q.legacy_hash = '1j9qp6o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Users', true, NULL from questions q where q.legacy_hash = '1j9qp6o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Routers', false, 'Routers are managed devices. Users are the most common entry point, as with phishing.' from questions q where q.legacy_hash = '1j9qp6o'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To shut down old systems', false, 'Decommissioning is an operational task. Audits check compliance and control effectiveness.' from questions q where q.legacy_hash = 'qvfky'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To verify compliance and measure control effectiveness', true, NULL from questions q where q.legacy_hash = 'qvfky'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To install new firewalls', false, 'Audits may recommend changes, but they evaluate controls rather than install them.' from questions q where q.legacy_hash = 'qvfky'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To encrypt data', false, 'Audits check that controls like encryption are in place; they don''t apply them.' from questions q where q.legacy_hash = 'qvfky'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Movie reviews', false, 'Reviews are public opinion, not protected by data regulations.' from questions q where q.legacy_hash = 'nk4z2p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Personal health information (PHI)', true, NULL from questions q where q.legacy_hash = 'nk4z2p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Sports scores', false, 'Public information like scores isn''t regulated data.' from questions q where q.legacy_hash = 'nk4z2p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Public announcements', false, 'Announcements are meant to be public.' from questions q where q.legacy_hash = 'nk4z2p'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'They make systems faster', false, 'Backups can add load. Their value is recovery.' from questions q where q.legacy_hash = '12v0a0r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'They allow recovery from data loss or corruption', true, NULL from questions q where q.legacy_hash = '12v0a0r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'They prevent all malware infections', false, 'Backups don''t stop infections; they help you recover afterwards.' from questions q where q.legacy_hash = '12v0a0r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'They monitor networks', false, 'Monitoring tools do that. Backups preserve copies of data.' from questions q where q.legacy_hash = '12v0a0r'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Travel Policy', false, 'Travel policies cover business travel, not data protection.' from questions q where q.legacy_hash = 'a7kt34'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data Handling Policy', true, NULL from questions q where q.legacy_hash = 'a7kt34'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Holiday Schedule', false, 'That''s a calendar, not a data-handling rule.' from questions q where q.legacy_hash = 'a7kt34'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Financial Report', false, 'It reports finances; it doesn''t set data protection rules.' from questions q where q.legacy_hash = 'a7kt34'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A maximum security level', false, 'A baseline is the minimum required configuration.' from questions q where q.legacy_hash = 'gooxow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A minimum acceptable security configuration', true, NULL from questions q where q.legacy_hash = 'gooxow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'An optional suggestion', false, 'Baselines are mandatory standards.' from questions q where q.legacy_hash = 'gooxow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A backup tool', false, 'A baseline is a configuration standard, not software.' from questions q where q.legacy_hash = 'gooxow'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Doctors', false, 'Medical risk is a different field. IT risk is assessed by security professionals.' from questions q where q.legacy_hash = '8fp9aa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Security professionals', true, NULL from questions q where q.legacy_hash = '8fp9aa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Sales staff', false, 'Sales may be interviewed, but trained security staff run the assessment.' from questions q where q.legacy_hash = '8fp9aa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Interns', false, 'Assessments need trained, experienced professionals.' from questions q where q.legacy_hash = '8fp9aa'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Updating systems randomly', false, 'Change management makes changes planned, reviewed and approved.' from questions q where q.legacy_hash = 'pb85w7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Documenting and approving system changes', true, NULL from questions q where q.legacy_hash = 'pb85w7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Monitoring CPU usage', false, 'That''s performance monitoring.' from questions q where q.legacy_hash = 'pb85w7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Resetting passwords', false, 'Resetting passwords is routine support work, not change management.' from questions q where q.legacy_hash = 'pb85w7'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A law or standard was not followed', true, NULL from questions q where q.legacy_hash = '1vgzczp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A firewall is misconfigured', false, 'A misconfiguration may lead to a violation, but a violation means failing a required law or standard.' from questions q where q.legacy_hash = '1vgzczp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A user forgot a password', false, 'Forgetting a password is a support issue.' from questions q where q.legacy_hash = '1vgzczp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A server rebooted', false, 'A reboot is an operational event.' from questions q where q.legacy_hash = '1vgzczp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Marketing Team', false, 'Marketing may help with public messaging, but response is led by the IR team.' from questions q where q.legacy_hash = 'ewx4j5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Incident Response Team', true, NULL from questions q where q.legacy_hash = 'ewx4j5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Sales Team', false, 'Sales isn''t responsible for incident handling.' from questions q where q.legacy_hash = 'ewx4j5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Facilities', false, 'Facilities may help with physical issues, but the IR team handles cyber incidents.' from questions q where q.legacy_hash = 'ewx4j5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To determine data size', false, 'Size is storage. Classification is about sensitivity.' from questions q where q.legacy_hash = 'mezrin'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To determine proper security protections', true, NULL from questions q where q.legacy_hash = 'mezrin'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To decide employee pay', false, 'Pay is an HR matter.' from questions q where q.legacy_hash = 'mezrin'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To improve battery life', false, 'Classification decides how data must be protected.' from questions q where q.legacy_hash = 'mezrin'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A required uniform or dress code', false, 'A security standard sets technical or procedural requirements, like a benchmark.' from questions q where q.legacy_hash = 'c8jbcu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A recommended best practice or benchmark', true, NULL from questions q where q.legacy_hash = 'c8jbcu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A firewall vendor', false, 'Vendors make products. Standards define how controls should be implemented.' from questions q where q.legacy_hash = 'c8jbcu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A user privilege list', false, 'Privilege lists are access records, not standards.' from questions q where q.legacy_hash = 'c8jbcu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To hide company profits', false, 'Privacy protects personal information, not business finances.' from questions q where q.legacy_hash = 'j2wzqj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To protect personal and sensitive information', true, NULL from questions q where q.legacy_hash = 'j2wzqj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To block internet traffic', false, 'Blocking traffic is a network control.' from questions q where q.legacy_hash = 'j2wzqj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To restrict social media', false, 'Social media rules are an acceptable-use matter, not the goal of privacy.' from questions q where q.legacy_hash = 'j2wzqj'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A control that fixes issues after they occur', true, NULL from questions q where q.legacy_hash = 'i4i0a4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A control that prevents issues', false, 'Stopping issues before they happen is what preventive controls do.' from questions q where q.legacy_hash = 'i4i0a4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A control that detects issues', false, 'Spotting issues is what detective controls do.' from questions q where q.legacy_hash = 'i4i0a4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A control that encrypts traffic', false, 'Encryption is usually preventive. Corrective controls fix things after an incident.' from questions q where q.legacy_hash = 'i4i0a4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Assigning job titles', false, 'Titles are HR''s job. Security onboarding sets up the right access and training.' from questions q where q.legacy_hash = '7yqh7j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Granting appropriate access for new employees', true, NULL from questions q where q.legacy_hash = '7yqh7j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Scheduling vacations', false, 'That''s HR scheduling.' from questions q where q.legacy_hash = '7yqh7j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Blocking websites', false, 'Web filtering is a technical control, not onboarding.' from questions q where q.legacy_hash = '7yqh7j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Higher salaries', false, 'Offboarding is about removing access when someone leaves.' from questions q where q.legacy_hash = '1sp9xni'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'That departing employees lose access', true, NULL from questions q where q.legacy_hash = '1sp9xni'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'That employees receive bonuses', false, 'Bonuses are payroll matters.' from questions q where q.legacy_hash = '1sp9xni'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'That systems reboot properly', false, 'Offboarding revokes accounts and collects equipment.' from questions q where q.legacy_hash = '1sp9xni'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'An informal review', false, 'An audit is formal and structured, often by an independent party.' from questions q where q.legacy_hash = 'e7g5ac'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A formal evaluation of controls and compliance', true, NULL from questions q where q.legacy_hash = 'e7g5ac'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A malware scan', false, 'A scan is a technical check. An audit evaluates controls and compliance.' from questions q where q.legacy_hash = 'e7g5ac'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A network speed test', false, 'Speed tests measure performance.' from questions q where q.legacy_hash = 'e7g5ac'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Tracking employee attendance', false, 'Attendance is HR data. A risk register tracks risks.' from questions q where q.legacy_hash = '19yt4iz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Documenting identified risks and mitigation plans', true, NULL from questions q where q.legacy_hash = '19yt4iz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Managing software licenses', false, 'That''s license or asset management.' from questions q where q.legacy_hash = '19yt4iz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Listing hardware devices', false, 'That''s an asset inventory. The register lists risks, owners and responses.' from questions q where q.legacy_hash = '19yt4iz'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Ignoring risk', false, 'Due diligence is the effort to understand and prevent risk.' from questions q where q.legacy_hash = '13e9vee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Taking reasonable steps to prevent issues', true, NULL from questions q where q.legacy_hash = '13e9vee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Installing antivirus software', false, 'Installing a control is due care. Due diligence is the research and planning behind it.' from questions q where q.legacy_hash = '13e9vee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Performing daily vulnerability scans', false, 'Scanning is one activity. Due diligence is the reasonable effort to investigate and prevent risk.' from questions q where q.legacy_hash = '13e9vee'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Detect malware', false, 'Malware detection is antivirus or EDR. DLP stops sensitive data from leaving.' from questions q where q.legacy_hash = '1dy4ong'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Prevent unauthorized data disclosure', true, NULL from questions q where q.legacy_hash = '1dy4ong'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Increase Wi-Fi speed', false, 'DLP inspects data flows; it doesn''t improve performance.' from questions q where q.legacy_hash = '1dy4ong'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monitor CPU usage', false, 'That''s system monitoring.' from questions q where q.legacy_hash = '1dy4ong'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To compare prices', false, 'Price is procurement. Vendor risk management checks a supplier''s security.' from questions q where q.legacy_hash = '1wsd4wq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To evaluate third-party security posture', true, NULL from questions q where q.legacy_hash = '1wsd4wq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To schedule vendor meetings', false, 'Meetings are logistics.' from questions q where q.legacy_hash = '1wsd4wq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To reduce payroll costs', false, 'Payroll is unrelated. The concern is third-party risk.' from questions q where q.legacy_hash = '1wsd4wq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Numerical values', false, 'Numbers describe quantitative analysis.' from questions q where q.legacy_hash = 'znclo6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Subjective scoring and categories', true, NULL from questions q where q.legacy_hash = 'znclo6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Financial loss only', false, 'Dollar figures are quantitative. Qualitative uses ratings like high, medium and low.' from questions q where q.legacy_hash = 'znclo6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Legal requirements', false, 'Laws can influence risk decisions, but qualitative analysis is based on subjective ratings.' from questions q where q.legacy_hash = 'znclo6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Security Log Agreement', false, 'SLA stands for Service Level Agreement: uptime and response commitments.' from questions q where q.legacy_hash = '1jernlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Service Level Agreement defining performance expectations', true, NULL from questions q where q.legacy_hash = '1jernlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Software License Agreement', false, 'A license agreement covers usage rights. An SLA covers service performance.' from questions q where q.legacy_hash = '1jernlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Server Logging Application', false, 'An SLA is a contract, not software.' from questions q where q.legacy_hash = '1jernlv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To delete old computers', false, 'Minimization is about collecting less data, not disposing of hardware.' from questions q where q.legacy_hash = '3mj420'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To collect only necessary data to reduce risk', true, NULL from questions q where q.legacy_hash = '3mj420'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To increase system performance', false, 'Less data may help performance, but the goal is lower risk and privacy compliance.' from questions q where q.legacy_hash = '3mj420'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To reduce training costs', false, 'Its purpose is limiting the sensitive data you hold.' from questions q where q.legacy_hash = '3mj420'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A physical drill', false, 'Tabletops are discussion-based. People walk through a scenario without taking real action.' from questions q where q.legacy_hash = 'nxw62w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A discussion-based simulated incident', true, NULL from questions q where q.legacy_hash = 'nxw62w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A real attack simulation', false, 'Live simulations are red team or technical exercises. A tabletop is talk-through only.' from questions q where q.legacy_hash = 'nxw62w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A Wi-Fi penetration test', false, 'Pen tests are hands-on technical testing.' from questions q where q.legacy_hash = 'nxw62w'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Server uptime', false, 'Uptime is an availability metric. A PIA looks at personal data handling.' from questions q where q.legacy_hash = '1genyy0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'How personal data is used and protected', true, NULL from questions q where q.legacy_hash = '1genyy0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Password strength', false, 'Password audits are a separate technical check.' from questions q where q.legacy_hash = '1genyy0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Employee productivity', false, 'A PIA assesses privacy risk, not productivity.' from questions q where q.legacy_hash = '1genyy0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To fire employees', false, 'Audits evaluate controls, not individual employment.' from questions q where q.legacy_hash = 'eenr27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To ensure controls follow company policy', true, NULL from questions q where q.legacy_hash = 'eenr27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To replace external audits', false, 'Internal audits complement external ones; regulations often require independent auditors.' from questions q where q.legacy_hash = 'eenr27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To reduce payroll', false, 'Audits check compliance with policy.' from questions q where q.legacy_hash = 'eenr27'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It organizes folders', false, 'Folder structure is organization. Encryption makes data unreadable to unauthorized people.' from questions q where q.legacy_hash = '1qr2uz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It prevents unauthorized data access', true, NULL from questions q where q.legacy_hash = '1qr2uz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It blocks phishing emails', false, 'Email filtering blocks phishing.' from questions q where q.legacy_hash = '1qr2uz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It improves CPU speed', false, 'Encryption uses CPU; it doesn''t speed it up.' from questions q where q.legacy_hash = '1qr2uz4'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To ensure employees dress correctly', false, 'Dress codes are separate HR rules. Disciplinary policies enforce security accountability.' from questions q where q.legacy_hash = '55bwv0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To enforce consequences for security violations', true, NULL from questions q where q.legacy_hash = '55bwv0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To schedule breaks', false, 'Break scheduling is HR operations.' from questions q where q.legacy_hash = '55bwv0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To train interns', false, 'Training is a separate program.' from questions q where q.legacy_hash = '55bwv0'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Having users perform all tasks', false, 'One person doing everything is the risk this control removes.' from questions q where q.legacy_hash = 'rpg6gf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Splitting responsibilities to reduce fraud risk', true, NULL from questions q where q.legacy_hash = 'rpg6gf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Letting employees choose their own tasks', false, 'Duties are assigned deliberately so critical steps are split.' from questions q where q.legacy_hash = 'rpg6gf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Reducing team size', false, 'It usually requires more people involved in a process, not fewer.' from questions q where q.legacy_hash = 'rpg6gf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To renew software licenses', false, 'License renewal is procurement. Recertification reviews user permissions.' from questions q where q.legacy_hash = 'ifiex2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To verify users still need their permissions', true, NULL from questions q where q.legacy_hash = 'ifiex2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To assign raises', false, 'Raises are HR decisions.' from questions q where q.legacy_hash = 'ifiex2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To reset email passwords', false, 'Password resets are support tasks.' from questions q where q.legacy_hash = 'ifiex2'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A user bypassing rules without approval', false, 'An exception is formally approved and documented. Unapproved bypassing is a violation.' from questions q where q.legacy_hash = '1bt45nk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A documented approved deviation from policy', true, NULL from questions q where q.legacy_hash = '1bt45nk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A type of firewall rule', false, 'Exceptions are policy deviations, not firewall entries.' from questions q where q.legacy_hash = '1bt45nk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A malware warning', false, 'A malware warning is an alert, not an approved deviation.' from questions q where q.legacy_hash = '1bt45nk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Policy', false, 'Policies state what must happen and why. SOPs give the step-by-step how.' from questions q where q.legacy_hash = 'rrs9hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Standard Operating Procedures (SOP)', true, NULL from questions q where q.legacy_hash = 'rrs9hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Privacy notice', false, 'A privacy notice tells people how their data is used.' from questions q where q.legacy_hash = 'rrs9hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Travel guidelines', false, 'Travel guidelines don''t cover operational procedures.' from questions q where q.legacy_hash = 'rrs9hq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'To lower system performance', false, 'Training affects people, not systems.' from questions q where q.legacy_hash = '1r89uue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'To ensure employees understand rules and regulations', true, NULL from questions q where q.legacy_hash = '1r89uue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'To increase storage space', false, 'Storage is unrelated. Training helps staff follow the rules.' from questions q where q.legacy_hash = '1r89uue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'To improve website design', false, 'Design is unrelated to compliance training.' from questions q where q.legacy_hash = '1r89uue'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A phishing attack', false, 'An SCA is a review, not an attack.' from questions q where q.legacy_hash = '1uwprek'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A review of security control effectiveness', true, NULL from questions q where q.legacy_hash = '1uwprek'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A penetration test', false, 'A pen test simulates attacks. An SCA reviews whether controls work as intended, often without exploiting anything.' from questions q where q.legacy_hash = '1uwprek'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A software license audit', false, 'License audits check usage rights, not security controls.' from questions q where q.legacy_hash = '1uwprek'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Holiday schedule', false, 'A retention policy sets how long logs and data are kept.' from questions q where q.legacy_hash = 'hzqvez'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Retention policy', true, NULL from questions q where q.legacy_hash = 'hzqvez'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Incident report', false, 'An incident report describes an event, not retention periods.' from questions q where q.legacy_hash = 'hzqvez'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Firewall rule set', false, 'Firewall rules control traffic, not how long logs are stored.' from questions q where q.legacy_hash = 'hzqvez'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'They slow down internet speeds', false, 'The risk comes from combining unknown systems, accounts and vulnerabilities.' from questions q where q.legacy_hash = 'zdryab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'They involve combining new systems and unknown risks', true, NULL from questions q where q.legacy_hash = 'zdryab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'They require employees to relocate', false, 'Relocation is a business concern, not the core security risk.' from questions q where q.legacy_hash = 'zdryab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'They reduce available storage', false, 'The risk is inheriting unknown systems and access.' from questions q where q.legacy_hash = 'zdryab'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'It gives users full administrative access', false, 'That violates least privilege. Onboarding grants only what the role needs.' from questions q where q.legacy_hash = '1lvrbjn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'It ensures new users receive appropriate permissions', true, NULL from questions q where q.legacy_hash = '1lvrbjn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'It prevents phishing attacks', false, 'Awareness training helps with phishing, but onboarding''s access role is assigning correct permissions.' from questions q where q.legacy_hash = '1lvrbjn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'It configures firewalls', false, 'Firewall configuration is a separate technical task.' from questions q where q.legacy_hash = '1lvrbjn'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Training new employees', false, 'Training new hires is part of onboarding.' from questions q where q.legacy_hash = '1rylonp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Removing access after employment ends', true, NULL from questions q where q.legacy_hash = '1rylonp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Giving users new laptops', false, 'Handing out equipment is onboarding. Offboarding collects it.' from questions q where q.legacy_hash = '1rylonp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Resetting database passwords', false, 'Rotating shared credentials may be part of offboarding, but the core is removing the departing user''s access.' from questions q where q.legacy_hash = '1rylonp'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Measure packet loss', false, 'Packet loss is a network metric. A BIA ranks business functions by the impact of downtime.' from questions q where q.legacy_hash = '1azs8pk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Identify critical systems and downtime impact', true, NULL from questions q where q.legacy_hash = '1azs8pk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Improve Wi-Fi strength', false, 'A BIA is a planning analysis, not network tuning.' from questions q where q.legacy_hash = '1azs8pk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monitor CPU performance', false, 'That''s system monitoring.' from questions q where q.legacy_hash = '1azs8pk'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Reviews HR complaints', false, 'HR handles complaints. A data owner decides how data is classified and who may access it.' from questions q where q.legacy_hash = '1kf5eos'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Determines data classification and access requirements', true, NULL from questions q where q.legacy_hash = '1kf5eos'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Writes firewall rules', false, 'Network engineers write firewall rules.' from questions q where q.legacy_hash = '1kf5eos'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Runs backup servers', false, 'Running systems is the data custodian''s job. The owner makes the decisions.' from questions q where q.legacy_hash = '1kf5eos'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Updating software daily', false, 'Patching is one task. Continuous improvement is steadily strengthening the whole program.' from questions q where q.legacy_hash = 'bmcsvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Regularly enhancing controls and processes', true, NULL from questions q where q.legacy_hash = 'bmcsvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firing employees', false, 'It improves controls and processes, not staffing.' from questions q where q.legacy_hash = 'bmcsvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Replacing all hardware', false, 'Improvement is gradual, based on lessons learned and metrics.' from questions q where q.legacy_hash = 'bmcsvv'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'They decorate reports', false, 'Metrics give leadership evidence to make decisions.' from questions q where q.legacy_hash = '18sisxs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'They measure effectiveness and performance of controls', true, NULL from questions q where q.legacy_hash = '18sisxs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'They entertain users', false, 'Metrics measure how well controls perform.' from questions q where q.legacy_hash = '18sisxs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'They improve animations', false, 'Metrics track security effectiveness.' from questions q where q.legacy_hash = '18sisxs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'How much coffee employees drink', false, 'Risk appetite is how much risk leadership is willing to accept.' from questions q where q.legacy_hash = '1y2vj3k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'The amount of risk leadership is willing to accept', true, NULL from questions q where q.legacy_hash = '1y2vj3k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'The number of vulnerabilities allowed', false, 'Appetite is about overall risk, not a count of vulnerabilities.' from questions q where q.legacy_hash = '1y2vj3k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'The time allowed for patching', false, 'Patch deadlines are an operational policy that may reflect appetite, but they aren''t the same thing.' from questions q where q.legacy_hash = '1y2vj3k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'ISO 9001', false, 'ISO 9001 covers quality management in general, not security programs specifically.' from questions q where q.legacy_hash = '1h2ox65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'NIST Cybersecurity Framework', true, NULL from questions q where q.legacy_hash = '1h2ox65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'PCI DSS', false, 'PCI DSS is a compliance standard for payment card data, not a program-improvement framework.' from questions q where q.legacy_hash = '1h2ox65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'GDPR', false, 'GDPR is an EU privacy regulation, not a security improvement framework.' from questions q where q.legacy_hash = '1h2ox65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A log entry', false, 'A single log entry is raw data. A KRI is a tracked metric that warns of rising risk.' from questions q where q.legacy_hash = '6ly5n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A predictive metric that signals increasing risk', true, NULL from questions q where q.legacy_hash = '6ly5n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A phishing technique', false, 'KRIs are governance metrics.' from questions q where q.legacy_hash = '6ly5n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A vulnerability score', false, 'A CVSS score rates one vulnerability. A KRI tracks risk trends over time.' from questions q where q.legacy_hash = '6ly5n'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Define technical configurations', false, 'Technical settings belong in baselines and standards. Governance sets direction and accountability.' from questions q where q.legacy_hash = 'hxwucg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Provide high-level direction and accountability', true, NULL from questions q where q.legacy_hash = 'hxwucg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Perform penetration tests', false, 'Pen tests are operational assessments.' from questions q where q.legacy_hash = 'hxwucg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monitor network bandwidth', false, 'That''s network operations.' from questions q where q.legacy_hash = 'hxwucg'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Subjective ratings', false, 'Subjective ratings describe qualitative analysis.' from questions q where q.legacy_hash = '1p0454j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Numerical values such as financial cost', true, NULL from questions q where q.legacy_hash = '1p0454j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Employee surveys', false, 'Surveys give opinions. Quantitative analysis uses measurable values like SLE and ALE.' from questions q where q.legacy_hash = '1p0454j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Security training results', false, 'Training results are awareness metrics, not the basis of quantitative risk analysis.' from questions q where q.legacy_hash = '1p0454j'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encrypt all backups', false, 'Encryption may be required elsewhere, but sovereignty is about the laws of the data''s location.' from questions q where q.legacy_hash = 'z6tfuf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Follow the laws of the country where data is stored', true, NULL from questions q where q.legacy_hash = 'z6tfuf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Use firewalls with geofencing', false, 'Geofencing is a technical control, not a sovereignty requirement.' from questions q where q.legacy_hash = 'z6tfuf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Store data in the cloud', false, 'Sovereignty applies wherever data is stored, cloud or not.' from questions q where q.legacy_hash = 'z6tfuf'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Data encryption', false, 'Here MDM means master data management: keeping core records accurate and consistent.' from questions q where q.legacy_hash = 'mbnlxr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Data accuracy and consistency across systems', true, NULL from questions q where q.legacy_hash = 'mbnlxr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Wi-Fi security', false, 'That''s wireless security, unrelated to master data.' from questions q where q.legacy_hash = 'mbnlxr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Account lockout policies', false, 'Lockout is an authentication control.' from questions q where q.legacy_hash = 'mbnlxr'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Web development', false, 'The exercises test security: red attacks, blue defends.' from questions q where q.legacy_hash = '1spq5n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Simulating attack and defense scenarios', true, NULL from questions q where q.legacy_hash = '1spq5n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Writing policies', false, 'Policies may be updated afterwards, but the exercise simulates attack and defense.' from questions q where q.legacy_hash = '1spq5n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Training sales staff', false, 'They''re for security teams.' from questions q where q.legacy_hash = '1spq5n3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Battery life', false, 'Classification decides which protections data needs.' from questions q where q.legacy_hash = 'mfr4xq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'What security controls must be applied', true, NULL from questions q where q.legacy_hash = 'mfr4xq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Employee schedules', false, 'Schedules are HR matters.' from questions q where q.legacy_hash = 'mfr4xq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'System uptime', false, 'Uptime is an availability metric, not something classification sets.' from questions q where q.legacy_hash = 'mfr4xq'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Usernames to passwords', false, 'That''s authentication, not gap analysis.' from questions q where q.legacy_hash = '11pivw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Current state to the desired state', true, NULL from questions q where q.legacy_hash = '11pivw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall rules to malware', false, 'Gap analysis compares where you are with where you need to be.' from questions q where q.legacy_hash = '11pivw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Cloud costs to salaries', false, 'That''s a financial comparison, not a security gap analysis.' from questions q where q.legacy_hash = '11pivw5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'MTBF x MTTR', false, 'MTBF and MTTR are reliability metrics. ALE = SLE × ARO.' from questions q where q.legacy_hash = '1kptv9m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'SLE x ARO', true, NULL from questions q where q.legacy_hash = '1kptv9m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'ROI ÷ TCO', false, 'ROI and TCO are financial investment measures, not loss expectancy.' from questions q where q.legacy_hash = '1kptv9m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'CIA ÷ AAA', false, 'Those are security concepts, not numbers you can calculate with.' from questions q where q.legacy_hash = '1kptv9m'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Measure progress of an organization’s security capabilities', true, NULL from questions q where q.legacy_hash = 'nq59bs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Rate password strength', false, 'Password meters rate passwords. Maturity models rate how capable the security program is.' from questions q where q.legacy_hash = 'nq59bs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Test network throughput', false, 'That''s performance testing.' from questions q where q.legacy_hash = 'nq59bs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Audit social media', false, 'Maturity models assess security processes overall.' from questions q where q.legacy_hash = 'nq59bs'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Firewall rules', false, 'Firewall rules may be one action, but the plan covers how each risk will be handled.' from questions q where q.legacy_hash = 'gq5ess'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Steps to reduce or manage risks', true, NULL from questions q where q.legacy_hash = 'gq5ess'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Employee vacation schedules', false, 'Schedules are HR matters.' from questions q where q.legacy_hash = 'gq5ess'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Database diagrams', false, 'Diagrams document design, not risk responses.' from questions q where q.legacy_hash = 'gq5ess'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Refusing to pay for security', false, 'Transference often costs money, such as insurance premiums, to shift the risk.' from questions q where q.legacy_hash = '5qvxyl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Shifting risk to a third party, such as through insurance', true, NULL from questions q where q.legacy_hash = '5qvxyl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Ignoring the risk', false, 'Transference is a deliberate response: someone else bears the financial impact.' from questions q where q.legacy_hash = '5qvxyl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Encrypting the risk', false, 'Encryption is mitigation, a different response.' from questions q where q.legacy_hash = '5qvxyl'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Marketing report', false, 'A findings report documents weaknesses found during assessment.' from questions q where q.legacy_hash = 'b041w6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Findings report', true, NULL from questions q where q.legacy_hash = 'b041w6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Holiday schedule', false, 'It isn''t an assessment document.' from questions q where q.legacy_hash = 'b041w6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Billing invoice', false, 'An invoice charges for work; it doesn''t document findings.' from questions q where q.legacy_hash = 'b041w6'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Employee birthdays', false, 'A BCP covers recovery priorities and procedures.' from questions q where q.legacy_hash = '8ese6k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Recovery procedures and critical system priorities', true, NULL from questions q where q.legacy_hash = '8ese6k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Favorite lunch options', false, 'A BCP is about keeping critical operations running.' from questions q where q.legacy_hash = '8ese6k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Gaming policies', false, 'Acceptable use rules aren''t part of a BCP.' from questions q where q.legacy_hash = '8ese6k'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Adding privacy later', false, 'Adding it later is what privacy by design avoids.' from questions q where q.legacy_hash = 'q5nuli'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Building privacy into systems from the beginning', true, NULL from questions q where q.legacy_hash = 'q5nuli'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Removing privacy settings', false, 'It makes privacy the default.' from questions q where q.legacy_hash = 'q5nuli'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Encrypting everything', false, 'Encryption can be one tool, but privacy by design is a broader development principle.' from questions q where q.legacy_hash = 'q5nuli'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Hide audit logs', false, 'Aggregation combines risks to see their total impact.' from questions q where q.legacy_hash = '91ri65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Understand combined effects of multiple risks', true, NULL from questions q where q.legacy_hash = '91ri65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Increase firewall throughput', false, 'It''s an analysis method, not network tuning.' from questions q where q.legacy_hash = '91ri65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Reduce power consumption', false, 'It measures combined risk, not energy use.' from questions q where q.legacy_hash = '91ri65'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Approving budgets', false, 'Budgets are management decisions. Custodians apply the protections day to day.' from questions q where q.legacy_hash = 'dmhrm5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Implementing and maintaining data protections', true, NULL from questions q where q.legacy_hash = 'dmhrm5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Writing press releases', false, 'That''s communications work.' from questions q where q.legacy_hash = 'dmhrm5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Managing employee benefits', false, 'That''s HR.' from questions q where q.legacy_hash = 'dmhrm5'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Department-specific risks only', false, 'ERM looks across the whole enterprise, not one department.' from questions q where q.legacy_hash = 'geu3eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Risk across the entire organization', true, NULL from questions q where q.legacy_hash = 'geu3eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Only cybersecurity risks', false, 'ERM includes financial, operational, legal and other risks too.' from questions q where q.legacy_hash = 'geu3eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Replacing all firewalls', false, 'ERM is a management discipline, not a technical project.' from questions q where q.legacy_hash = 'geu3eo'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'A control that provides alternate but equivalent protection', true, NULL from questions q where q.legacy_hash = '1l50a2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'A backup server', false, 'A backup server supports recovery. A compensating control substitutes for a control that can''t be used.' from questions q where q.legacy_hash = '1l50a2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'A password manager', false, 'A password manager is one tool, not the definition of a compensating control.' from questions q where q.legacy_hash = '1l50a2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'A router firmware update', false, 'Updating firmware is patching.' from questions q where q.legacy_hash = '1l50a2t'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Maximum Time To Respond', false, 'MTTR means Mean Time To Repair: the average time to restore after a failure.' from questions q where q.legacy_hash = '1q8m168'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Mean Time To Repair', true, NULL from questions q where q.legacy_hash = '1q8m168'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Monthly Technical Training Requirement', false, 'MTTR is a reliability metric.' from questions q where q.legacy_hash = '1q8m168'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Managed Threat Testing Routine', false, 'MTTR measures repair time, not testing.' from questions q where q.legacy_hash = '1q8m168'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Mean Time Between Failures', true, NULL from questions q where q.legacy_hash = '1crm237'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Maximum Threat Baseline Factor', false, 'MTBF means Mean Time Between Failures, a reliability measure.' from questions q where q.legacy_hash = '1crm237'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Managed Testing Before Failure', false, 'MTBF is the average time a system runs between failures.' from questions q where q.legacy_hash = '1crm237'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Monthly Travel Budget Forecast', false, 'MTBF is a reliability metric.' from questions q where q.legacy_hash = '1crm237'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'How long employees can work remotely', false, 'RPO is about how much data you can afford to lose, measured in time.' from questions q where q.legacy_hash = '158nr9v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Maximum acceptable data loss', true, NULL from questions q where q.legacy_hash = '158nr9v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Cost of downtime', false, 'Downtime cost comes from the BIA. RPO sets acceptable data loss.' from questions q where q.legacy_hash = '158nr9v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Office evacuation time', false, 'RPO is a data recovery target.' from questions q where q.legacy_hash = '158nr9v'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'How long a system can be down before causing harm', true, NULL from questions q where q.legacy_hash = 'x4ts70'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Required time to update firewalls', false, 'RTO is the maximum acceptable downtime before restoration.' from questions q where q.legacy_hash = 'x4ts70'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Backup window duration', false, 'The backup window is when backups run. RTO is about restoring after an outage.' from questions q where q.legacy_hash = 'x4ts70'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Password expiration', false, 'Password expiry is an authentication policy.' from questions q where q.legacy_hash = 'x4ts70'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Gap analysis', false, 'Gap analysis compares current and desired states. Threat modeling maps out possible attacks.' from questions q where q.legacy_hash = '1qlzksu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Threat modeling', true, NULL from questions q where q.legacy_hash = '1qlzksu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Port scanning', false, 'Port scanning finds open services, one technical input, not the whole strategy.' from questions q where q.legacy_hash = '1qlzksu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Data scrubbing', false, 'Scrubbing cleans or sanitizes data.' from questions q where q.legacy_hash = '1qlzksu'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'An antivirus product', false, 'Resilience is an organizational ability: withstanding and recovering from attacks.' from questions q where q.legacy_hash = '1jmig0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Ability to withstand, respond to, and recover from cyber incidents', true, NULL from questions q where q.legacy_hash = '1jmig0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Firewall performance', false, 'Resilience is about continuing operations, not one device.' from questions q where q.legacy_hash = '1jmig0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'CPU resistance to overheating', false, 'It''s about cyber incidents, not hardware temperature.' from questions q where q.legacy_hash = '1jmig0c'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Risk that remains after controls are applied', true, NULL from questions q where q.legacy_hash = '1iy7yor'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Risk before assessment', false, 'Risk before any controls is inherent risk.' from questions q where q.legacy_hash = '1iy7yor'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Risk transferred to insurance', false, 'That''s transferred risk. Residual risk is what remains after controls.' from questions q where q.legacy_hash = '1iy7yor'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Risk with no consequences', false, 'Residual risk still has consequences; it''s just been accepted.' from questions q where q.legacy_hash = '1iy7yor'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'Encrypt hard drives', false, 'That''s full disk encryption. Masking hides real values, for example in test data.' from questions q where q.legacy_hash = '14twk3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Hide real data during testing or sharing', true, NULL from questions q where q.legacy_hash = '14twk3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Improve database speed', false, 'Masking protects data; it doesn''t tune performance.' from questions q where q.legacy_hash = '14twk3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Compress files', false, 'Compression reduces size. Masking obscures sensitive values.' from questions q where q.legacy_hash = '14twk3'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 0, 'One particular security concern or technology', true, NULL from questions q where q.legacy_hash = '1pqrtog'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 1, 'Entire company operations', false, 'Organization-wide direction is the enterprise security policy. An ISSP covers one issue.' from questions q where q.legacy_hash = '1pqrtog'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 2, 'Employee benefits', false, 'Benefits are HR matters.' from questions q where q.legacy_hash = '1pqrtog'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;
insert into choices (question_id, position, text, is_correct, rationale)
select q.id, 3, 'Marketing strategies', false, 'Marketing is unrelated. An ISSP covers topics like email or internet use.' from questions q where q.legacy_hash = '1pqrtog'
on conflict (question_id, position) do update set
  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;

-- Anything no longer in the bank is retired, never deleted: attempt_answers
-- reference these rows, and a retired question keeps its history.
update questions set status = 'retired', updated_at = now()
where status <> 'retired' and legacy_hash not in (
  'iybhy3',
  'z4etyy',
  '1ljvpxw',
  'bx3kow',
  '1ls1n47',
  'eg98n8',
  'jtwuox',
  '1r5rau2',
  'gut9gw',
  '1koobnp',
  'edqvw0',
  '187s2rx',
  '1ve2es1',
  '10jus1',
  '9wryfb',
  '7ea9am',
  'fudefs',
  '1v94t4e',
  'c4jn86',
  '1jn1epm',
  'jpv9y7',
  'xcnlz',
  '1vrim8e',
  'bvo1r3',
  '1la9v5q',
  '10hd3tm',
  'p8owzi',
  '18tlug2',
  '1ra6j2h',
  '18o06q5',
  '1ljx9n3',
  'odzlpc',
  '5awowm',
  '1uw4ou0',
  '1lriks7',
  'axy9nm',
  'pmnspe',
  '1x45qw2',
  'urtxwr',
  '1m944hq',
  'ta2zf7',
  'qe29ou',
  '1qn27nm',
  'imsxav',
  '1lxqyyi',
  '188z4e7',
  '1lxblq0',
  '1fz631b',
  '1jd7zdk',
  '1vc0eb7',
  'tjgyg9',
  'zecg47',
  '1scx1az',
  '1mmg830',
  '21ug6t',
  'tpnupg',
  '1oc29ud',
  'o8iz9q',
  '1hcc8zx',
  'wy28qa',
  'h2vnjq',
  '1di01xj',
  '19i58t7',
  'e9md6j',
  '2cfy11',
  'ctrzs4',
  '1f8f2ad',
  'q4bfpf',
  '1vlcopn',
  '13ovjpz',
  'b3d6ye',
  '6cmelw',
  '1p4inue',
  'p3vaq',
  'lho59n',
  'p2a6d9',
  'bs241u',
  '19pq5a1',
  'as63pc',
  'in9q8i',
  'd7g9fr',
  '1myfy2t',
  'wfkoie',
  '1pc1paj',
  'ie7xv7',
  '1rpf672',
  '1rn11yb',
  '1jqhqd3',
  '1ifpf4o',
  'xz4mnm',
  '1m213sr',
  '1jdx46x',
  '1ncbkme',
  '184ka6n',
  '1oifmkg',
  '5p2yt',
  '1l5mqia',
  '1xtrc1g',
  '7n0thi',
  '1wzxpuy',
  '1caei8s',
  'zvhuvm',
  '1dzcj3f',
  '1uw8tyg',
  '17eg0yl',
  '3ph3u6',
  '1ous7n9',
  'dqp7v7',
  '1nxb28p',
  '14hvwdb',
  'wsgr6t',
  'on29ix',
  'ddefju',
  '1sfyjpl',
  '1saafku',
  '5pw8dg',
  '1vkhvl3',
  '1wcs3q5',
  '5lhnri',
  '6nekmy',
  '1rhxmdd',
  'q7w6o9',
  'qlool1',
  '1alelvk',
  '19kk6w1',
  'w2560l',
  'elqgzx',
  '1enioh4',
  '1u6ldgj',
  '15s3nvl',
  '19dsfii',
  'o5rj5q',
  '1xxa8wo',
  '1eq2ift',
  'r5atbg',
  '28z3ti',
  'b7lpr8',
  'qmfug9',
  '1wyhni0',
  '1pyznes',
  'umquqa',
  '175enyy',
  '15vmqy4',
  '7fw65',
  '14gepx',
  'hj21eo',
  'kst05e',
  'ry6pnk',
  '9cj2aq',
  'c0ppe3',
  'jdwi8s',
  'b4id20',
  '261cio',
  'gtnl93',
  '1o89vpr',
  '1sm99ki',
  '1dvp6u7',
  '1i3hyq2',
  '1llgw9p',
  '19l5zgp',
  '6cswp1',
  '64pgnl',
  '1nrpyny',
  'uywxsk',
  'g74utr',
  '10kt1r9',
  'rkhf5v',
  'o6vv89',
  '1s87hlv',
  '1ljorhj',
  '1izp0lt',
  '136ztab',
  'gp4i98',
  '8ua5vf',
  'ibqxhq',
  '15zvt81',
  '1d4zl13',
  '14bd62m',
  'xzi63l',
  '1vjr30y',
  'ym0d25',
  'wtjjmg',
  't9zot2',
  '1cwfjrx',
  '151j9fr',
  '7rbtwk',
  '1iy4wye',
  '1jedwbs',
  '1nxcxkk',
  '13pyq76',
  '5ohjlv',
  'wsnelc',
  '1j79gnz',
  'nv6cfu',
  'nusxb0',
  '1m95pl9',
  '5ho6k7',
  '1l0c9kj',
  'bgqm9y',
  '1mtp07a',
  'rx6gcz',
  '11djlxw',
  'fo9qoz',
  '1dtkbdv',
  '1oagxzr',
  '19hv92p',
  'yh6cne',
  '11vx3jj',
  'xf9kxq',
  'afrjuw',
  '19ptl0c',
  'ovv2zw',
  'onkdyc',
  's3crdq',
  '102dhui',
  'nuwco9',
  '7c4fa4',
  'ge8q8p',
  'pbek6q',
  '1tm8rc8',
  '13hzns2',
  '1txzs7i',
  'k2oohf',
  'u5n5qv',
  'dk9jec',
  '10p9mnf',
  '1x7it9s',
  '5zbn3a',
  '1y7u07',
  'itzq5c',
  'ja6q0b',
  '1roamlf',
  'q2bhwk',
  'gjpg40',
  '1od8gyr',
  '1k1dssr',
  '3mzk9n',
  '1x3bk4o',
  '1jvvu4p',
  'w6c7ee',
  '4avbht',
  '1qmpox',
  '1mh689z',
  '1xna7jd',
  'e1dx0w',
  'p6hzb5',
  'ah9hu',
  '18vr794',
  'ff6xl',
  'hjg4c',
  'f0ia9r',
  '1gxzank',
  '99j960',
  'jz99r',
  'isk100',
  '1rbcgw5',
  '1prfkpo',
  '197g93t',
  '1jkvwxg',
  '1f8zbm0',
  '8p2e13',
  '1cqrcga',
  '9grau',
  '197dqct',
  '197r522',
  'x0hhsr',
  '1dpnqx1',
  '197pf2w',
  'm9tpmo',
  '1wmoymn',
  '197smat',
  '197jg2k',
  'yw7bgd',
  '1p3tj27',
  '1nol0is',
  '1l1i4bq',
  'a4n09',
  '197ejot',
  'sa4v4b',
  '197e17b',
  'htwul9',
  '13k61ih',
  '197r1bb',
  'cxcpc',
  'blz4w1',
  'lwfk0f',
  '12pgvtd',
  'j4zvv4',
  '1f9anjp',
  '1905wol',
  '1k48jz4',
  'czbnik',
  '1tbf6fm',
  'q2acg4',
  '4c10l',
  'mn15s',
  '57zxqu',
  '17nbsu3',
  '15lv8ad',
  '119p6hw',
  'h0axu',
  'h4u2x',
  '197nn2e',
  '197g8fz',
  '1knh8b2',
  '18qu3gn',
  'gfke19',
  'xtp1xu',
  '197ukpe',
  '1fngq1c',
  '10j5p9',
  '197g7ck',
  '17od631',
  '197gsen',
  '197my42',
  '5cqpu',
  '5uhcr',
  '625s3',
  '197tvkn',
  'yv1vc3',
  '1wughs8',
  'b7xf68',
  'yk37pg',
  '16u9xvt',
  '1sfb798',
  'alw83l',
  'gat1ig',
  '8qlwl5',
  'kihqq9',
  '4ej98e',
  't1l4ah',
  '1dihq2q',
  '4e3lrx',
  'ixsg4x',
  '1obw01b',
  '1nbvl69',
  'o7cplo',
  '1tzwrgb',
  'mrz1v5',
  'viozd4',
  '6ckdnx',
  'jr2gcb',
  '130q8le',
  'awjzvv',
  'nzu2q1',
  '1mlh2r3',
  '1aj5q7f',
  '1a3wfer',
  'mwsiw2',
  'm9h0j8',
  'eu1j2y',
  '14hk438',
  '1lowebg',
  'd1vcq0',
  '1dbyce',
  'l80jus',
  'ey6kgi',
  '103gvtz',
  '6p377n',
  '45001p',
  '1gwei1y',
  'soxspw',
  '1m0nvzm',
  '1hydgcz',
  '11timio',
  '1td5j6u',
  '17754pc',
  'f5egxh',
  '2rxtyj',
  '1r4mwvp',
  '1hm844x',
  '1j9qp6o',
  'qvfky',
  'nk4z2p',
  '12v0a0r',
  'a7kt34',
  'gooxow',
  '8fp9aa',
  'pb85w7',
  '1vgzczp',
  'ewx4j5',
  'mezrin',
  'c8jbcu',
  'j2wzqj',
  'i4i0a4',
  '7yqh7j',
  '1sp9xni',
  'e7g5ac',
  '19yt4iz',
  '13e9vee',
  '1dy4ong',
  '1wsd4wq',
  'znclo6',
  '1jernlv',
  '3mj420',
  'nxw62w',
  '1genyy0',
  'eenr27',
  '1qr2uz4',
  '55bwv0',
  'rpg6gf',
  'ifiex2',
  '1bt45nk',
  'rrs9hq',
  '1r89uue',
  '1uwprek',
  'hzqvez',
  'zdryab',
  '1lvrbjn',
  '1rylonp',
  '1azs8pk',
  '1kf5eos',
  'bmcsvv',
  '18sisxs',
  '1y2vj3k',
  '1h2ox65',
  '6ly5n',
  'hxwucg',
  '1p0454j',
  'z6tfuf',
  'mbnlxr',
  '1spq5n3',
  'mfr4xq',
  '11pivw5',
  '1kptv9m',
  'nq59bs',
  'gq5ess',
  '5qvxyl',
  'b041w6',
  '8ese6k',
  'q5nuli',
  '91ri65',
  'dmhrm5',
  'geu3eo',
  '1l50a2t',
  '1q8m168',
  '1crm237',
  '158nr9v',
  'x4ts70',
  '1qlzksu',
  '1jmig0c',
  '1iy7yor',
  '14twk3',
  '1pqrtog'
);

