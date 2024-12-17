Base image for Python
FROM python:3

# Set environment variables
ENV APP_HOME=/app

# Copy application code
WORKDIR $APP_HOME
COPY . .

# Install dependencies (if any, like Flask, Django, etc.)
RUN pip install -r requirements.txt

# Expose a port (adjust if necessary for your app)
EXPOSE 8080

# Command to run the application
CMD ["python3", "app.py"]
