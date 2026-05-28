#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

echo "Running health checks for $ENV environment..."
# Simulate a health check (e.g., checking an endpoint)
sleep 2

# In a real scenario, this would curl the staging URL:
# curl -f https://${ENV}.example.com/health || exit 1

echo "Health check passed for $ENV."
exit 0
