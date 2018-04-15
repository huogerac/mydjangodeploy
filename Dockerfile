FROM python:3-slim

RUN apt-get update && apt-get install -y \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

COPY . /app
WORKDIR /app

ENV PYTHONPATH /app

RUN cd /app && ./manage.py migrate

CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000", "--settings=djangodeploy.settings" ]
