DROP TABLE IF EXISTS jobs.job;
DROP TABLE IF EXISTS jobs.schedule;
DROP TABLE IF EXISTS auth.actor;
DROP TABLE IF EXISTS admin.schema_version;

DROP SCHEMA IF EXISTS auth;
DROP SCHEMA IF EXISTS jobs;
DROP SCHEMA IF EXISTS admin;

DROP TYPE IF EXISTS schedule;
DROP TYPE IF EXISTS overlap_mode;

CREATE SCHEMA admin;
CREATE SCHEMA jobs;
CREATE SCHEMA auth;

--Admin schema: housekeeping
CREATE TABLE admin.schema_version (
	version CHAR(5),
	applied_on TIMESTAMP WITH TIME ZONE NOT NULL
);



--Authorisation schema: users, roles and permissions
CREATE SEQUENCE auth.actor_ids_seq START 1000;

CREATE TABLE auth.actor (
    id INTEGER DEFAULT nextval('auth.actor_ids_seq') PRIMARY KEY,
    name VARCHAR(64)
);

ALTER SEQUENCE auth.actor_ids_seq OWNED BY auth.actor.id;

INSERT INTO
    auth.actor (id, name)
VALUES
    (50, 'System'),
    (60, 'Anonymous UI User'),
    (70, 'Anonymous API User');



--Jobs schema: operational/transactional data
CREATE TYPE schedule AS ENUM ('PERIODIC');

CREATE TABLE jobs.schedule (
    id SERIAL PRIMARY KEY,
    type schedule NOT NULL,
    created_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    created_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    updated_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TYPE overlap_mode AS ENUM ('NEVER', 'ALWAYS', 'BY_TARGET');

CREATE TABLE jobs.job (
    id SERIAL PRIMARY KEY,
    schedule_id INTEGER REFERENCES jobs.schedule(id) NOT NULL,
    overlap overlap_mode NOT NULL,
    ref VARCHAR(32) NOT NULL UNIQUE,
    created_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    created_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    updated_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

GRANT USAGE ON SCHEMA jobs TO api87rb;
GRANT INSERT, SELECT ON TABLE jobs.job TO api87rb;
GRANT INSERT, SELECT ON TABLE jobs.schedule TO api87rb;
GRANT USAGE, SELECT ON SEQUENCE jobs.job_id_seq TO api87rb;
GRANT USAGE, SELECT ON SEQUENCE jobs.schedule_id_seq TO api87rb;

GRANT USAGE ON SCHEMA jobs TO trigger87rb;
GRANT SELECT ON TABLE jobs.job TO trigger87rb;