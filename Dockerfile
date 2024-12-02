# Step 1: Build the Angular application using Node.js
FROM node:20-alpine AS build

WORKDIR /app

# Copy the rest of the Angular app
COPY . .

RUN npm install -g @angular/cli

RUN npm install

# Expose the development server port
EXPOSE 4200

# Serve the Angular app in development mode
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]


# docker build -t ng-api-app2:1.2 .
# ocker run -d -p 4200:4200 --name test-api-app-ng-serve ng-api-app2:1.2
# docker exec -it test-api-app-ng-serve sh