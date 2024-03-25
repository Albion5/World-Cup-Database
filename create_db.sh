#! /bin/bash
USER=allie
DB_NAME=worldcup
PSQL="psql --username=$USER --dbname=$DB_NAME --no-align --tuples-only -f"

echo "$($PSQL create_db.sql)"
