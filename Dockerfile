FROM python:3.7-alpine
MAINTAINER EZ Turn

# recommended to run pyton in unbuffered mode in docker
ENV PYTHONUNBUFFERED 1

# copy local requirements.txt into vm /requirements.txt, then install
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache git
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# make /app directory on vm, cd into it and copy local ./app directory into vm /app
RUN mkdir /app
WORKDIR /app
COPY ./ /app

# create new user named user.  -D means user gets no home directory
RUN adduser -D user
USER user
