#!/bin/bash
set -e

# Create the database
rails db:create || echo "Database already exists"

# Run migrations
rails db:migrate

# Seed the database
rails db:seed || echo "Seeding skipped"

# Generate Swagger documentation
rails rswag:specs:swaggerize

# Start the Rails server
exec rails server -b 0.0.0.0
