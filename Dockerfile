# Base image
FROM nginx
# Set environment variables
ENV APP_HOME=/app
# Copy application code
WORKDIR $APP_HOME
COPY . .
# Install dependencies
RUN apt-get update && apt-get install -y python3
# Expose a port
EXPOSE 8080
# Command to run the application
CMD ["python3", "app.py"]
