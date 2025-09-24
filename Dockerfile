# Use a lightweight Node.js base image
FROM node:22-slim

# Set working directory
WORKDIR /workspace

# Install system dependencies (including git)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install gemini-cli
RUN npm install -g @google/gemini-cli

COPY .gemini /workspace/.gemini
COPY .geminiignore /workspace/.geminiignore

# Copy and set the startup script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command: show gemini help
CMD ["gemini", "--help"]
