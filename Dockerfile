# Stage 1: Build the Flutter Web application
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set the working directory
WORKDIR /app

# Copy the pubspec and fetch dependencies
# Note: we copy pubspec.lock but it might be updated by pub get if it was old
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build the application for web
# This generates files in /app/build/web
RUN flutter build web --release

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the build output from the previous stage to Nginx's web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 (standard for HTTP)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
