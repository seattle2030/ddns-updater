FROM ubuntu:22.04
MAINTAINER dockerhub@seattle2030.net

RUN apt-get update && apt-get -y install cron curl

COPY goDaddy-cron /etc/cron.d/goDaddy-cron
RUN chmod 0644 /etc/cron.d/goDaddy-cron

RUN crontab /etc/cron.d/goDaddy-cron

RUN touch /var/log/cron.log

COPY ./GoDaddy.sh ./GoDaddy.sh
COPY ./run.sh ./run.sh
COPY ./env-guard.sh ./env-guard.sh

RUN chmod +x *.sh

ENTRYPOINT ["./run.sh"]


