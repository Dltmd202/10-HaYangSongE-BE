# pull official base image
FROM python:3.8.0-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories

RUN apk update
RUN  apk add postgresql-dev gcc python3-dev musl-dev zlib-dev jpeg-dev #--(5.2)
RUN  apk add --no-cache python3-dev libffi-dev gcc && pip3 install --upgrade pip
RUN  apk add gcc musl-dev python3-dev libffi-dev openssl-dev
RUN apk add chromium
RUN apk add chromium-chromedriver


COPY . /usr/src/app/
# install dependencies
RUN pip install --upgrade pip
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN pip install cryptography
RUN pip install -r requirements.txt
RUN pip install -U selenium