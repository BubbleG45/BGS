BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_event" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "createdByAuthUserId" uuid NOT NULL,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "sport" text NOT NULL,
    "skillLevel" text,
    "description" text,
    "location" text,
    "startAt" timestamp without time zone NOT NULL,
    "isTournament" boolean NOT NULL,
    "status" text NOT NULL,
    "teamFeeCents" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_event_slug_unique" ON "bgs_event" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_event_registration" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "eventId" uuid NOT NULL,
    "registeredByAuthUserId" uuid NOT NULL,
    "teamName" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_event_registration_unique" ON "bgs_event_registration" USING btree ("eventId", "registeredByAuthUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_league" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "sport" text NOT NULL,
    "skillLevel" text,
    "description" text,
    "location" text,
    "status" text NOT NULL,
    "teamFeeCents" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_league_org_slug_unique" ON "bgs_league" USING btree ("organizationId", "slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_organization" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_organization_slug_idx" ON "bgs_organization" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_organization_member" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_organization_member_unique" ON "bgs_organization_member" USING btree ("organizationId", "authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_scheduled_match" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "leagueId" uuid NOT NULL,
    "homeTeamId" uuid NOT NULL,
    "awayTeamId" uuid NOT NULL,
    "scheduledAt" timestamp without time zone NOT NULL,
    "location" text,
    "status" text NOT NULL,
    "homeScore" bigint,
    "awayScore" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_standing" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "leagueId" uuid NOT NULL,
    "teamId" uuid NOT NULL,
    "wins" bigint NOT NULL,
    "losses" bigint NOT NULL,
    "ties" bigint NOT NULL,
    "pointsFor" bigint NOT NULL,
    "pointsAgainst" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bgs_standing_league_team_unique" ON "bgs_standing" USING btree ("leagueId", "teamId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_team" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "leagueId" uuid NOT NULL,
    "name" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bgs_team_membership" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "teamId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "invitedAt" timestamp without time zone NOT NULL,
    "joinedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "bgs_team_membership_unique" ON "bgs_team_membership" USING btree ("teamId", "authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_event"
    ADD CONSTRAINT "bgs_event_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "bgs_organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_event"
    ADD CONSTRAINT "bgs_event_fk_1"
    FOREIGN KEY("createdByAuthUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_event_registration"
    ADD CONSTRAINT "bgs_event_registration_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "bgs_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_event_registration"
    ADD CONSTRAINT "bgs_event_registration_fk_1"
    FOREIGN KEY("registeredByAuthUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_league"
    ADD CONSTRAINT "bgs_league_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "bgs_organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_organization_member"
    ADD CONSTRAINT "bgs_organization_member_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "bgs_organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_organization_member"
    ADD CONSTRAINT "bgs_organization_member_fk_1"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_scheduled_match"
    ADD CONSTRAINT "bgs_scheduled_match_fk_0"
    FOREIGN KEY("leagueId")
    REFERENCES "bgs_league"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_scheduled_match"
    ADD CONSTRAINT "bgs_scheduled_match_fk_1"
    FOREIGN KEY("homeTeamId")
    REFERENCES "bgs_team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_scheduled_match"
    ADD CONSTRAINT "bgs_scheduled_match_fk_2"
    FOREIGN KEY("awayTeamId")
    REFERENCES "bgs_team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_standing"
    ADD CONSTRAINT "bgs_standing_fk_0"
    FOREIGN KEY("leagueId")
    REFERENCES "bgs_league"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_standing"
    ADD CONSTRAINT "bgs_standing_fk_1"
    FOREIGN KEY("teamId")
    REFERENCES "bgs_team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_team"
    ADD CONSTRAINT "bgs_team_fk_0"
    FOREIGN KEY("leagueId")
    REFERENCES "bgs_league"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bgs_team_membership"
    ADD CONSTRAINT "bgs_team_membership_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "bgs_team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bgs_team_membership"
    ADD CONSTRAINT "bgs_team_membership_fk_1"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR bgs
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bgs', '20260802205013639', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260802205013639', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();


COMMIT;
