# Use a small Python image to keep the container lightweight.
FROM python:3.9-slim

# Prevent Python from creating cache files and buffer logs.
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Keep all application files inside the container's working directory.
WORKDIR /app

# Copy dependencies separately so Docker can reuse the dependency layer.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source and its frontend assets.
COPY app.py .
COPY templates /app/templates
COPY static /app/static

# Document the port used by the Flask application.
EXPOSE 5000

# Start the application when the container launches.
CMD ["python","app.py"]

# Docker image build and run commands:
# 1. Build the Docker image:
#    docker build -t k8s-test-app:latest .
#
# 2. Verify the image:
#    docker images
#
# 3. Test the image locally:
#    docker run -p 5000:5000 k8s-test-app:latest