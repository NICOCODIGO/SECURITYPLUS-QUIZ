-- Baseline schema for the Security+ study platform.
--
-- Flyway owns the schema; Hibernate is set to `validate` and never writes DDL.
-- gen_random_uuid() is core Postgres (13+), so no extension is required.

/* ------------------------------------------------------------ content -- */

-- The SY0-701 objective outline, seeded from examObjectives.js.
create table objectives (
    code          text     primary key,           -- '1.2', '4.6'
    domain_number smallint not null check (domain_number between 1 and 5),
    title         text     not null
);

-- A question's objective is the source of truth for which domain it belongs
-- to. `filed_domain` records the quizData array it was imported from, which
-- for 147 of the 444 questions is a different domain — keeping both is what
-- lets per-domain stats describe content while the old filing stays visible.
create table questions (
    id             uuid        primary key default gen_random_uuid(),
    legacy_hash    text        not null unique,   -- djb2 of the text; joins imported localStorage history
    text           text        not null unique,
    difficulty     text        not null check (difficulty in ('Beginner', 'Intermediate', 'Advanced')),
    objective_code text        not null references objectives (code),
    filed_domain   smallint    not null check (filed_domain between 1 and 5),
    explanation    text        not null,          -- why the correct answer is correct
    status         text        not null default 'published' check (status in ('draft', 'published', 'retired')),
    created_at     timestamptz not null default now(),
    updated_at     timestamptz not null default now()
);

create index questions_objective_idx on questions (objective_code) where status = 'published';
create index questions_difficulty_idx on questions (difficulty) where status = 'published';

-- `rationale` is why this *wrong* choice is wrong, imported from
-- rationales/domain<N>.js. It is null on the correct choice, which is covered
-- by questions.explanation instead.
create table choices (
    id          uuid     primary key default gen_random_uuid(),
    question_id uuid     not null references questions (id) on delete cascade,
    position    smallint not null check (position between 0 and 9),
    text        text     not null,
    is_correct  boolean  not null default false,
    rationale   text,
    unique (question_id, position)
);

create index choices_question_idx on choices (question_id);

-- At most one correct choice per question. "At least one" is asserted by the
-- importer and by the content-integrity test, which a partial index cannot do.
create unique index choices_one_correct_idx on choices (question_id) where is_correct;

/* -------------------------------------------------------------- people -- */

-- An account exists to keep one person's own study data safe and in sync.
-- Nothing here is comparative: no ranking, no scores shown to other users, no
-- public profile. `display_name` is only ever shown back to its owner.
create table users (
    id            uuid        primary key default gen_random_uuid(),
    email         text        not null,
    password_hash text        not null,           -- bcrypt; never a raw password
    display_name  text,
    role          text        not null default 'USER' check (role in ('USER', 'ADMIN')),
    created_at    timestamptz not null default now(),
    last_login_at timestamptz
);

-- Case-insensitive uniqueness without the citext extension, so the schema
-- applies unchanged to a stock RDS instance.
create unique index users_email_lower_idx on users (lower(email));

-- Refresh tokens rotate on every use. Only the SHA-256 of a token is stored,
-- so a database leak does not hand out live sessions.
create table refresh_tokens (
    id         uuid        primary key default gen_random_uuid(),
    user_id    uuid        not null references users (id) on delete cascade,
    token_hash text        not null unique,
    expires_at timestamptz not null,
    revoked_at timestamptz,
    user_agent text,
    created_at timestamptz not null default now()
);

create index refresh_tokens_user_idx on refresh_tokens (user_id) where revoked_at is null;

/* ------------------------------------------------------------ attempts -- */

-- One finished quiz.
--
-- `server_graded` records how the score was arrived at, not how much it is
-- trusted — there is no ranking here, so nobody has anything to gain by
-- lying to their own dashboard. Mock exams run as a server-held session and
-- are scored there; practice quizzes are scored in the browser. The two can
-- cross: the app is required to keep working with the API switched off, so a
-- mock taken offline comes back client-scored. The flag is what tells those
-- apart afterwards.
create table attempts (
    id               uuid        primary key default gen_random_uuid(),
    user_id          uuid        references users (id) on delete cascade,
    type             text        not null check (type in ('domain', 'mock', 'weakest', 'custom')),
    score            smallint    not null check (score between 0 and 100),
    questions_count  smallint    not null check (questions_count > 0),
    duration_seconds integer     check (duration_seconds >= 0),
    domain_title     text,
    server_graded    boolean     not null default false,
    submitted_at     timestamptz not null default now()
);

-- Every query against this table is "one person's attempts, newest first" —
-- the dashboard, the trend chart and the weakest-subject picker all start there.
create index attempts_user_time_idx on attempts (user_id, submitted_at desc);

-- Per-question results. `domainBreakdown` is not stored: it is derived by
-- joining through questions -> objectives, so it can never drift from the
-- answers it summarises.
create table attempt_answers (
    attempt_id       uuid     not null references attempts (id) on delete cascade,
    position         smallint not null check (position >= 0),
    question_id      uuid     references questions (id) on delete set null,
    chosen_choice_id uuid     references choices (id) on delete set null,   -- null = left blank
    is_correct       boolean  not null,
    primary key (attempt_id, position)
);

create index attempt_answers_question_idx on attempt_answers (question_id);

/* ------------------------------------------------------- account state -- */

-- Question of the Day. Deliberately separate from `attempts`: a one-question
-- 0%/100% would swing the weighted averages on the Progress dashboard.
-- The streak is derived from these rows, never stored as a counter.
create table daily_answers (
    user_id     uuid        not null references users (id) on delete cascade,
    answered_on date        not null,
    question_id uuid        references questions (id) on delete set null,
    choice_id   uuid        references choices (id) on delete set null,
    is_correct  boolean     not null,
    answered_at timestamptz not null default now(),
    primary key (user_id, answered_on)
);

create table flagged_questions (
    user_id     uuid        not null references users (id) on delete cascade,
    question_id uuid        not null references questions (id) on delete cascade,
    created_at  timestamptz not null default now(),
    primary key (user_id, question_id)
);

create table custom_quiz_presets (
    id         uuid        primary key default gen_random_uuid(),
    user_id    uuid        not null references users (id) on delete cascade,
    name       text        not null,
    config     jsonb       not null,
    created_at timestamptz not null default now(),
    unique (user_id, name)
);
