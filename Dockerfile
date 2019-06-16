FROM alpine:latest

RUN apk update && \
    apk add python3 && \
    apt install python3-flask && \
    apt install python-pip && \
    apt install python3-pip && \
    apt-get install python3.6-dev libmysqlclient-dev && \

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

RUN export FLASK_APP=__init__.py

ENTRYPOINT [ "python3" ]

CMD [ "flask run --host=0.0.0.0 --port=8080" ]

