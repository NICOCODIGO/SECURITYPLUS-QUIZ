-- The last TOTP time-step each account has spent.
--
-- A code is valid for about 90 seconds (one 30-second step either side of now,
-- for clock drift). Without this, a code seen over someone's shoulder, or
-- phished in real time, still works for the rest of that window after its
-- owner has used it. Recording the step and refusing any step at or below it
-- makes every code single-use, which RFC 6238 section 5.2 asks for.
--
-- Null until a code has been used; cleared whenever the secret changes.
alter table users
    add column totp_last_step bigint;
