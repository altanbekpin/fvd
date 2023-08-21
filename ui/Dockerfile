# Use the base Python image
FROM python:3.11.1

# Set the working directory
WORKDIR /app

# Copy requirements and configuration files
COPY requirements.txt requirements.txt
COPY app.ini app.ini

# Install dependencies
RUN apt-get update && apt-get install -y libpq-dev gcc netcat
RUN pip install -r requirements.txt
RUN pip install regex
RUN python -m nltk.downloader punkt

# Copy the rest of your application files
COPY . .

# Custom command: Wait for the database, then start the uWSGI server
CMD bash -c 'while ! nc -z db 5432; do sleep 1; done; uwsgi app.ini'
