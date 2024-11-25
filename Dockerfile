# Step 1: Build the Angular application using Node.js
FROM node:20.14.0 AS build

WORKDIR /app

# Copy package.json and package-lock.json for npm install
COPY package*.json .

# Install dependencies
RUN npm install

# Copy the rest of the Angular app
COPY . .

# Build the Angular app for production
RUN npm run build -- --configuration production

# Check the location of the dist folder and list its contents
RUN echo "Dist folder location:" && ls -l /app/dist || echo "Dist folder is missing!" && \
    echo "Contents of /app:" && ls -l /app || echo "/app directory is empty!" && \
    echo "Contents of /app/dist/ng-api-app:" && ls -l /app/dist/ng-api-app || echo "ng-api-app folder is missing or empty!"

# Use NGINX to serve the application
FROM nginx:alpine  AS build-server

RUN chmod -R 755 /usr/share/nginx/html

# Copy the build output from the build stage to NGINX's web directory
COPY --from=build /app/dist/ng-api-app/browser /usr/share/nginx/html/

# Expose port 80 to the host
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]