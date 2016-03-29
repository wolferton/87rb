#!/bin/bash
psql -c "CREATE ROLE {{DbAdminUser}} LOGIN PASSWORD '{{DbAdminPassword}}' CREATEDB"
psql -c "CREATE DATABASE {{DatabaseName}}"
PGPASSWORD={{DbAdminPassword}} psql -U{{DbAdminUser}} -f{{SchemaFile}} {{DatabaseName}}
