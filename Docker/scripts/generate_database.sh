#!/bin/bash

# Try to load env_functions.sh, but continue if it fails
source /Docker/scripts/env_functions.sh || echo "Warning: env_functions.sh not found, using default settings"

# Set a default DATABASE_PROVIDER if it's not set
: ${DATABASE_PROVIDER:="postgres"}

# Set a default DATABASE_URL if it's not set
: ${DATABASE_URL:="postgresql://user:password@localhost:5432/dbname"}

if [ "${DOCKER_ENV}" = "true" ]; then
    export_env_vars
fi

if [[ "${DATABASE_PROVIDER}" == "postgres" || "${DATABASE_PROVIDER}" == "mysql" ]]; then
    export DATABASE_URL
    echo "Generating database for ${DATABASE_PROVIDER} Database Provider"
    echo "DATABASE_URL=${DATABASE_URL}"
    npm run generate --schema=prisma/prisma.schema
    if [ $? -ne 0 ]; then
        echo "Prisma generate failed"
        exit 1
    else
        echo "Prisma generate succeeded"
    fi
else
    echo "Error: Database provider ${DATABASE_PROVIDER} invalid."
    exit 1
fi
