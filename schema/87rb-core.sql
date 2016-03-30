CREATE SCHEMA admin;

CREATE TABLE admin.schema_version (
	version char(5),
	applied_on date
);