#!/bin/sh

# Strict mode: exit immediately on any error
set -e

# Check whether GITHUB_TOKEN environment variable is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: The environment variable GITHUB_TOKEN is not set."
  echo "Please run the container with -e GITHUB_TOKEN='YOUR_GITHUB_TOKEN'."
  exit 1
fi

# Execute all arguments passed to the container (e.g., gemini 'help me modify main.py ...')
exec "$@"