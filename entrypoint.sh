#!/bin/sh

# Strict mode: exit immediately on any error
set -e

# Check whether API_KEY environment variable is set
if [ -z "$API_KEY" ]; then
  echo "Error: The environment variable API_KEY is not set."
  echo "Please run the container with -e API_KEY='YOUR_API_KEY'."
  exit 1
fi

# Export provided API_KEY as GEMINI_API_KEY required by gemini-cli
export GEMINI_API_KEY="$API_KEY"

# Execute all arguments passed to the container (e.g., gemini 'help me modify main.py ...')
exec "$@"