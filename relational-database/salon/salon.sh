#!/bin/bash

#creating applocation coad

PSQL="psql -X --username=postgres --dbname=postgres --tuples-only -c"

#Drop database

$($PSQL "DROP DATABASE salon_test" &> /dev/null )
STATUS=$?
if [[ $STATUS != 0 ]]
then
  echo "database does not exist..."
else
  echo "deleting existing database.."
fi

#Create database

$($PSQL "CREATE DATABASE salon_test" &> /dev/null )
STATUS=$?
if [[ $STATUS != 0 ]]
then
  echo "database already exist......"
else
  echo "connect to database..."
fi
