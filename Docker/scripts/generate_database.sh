#!/bin/bash

source /Docker/scripts/env_functions.sh

if [ "${SOCKER_ENV}" = "true" ]; then
    export_env_vars
fi

# Fix the condition using double brackets for clarity
if [[ "${DATABASE_PROVIDER}" == "postgres" || "${DATABASE_PROVIDER}" == "mysql" ]]; then
    export DATABASE_URL
    echo "Generating database for SQLite Database Provider"
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
