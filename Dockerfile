FROM alpine:latest

RUN apk update && \
    apk add  python3 

RUN ["apt-get", "update"]
RUN ["apt-get", "upgrade", "-y", "--fix-missing"]
RUN apt install python3-flask -y
RUN sudo apt install python-pip -y
RUN sudo apt install python3-pip -y
RUN sudo apt-get install python3.6-dev libmysqlclient-dev -y
RUN sudo pip install flask_mysqldb

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

COPY . /app

RUN export FLASK_APP=__init__.py

RUN pip3 install -r requirements.txt

RUN export FLASK_APP=__init__.py

CMD [ "flask run --host=0.0.0.0 --port=8080" ]

