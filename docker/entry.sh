db_name="beergarden"

# terminate DB connections, re-create the DB empty.
echo "
UPDATE pg_database SET datallowconn = 'false' WHERE datname = '${db_name}';
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '${db_name}';
DROP DATABASE IF EXISTS ${db_name};
CREATE DATABASE ${db_name};
" | psql -U postgres
