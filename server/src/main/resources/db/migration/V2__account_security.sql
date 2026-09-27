-- Account security: email verification, password reset, TOTP and recovery codes.
--
-- The first migration after the baseline. V1 stays untouched, per the rule that
-- an applied migration is never edited.

/* ------------------------------------------------------------------ users -- */

alter table users
    add column email_verified boolean not null default false,
    -- Null means 2FA is off. One column rather than a boolean plus a secret,
    -- because "on, but by which means" is then a single answerable question
    -- instead of two flags that can disagree.
    add column two_factor_method text check (two_factor_method in ('email', 'totp')),
    -- Base32 of 20 random bytes, only for the 'totp' method. Keeping a secret
    -- around after 2FA is turned off is a liability, so disabling clears it.
    add column totp_secret       text;

-- Accounts that predate this migration are treated as verified. They were
-- created when there was nothing to verify, and a migration whose effect is to
-- lock out every existing user is not a migration.
update users set email_verified = true;

-- Choosing TOTP without a secret is not a state that can work: it would demand
-- a code that can never be generated, locking the account out permanently.
alter table users
    add constraint users_totp_secret_when_totp
    check (two_factor_method is distinct from 'totp' or totp_secret is not null);

/* ------------------------------------------------------------ user tokens -- */

-- Verification links, password-reset links and emailed login codes.
--
-- Only the SHA-256 of a token is stored, exactly as refresh_tokens does: the
-- raw value exists in the email and nowhere else, so a database leak hands out
-- no working links and no live codes.
create table user_tokens (
    id         uuid        primary key default gen_random_uuid(),
    user_id    uuid        not null references users (id) on delete cascade,
    token_hash text        not null unique,
    -- One table for all three, because they differ only in what redeeming them
    -- does. The constraint is what stops a reset token being spent on
    -- verification, or a login code on a password change.
    purpose    text        not null check (purpose in
                    ('verify_email', 'reset_password', 'login_code', 'login_challenge')),
    expires_at timestamptz not null,
    -- Single use. Set on redemption rather than deleting the row, so a link
    -- presented twice is recognised as spent instead of simply unknown.
    used_at    timestamptz,
    created_at timestamptz not null default now()
);

create index user_tokens_user_purpose_idx on user_tokens (user_id, purpose) where used_at is null;

/* --------------------------------------------------------- recovery codes -- */

-- What stops a lost authenticator being permanent. Ten single-use codes issued
-- when 2FA is set up and shown exactly once.
--
-- Hashed, not stored plainly: they are password-equivalent - each one alone is
-- enough to get past 2FA.
create table recovery_codes (
    user_id   uuid        not null references users (id) on delete cascade,
    code_hash text        not null,
    used_at   timestamptz,
    primary key (user_id, code_hash)
);

create index recovery_codes_unused_idx on recovery_codes (user_id) where used_at is null;
