#/ bin/bash
#set variables for users and database
if [[ $1 = 'test' ]]
then
DB="postgres"
WC_DB="worldcuptest"
USR="postgres"
else
DB="postgres"
WC_DB="worldcup"
USR="freecodecamp"
fi
PSQL="psql -X --username=$USR --dbname=$WC_DB --no-align --tuples-only -c"
#Drop table
$($PSQL "DROP TABLE teams, games" &> /dev/null)

#creating table [TEAM TABLE]
$($PSQL "CREATE TABLE teams (team_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL)" &> /dev/null ) 
STATUS=$?
if [[ $STATUS != 0 ]]
then
echo "relation teams table already exist......."
else
echo "teams table cratead sucessfully......."
fi
#creating table [GAMES TABLE]
$($PSQL "CREATE TABLE games (game_id SERIAL PRIMARY KEY, year INT NOT NULL, round VARCHAR(50) NOT NULL, winner_id INT NOT NULL REFERENCES teams(team_id), opponent_id INT NOT NULL REFERENCES teams(team_id), winner_goals INT NOT NULL, opponent_goals INT NOT NULL)" &> /dev/null )
STATUS=$?
if [[ $STATUS != 0 ]]
then
echo "relation games table already exit......."

else
echo "games table created sucessfully ..........."
fi
