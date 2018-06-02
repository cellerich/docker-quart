From alpine:3.7
MAINTAINER cellerich "cello@cello.ch"

# application folder
ENV APP_DIR /app

# update source
RUN apk update && \
	apk add python python3 python3-dev supervisor && \
	pip3 install --upgrade pip && \
	pip3 install Quart gunicorn && \
	mkdir -p ${APP_DIR}/web && \
	mkdir -p ${APP_DIR}/conf && \
	mkdir -p ${APP_DIR}/logs && \
	rm -rf /var/cache/apk/* && \
	echo "files = ${APP_DIR}/conf/*.ini" >> /etc/supervisord.conf

# copy config files
COPY ./app ${APP_DIR}

VOLUME ["${APP_DIR}"]

EXPOSE 5000

CMD ["supervisord", "-c", "/etc/supervisord.conf"]