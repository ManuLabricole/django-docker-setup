#!/bin/sh

# if [ "$DATABASE" = "postgres" ]
# then
#     echo "🚀 Waiting for PostgreSQL to start..."

#     while ! nc -z $DB_HOST $DB_PORT; do
#       sleep 0.1
#     done

#     echo "✅ PostgreSQL started!"
# fi
echo "⏱️ Waiting for PostgreSQL to start..."
./scripts/wait-for-it.sh db:5432 --timeout=30 --strict -- echo "Database is up"
echo "✅  PostgreSQL started!"
exec "$@"
