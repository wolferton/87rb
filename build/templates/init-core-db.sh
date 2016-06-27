#!/bin/bash
psql -c "CREATE ROLE {{DbAdminUser}} LOGIN PASSWORD '{{DbAdminPassword}}' CREATEDB"
psql -c "CREATE ROLE {{DbApiUser}} LOGIN PASSWORD '{{DbApiPassword}}'"
psql -c "CREATE ROLE {{DbTriggerUser}} LOGIN PASSWORD '{{DbTriggerPassword}}'"
psql -c "CREATE DATABASE {{DatabaseName}} OWNER={{DbAdminUser}}  ENCODING='UTF8'"
psql -c "ALTER DATABASE {{DatabaseName}} SET timezone TO 'UTC'"
psql -c "GRANT ALL PRIVILEGES ON DATABASE {{DatabaseName}} TO {{DbApiUser}}"
psql -c "GRANT ALL PRIVILEGES ON DATABASE {{DatabaseName}} TO {{DbTriggerUser}}"
PGPASSWORD={{DbAdminPassword}} psql -U{{DbAdminUser}} -f{{SchemaFile}} {{DatabaseName}}
