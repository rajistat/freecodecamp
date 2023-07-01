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
PSQL="psql -X --username=$USR --dbname=$DB --no-align --tuples-only -c"

#Drop database 
$($PSQL "DROP DATABASE $WC_DB" &> /dev/null)
STATUS=$?
if [[ $STATUS != 0 ]]
then 
echo "database does not exist...."
else
echo "deleting existing database........."
fi

#creating database
$($PSQL "CREATE DATABASE $WC_DB" &> /dev/null )
STATUS=$?
if [[ $STATUS != 0 ]]
then
echo "database already exit........"
else
echo "connect to database......."
fi
