FROM nginx:latest

# Set working directory to /usr/share/nginx/html (default Nginx directory)
WORKDIR /usr/share/nginx/html

# Copy all frontend files to the Nginx HTML directory
COPY ./ /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Command to start Nginx server
CMD ["nginx", "-g", "daemon off;"]
