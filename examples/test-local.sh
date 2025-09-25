#!/bin/bash

# Local testing script for AI Coding Agent
# This script demonstrates how to test the Docker container locally
# without needing to set up GitHub Actions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}AI Coding Agent Local Test${NC}"
echo "=================================="

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed or not in PATH${NC}"
    exit 1
fi

# Check for .env file
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Warning: .env file not found. Creating example .env file...${NC}"
    cp .env.example .env
    echo -e "${RED}Please edit .env file with your actual API_KEY before running tests with real API calls${NC}"
fi

echo -e "\n${GREEN}Local testing setup completed!${NC}"
echo -e "\nTo test with GitHub Container Registry image:"
echo "docker run --rm --env-file .env -v \"\$(pwd)\":/workspace ghcr.io/zerolr/ai-coding-agent:main gemini --help"
echo -e "\nNext steps:"
echo "1. Update .env with your actual GEMINI_API_KEY"
echo "2. Set up GitHub Actions with GEMINI_API_KEY secret"
echo "3. See docs/github-actions-setup.md for detailed instructions"

