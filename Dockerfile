# Stage 1: Build the Flutter Web application
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Backend API endpoint configuration (passed from .env via docker compose)
ARG API_HOST=localhost
ARG API_PORT=8080

# Set the working directory
WORKDIR /app

# Copy the pubspec and fetch dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build the application for web and inject build-time defines
# These --dart-define values are read by String.fromEnvironment as a fallback
RUN flutter build web --release \
	--dart-define=API_HOST=${API_HOST} \
	--dart-define=API_PORT=${API_PORT}

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the build output from the previous stage to Nginx's web root
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
