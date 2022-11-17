#!/bin/bash

docker exec -i \
    learn-postgres \
    psql -U root -c "SELECT usename, valuntil FROM pg_user;"