# Use Node runtime image
FROM node:20-alpine


# Create application folder
WORKDIR /app


# Copy application code
COPY app.js .


# Application port
EXPOSE 8080


# Start application
CMD ["node","app.js"]
