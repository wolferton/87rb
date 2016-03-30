#!/bin/bash
psql -c "CREATE ROLE {{DbAdminUser}} LOGIN PASSWORD '{{DbAdminPassword}}' CREATEDB"
psql -c "CREATE ROLE {{DbApiUser}} LOGIN PASSWORD '{{DbApiPassword}}'"
psql -c "CREATE DATABASE {{DatabaseName}}"
PGPASSWORD={{DbAdminPassword}} psql -U{{DbAdminUser}} -f{{SchemaFile}} {{DatabaseName}}
