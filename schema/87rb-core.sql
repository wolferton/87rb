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
CREATE TABLE jobs.job (
    id SERIAL PRIMARY KEY,
    created_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    created_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_by INTEGER REFERENCES auth.actor(id) NOT NULL,
    updated_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);