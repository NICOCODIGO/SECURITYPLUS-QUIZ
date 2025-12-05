# Use official Node image
FROM node:20-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your project
COPY . .

# Expose Vite’s dev server port
EXPOSE 5173

# Run Vite dev server, accessible from outside container
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
