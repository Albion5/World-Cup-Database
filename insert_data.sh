#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi+ [] Your teams table should have a team_id column that is a type of SERIAL and is the primary key, and a name column that has to be UNIQUE


# Do not change code above this line. Use the PSQL variable above to query your database.
