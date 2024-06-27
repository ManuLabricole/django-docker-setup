#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "🚀 Waiting for PostgreSQL to start..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "✅ PostgreSQL started!"
fi

echo "🧹 Flushing the database..."
python django/manage.py flush --no-input

echo "⚙️  Applying database migrations..."
python django/manage.py migrate

echo "🎉 All setup steps completed! Starting the server..."
exec "$@"
