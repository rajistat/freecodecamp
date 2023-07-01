#!/bin/bash
#insert data
if [[ $1 = worldcupss ]]
then
PSQL="psql -X --username=postgres --dbname=worldcup_test --no-align --tuples-only -c"
else
PSQL="psql -X --username=freecoedcamp --dbname=worldcup --no-align --tuples-only -c"
fi
#TRUNCATE TABLE 
echo "$($PSQL "TRUNCATE TABLE games, teams")"
echo -e "\nSuccessful Truncate!\n"
#importing data
cat games.csv | while IFS="," read YR RD WR OP WRG OPG
do
      if [[ $WR != "winner" ]]
then
TEAM_ID=$($PSQL "select team_id FROM teams WHERE name = '$WR' AND name = '$OP'")
if [[ -z $TEAM_ID ]]
then
$($PSQL "INSERT INTO  teams(name) VALUES ('$WR')" &> /dev/null)
STATUS=$?
if [[ $STATUS == 0 ]]
then 
echo "Inserted winner data: Name- $WR"
fi
fi
$($PSQL "INSERT INTO teams(name) VALUES ('$OP')" &> /dev/null)
STATUS=$?
if [[ $STATUS == 0 ]]
then
echo "inserted opponent data:Name- $OP"
fi
if [[ YEAR != "year" ]]
      then
#CREATE WINNER_ID
 WR_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WR'")
 #GET OPPONENT_ID
 OP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OP'")
 #INSERT GAMES ROW
 INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YR, '$RD', $WR_ID, $OP_ID, $WRG, $OPG)")
 if [[ $INSERT_GAME == "INSERT 0 1" ]]
  then
 echo New game added: $YR, $RD, $WR_ID AND $OP_ID, score $WRG : $OPG
fi
fi
fi
done
