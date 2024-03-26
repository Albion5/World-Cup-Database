#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=allie --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


echo $($PSQL "TRUNCATE games, teams")

insert_team() {
  local TEAM=$1
  local TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")
  if [[ -z $TEAM_ID ]]
  then
    local INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")
    fi
  fi
  echo $TEAM_ID
}

insert_game() {
  local INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($1, '$2', $3, $4, $5, $6)")
  echo $INSERT_GAME_RESULT
}

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
  if [[ $YEAR != 'year' ]]
  then
    WINNER_ID=$(insert_team $WINNER)
    OPPONENT_ID=$(insert_team $OPPONENT)
    INSERT_GAME_RESULT=$(insert_game $YEAR "$ROUND" $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS)
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, $YEAR $ROUND between $WINNER and $OPPONENT with goals $WINNER_GOALS:$OPPONENT_GOALS
    fi
  fi


done