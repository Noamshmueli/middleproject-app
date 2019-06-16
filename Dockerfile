FROM alpine:latest

RUN apk update && \
    apk add  python3 

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

COPY ./__init__.py /app/__init__.py

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

RUN export FLASK_APP=__init__.py

ENTRYPOINT [ "python3" ]

CMD [ "flask run --host=0.0.0.0 --port=8080" ]

