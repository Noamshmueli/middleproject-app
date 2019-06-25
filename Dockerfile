FROM ubuntu:bionic

RUN apt update && \
    apt install python3-flask -y && \
    apt install python-pip -y && \
    apt install python3-pip -y && \
    apt-get install python3.6-dev libmysqlclient-dev -y && \
    pip3 install flask_mysqldb

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

COPY . /app

RUN pip3 install -r requirements.txt

ENV FLASK_APP=__init__.py LANG=C.UTF-8 LC_ALL=C.UTF-8

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=8080" ]
