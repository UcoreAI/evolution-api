#!/bin/bash

source ./Docker/scripts/env_functions.sh

if [ "$DOCKER_ENV" != "true" ]; then
    export_env_vars
fi

if [[ "$DATABASE_PROVIDER" == "postgresql" || "$DATABASE_PROVIDER" == "mysql" ]]; then
    export DATABASE_URL
    echo "Generating database for $DATABASE_PROVIDER"
    echo "Database URL: $DATABASE_URL"
# npm run generate --schema ./prisma/DATABASE_PROVIDER-schema.prisma
    if [ $? -ne 0 ]; then
        echo "Prisma generate failed"
        exit 1
    else
        echo "Prisma generate succeeded"
# echo "Prisma generate succeeded"
else
    echo "Error: Database provider $DATABASE_PROVIDER invalid."
    exit 1
fi
