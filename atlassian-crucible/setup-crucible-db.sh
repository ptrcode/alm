#!/bin/bash
echo "******CREATING CRUCIBLE DATABASE******"
gosu postgres psql --username postgres <<- EOSQL
   CREATE DATABASE crucible WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' \
       TEMPLATE template0;
   CREATE USER crucible;
   GRANT ALL PRIVILEGES ON DATABASE crucible to crucible;
EOSQL
echo ""

{ echo; echo "host crucible crucible 0.0.0.0/0 trust"; } >> "$PGDATA"/pg_hba.conf

if [ -r '/tmp/dumps/crucible.dump' ]; then
    echo "**IMPORTING CRUCIBLE DATABASE BACKUP**"
    gosu postgres psql crucible < /tmp/dumps/crucible.dump
    echo "**crucible DATABASE BACKUP IMPORTED***"
fi

echo "******crucible DATABASE CREATED******"
