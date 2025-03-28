#!/bin/bash

# Set default environment variables
export DATABASE_PROVIDER="postgres"
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

# Define the export_env_vars function (used in generate_database.sh)
export_env_vars() {
    echo "Exporting environment variables (placeholder)"
}
