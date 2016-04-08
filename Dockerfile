FROM java:openjdk-8-jre

MAINTAINER Eugene Volchek <evolchek@klika-tech.com>

ENV UPSOURCE_VERSION 2.5.4995
VOLUME /opt/Upsource/conf
VOLUME /opt/Upsource/data
VOLUME /opt/Upsource/logs
VOLUME /opt/Upsource/backups
VOLUME /opt/Upsource/temp
WORKDIR /opt
RUN mkdir -p /home/1001 \
	&& groupadd -g 1001 1001 \
	&& useradd -u 1001 -g 1001 -d /home/1001 1001 \
	&& chown -R 1001:1001 /home/1001 \
	&& wget -nv http://download.jetbrains.com/upsource/upsource-$UPSOURCE_VERSION.zip \
	&& unzip upsource-$UPSOURCE_VERSION.zip \
	&& rm -rf upsource-$UPSOURCE_VERSION.zip \
	&& chown -R 1001:1001 Upsource \
	&& chmod -R 777 /opt/Upsource/* \
	&& chmod -R 777 /opt/Upsource/conf
USER 1001
EXPOSE 8080
WORKDIR /opt/Upsource
CMD ["bin/upsource.sh", "run"]
