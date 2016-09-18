#!/bin/bash
echo "******CREATING CROWD & CROWDID DATABASE******"
gosu postgres psql --username postgres <<- EOSQL
  CREATE DATABASE crowd WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' \
    TEMPLATE template0;
  CREATE DATABASE crowdid WITH ENCODING 'UNICODE' LC_COLLATE 'C' \
    LC_CTYPE 'C' TEMPLATE template0;
  CREATE USER crowd;
  GRANT ALL PRIVILEGES ON DATABASE crowd to crowd;
  GRANT ALL PRIVILEGES ON DATABASE crowdid to crowd;
EOSQL
echo ""

{ echo; echo "host crowd crowd 0.0.0.0/0 trust"; } >> "$PGDATA"/pg_hba.conf
{ echo; echo "host crowdid crowd 0.0.0.0/0 trust"; } >> "$PGDATA"/pg_hba.conf

if [ -r '/tmp/dumps/crowd.dump' ]; then
    echo "**IMPORTING CROWD DATABASE BACKUP**"
    gosu postgres psql crowd < /tmp/dumps/crowd.dump
    echo "**CROWD DATABASE BACKUP IMPORTED***"
fi

if [ -r '/tmp/dumps/crowdid.dump' ]; then
    echo "**IMPORTING CROWDID DATABASE BACKUP**"
    sh -c 'pg_restore -U crowdid -h "$DB_PORT_5432_TCP_ADDR" \
     -n public -w -d crowdid /tmp/crowdid.dump'
    echo "**CROWDID DATABASE BACKUP IMPORTED***"
fi

echo "******CROWD & CROWDID DATABASE CREATED******"i

gosu postgres psql crowd <<- EOSQL
    update cwd_property set property_value = '' where property_name = 'domain';
EOSQL
