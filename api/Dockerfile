FROM python:3.11.1
WORKDIR /app
COPY requirements.txt requirements.txt
COPY app.ini app.ini
RUN apt-get update && apt-get install -y libpq-dev gcc
RUN pip install -r requirements.txt
RUN pip install regex
RUN python -m nltk.downloader punkt

COPY . .


CMD [ "uwsgi", "app.ini" ]
