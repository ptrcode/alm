#!/bin/bash
echo "******CREATING BAMBOO DATABASE******"
gosu postgres psql --username postgres <<- EOSQL
   CREATE DATABASE bamboo WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' \
       TEMPLATE template0;
   CREATE USER bamboo;
   GRANT ALL PRIVILEGES ON DATABASE bamboo to bamboo;
EOSQL
echo ""

{ echo; echo "host bamboo bamboo  0.0.0.0/0 trust"; } >> "$PGDATA"/pg_hba.conf

if [ -r '/tmp/dumps/bamboo.dump' ]; then
    echo "**IMPORTING BAMBOO DATABASE BACKUP**"
    gosu postgres psql bamboo < /tmp/dumps/bamboo.dump
    echo "**BAMBOO DATABASE BACKUP IMPORTED***"
fi

echo "******BAMBOO DATABASE CREATED******"
