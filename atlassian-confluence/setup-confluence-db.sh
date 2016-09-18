#!/bin/bash
echo "******CREATING CONFLUENCE DATABASE******"
gosu postgres psql --username postgres <<- EOSQL
   CREATE DATABASE confluence WITH ENCODING 'UNICODE' LC_COLLATE 'C' \
       LC_CTYPE 'C' TEMPLATE template0;
   CREATE USER confluence;
   GRANT ALL PRIVILEGES ON DATABASE confluence to confluence;
EOSQL
echo ""

{ echo; echo "host confluence confluence 0.0.0.0/0 trust"; } >> \
  "$PGDATA"/pg_hba.conf

if [ -r '/tmp/dumps/confluence.dump' ]; then
    echo "**IMPORTING CONFLUENCE DATABASE BACKUP**"
    gosu postgres psql confluence < /tmp/dumps/confluence.dump
    echo "**CONFLUENCE DATABASE BACKUP IMPORTED***"
fi

echo "******CONFLUENCE DATABASE CREATED******"
