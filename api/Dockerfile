FROM python:3.11.1
WORKDIR /app
ADD . /app
RUN apt-get update && apt-get install -y libpq-dev gcc
RUN pip install -r requirements.txt
RUN pip install regex
RUN python -m nltk.downloader punkt

CMD [ "uwsgi", "app.ini" ]
