FROM alpine:latest

RUN apt-get update && apt-get install -y \
    python3 \
    python3-flask \
    python-pip \
    python3-pip \
    python3.6-dev libmysqlclient-dev \


# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

RUN export FLASK_APP=__init__.py

ENTRYPOINT [ "python3" ]

CMD [ "flask run --host=0.0.0.0 --port=8080" ]

