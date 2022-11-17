#!/bin/bash

# https://developer.hashicorp.com/vault/tutorials/db-credentials/database-secrets

echo "Pulling latest postgres container..."
docker pull postgres:latest

echo "Running container locally..."
docker run \
    --detach \
    --name learn-postgres \
    -e POSTGRES_USER=root \
    -e POSTGRES_PASSWORD=rootpassword \
    -p 5432:5432 \
    --rm \
    postgres

echo "Sleeping for 3 seconds to allow system to start succesfully..."
sleep 3

echo "Creating local 'ro' role within Postgres..."
docker exec -i \
    learn-postgres \
    psql -U root -c "CREATE ROLE \"ro\" NOINHERIT;"

echo "Setting desired permissions on 'ro' role..."
docker exec -i \
    learn-postgres \
    psql -U root -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"ro\";"
