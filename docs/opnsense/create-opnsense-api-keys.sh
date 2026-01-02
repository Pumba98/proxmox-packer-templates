#!/bin/bash

OPNSENSE_HOST="${OPNSENSE_HOST:-"https://192.168.1.1"}"
OPNSENSE_USERNAME="${OPNSENSE_USERNAME:-"root"}"
OPNSENSE_PASSWORD="${OPNSENSE_PASSWORD:-"opnsense"}"

FORCE_GEN=0
DELETE_EXISTING=0
VERBOSE=0

for arg in "$@"; do
    case $arg in
        --force)           FORCE_GEN=1 ;;
        --delete-existing) DELETE_EXISTING=1 ;;
        -v)                VERBOSE=1 ;;
    esac
done

# Temp Files
COOKIE_JAR=$(mktemp)
LOGIN_HTML=$(mktemp)
SEARCH_JSON=$(mktemp)
KEYS_JSON=$(mktemp)

# Security
chmod 600 "$COOKIE_JAR" "$LOGIN_HTML" "$SEARCH_JSON" "$KEYS_JSON"

# Ensure cleanup on exit
trap "rm -f $COOKIE_JAR $LOGIN_HTML $SEARCH_JSON $KEYS_JSON" EXIT

# Get CSRF
curl -k -L -s -c "$COOKIE_JAR" "$OPNSENSE_HOST/" > "$LOGIN_HTML"

CSRF_LINE=$(grep 'autocomplete="new-password"' "$LOGIN_HTML")
CSRF_FIELD=$(echo "$CSRF_LINE" | sed 's/.*name="\([^"]*\)".*/\1/')
CSRF_VALUE=$(echo "$CSRF_LINE" | sed 's/.*value="\([^"]*\)".*/\1/')

if [ -z "$CSRF_VALUE" ]; then
    echo "Error: Failed to extract CSRF token from login page." >&2
    exit 1
fi

# cat $COOKIE_JAR

# Login
curl -k -L -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" \
     -d "usernamefld=${OPNSENSE_USERNAME}" \
     -d "passwordfld=${OPNSENSE_PASSWORD}" \
     -d "login=1" \
     -d "${CSRF_FIELD}=${CSRF_VALUE}" \
     "$OPNSENSE_HOST/" > /dev/null


# Check for existing key
curl -k -s -X POST \
     -b "$COOKIE_JAR" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -H "X-CSRFTOKEN: ${CSRF_VALUE}" \
     --data-raw "{}" \
     "$OPNSENSE_HOST/api/auth/user/search_api_key/" > "$KEYS_JSON"

# Extract IDs of keys belonging to this user
EXISTING_KEY_IDS=$(jq -r --arg name "$OPNSENSE_USERNAME" '.rows[] | select(.username == $name) | .id' "$KEYS_JSON")

if [ -n "$EXISTING_KEY_IDS" ]; then
    # Delete existing keys  (if requested)
    if [ "$DELETE_EXISTING" -eq 1 ]; then
        # DELETE MODE: Loop through IDs and delete them
        for KEY_ID in $EXISTING_KEY_IDS; do
            curl -k -s -X POST \
                 -b "$COOKIE_JAR" \
                 -H "Content-Type: application/json" \
                 -H "Accept: application/json" \
                 -H "X-CSRFTOKEN: ${CSRF_VALUE}" \
                 -d '{}' \
                 "$OPNSENSE_HOST/api/auth/user/del_api_key/$KEY_ID" > /dev/null
        done
    elif [ "$FORCE_GEN" -eq 1 ]; then
        # FORCE MODE: Do nothing here, proceed to create an ADDITIONAL key
        :
    else
        # SAFE MODE: Abort
        echo "Aborting: User '$OPNSENSE_USERNAME' already has API keys." >&2
        echo "Use --force to generate an additional key, or --delete-existing to replace them." >&2
        exit 0
    fi
fi

# Generate new key
RESPONSE=$(curl -k -s -X POST \
     -b "$COOKIE_JAR" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -H "X-CSRFTOKEN: ${CSRF_VALUE}" \
     -d '{}' \
     "$OPNSENSE_HOST/api/auth/user/add_api_key/$OPNSENSE_USERNAME")

API_KEY=$(echo "$RESPONSE" | jq -r '.key // empty')
API_SECRET=$(echo "$RESPONSE" | jq -r '.secret // empty')

if [ -n "$API_KEY" ]; then
    echo "$RESPONSE"

    if [ "$VERBOSE" -eq 1 ]; then
        echo ""
        echo "Test command:"
        echo "curl -k -u \"$API_KEY:$API_SECRET\" \"$OPNSENSE_HOST/api/core/system/status\""
    fi
else
    echo "Error: Server did not return an API key." >&2
    echo "Response: $RESPONSE" >&2
    exit 1
fi
