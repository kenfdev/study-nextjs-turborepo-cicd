#!/bin/sh

# Define a list of mandatory environment variables to check
MANDATORY_VARS="NEXT_PUBLIC_API_URL"

# Define a list of optional environment variables (no check needed)
OPTIONAL_VARS=""

# Check if each mandatory variable is set
for VAR in $MANDATORY_VARS; do
    if [ -z "$(eval echo \$$VAR)" ]; then
        echo "$VAR is not set. Please set it and rerun the script."
        exit 1
    fi
done

# Combine mandatory and optional variables for replacement
ALL_VARS="$MANDATORY_VARS $OPTIONAL_VARS"

# Find and replace PLACEHOLDER values with real values
find apps/web/public apps/web/.next -type f -name "*" |
while read file; do
    for VAR in $ALL_VARS; do
        echo "replacing PLACEHOLDER_$VAR with $(eval echo \$$VAR)"
        if [ ! -z "$(eval echo \$$VAR)" ]; then
            sed -i "s|PLACEHOLDER_$VAR|$(eval echo \$$VAR)|g" "$file"
        fi
    done
done