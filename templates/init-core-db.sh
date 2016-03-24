#!/bin/bash
psql -c "CREATE ROLE {{DbAdminUser}} LOGIN PASSWORD '{{DbAdminPassword}}' CREATEDB"