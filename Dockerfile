FROM python:3.9-slim 

# Set the working directory
WORKDIR /home

# Copy the Python script to the container
COPY measure.py .

# Create a directory called 'conf' to mount credentials
RUN mkdir conf

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y && \
    apt-get install -yq tzdata

# Set the timezone
ENV TZ=Europe/Zurich

# Install requirements
COPY requirements-docker.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -f /tmp/requirements.txt

# Expose the port 
EXPOSE 8888

# Run the Python script when the container starts
CMD ["python", "measure.py"]
