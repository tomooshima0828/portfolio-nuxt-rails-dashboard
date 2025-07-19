# syntax = docker/dockerfile:1

ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-slim

# Nuxt app lives here
WORKDIR /app

# Install packages needed for development
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    git \
    curl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application code
COPY . .

# Set ownership for existing node user
RUN chown -R node:node /app
USER node:node

# Expose port
EXPOSE 3000

# Start the development server
CMD ["npm", "run", "dev"]