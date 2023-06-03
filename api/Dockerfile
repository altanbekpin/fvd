FROM python:3.11.1
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
CMD [ "uwsgi", "app.ini" ]