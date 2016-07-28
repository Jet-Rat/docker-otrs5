FROM ubuntu:16.04

ENV OTRS_VERSION 5.0.10
ENV OTRS_HOME /opt/otrs

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		wget \
	&& wget --progress=bar:force http://ftp.otrs.org/pub/otrs/otrs-${OTRS_VERSION}.tar.gz \
	&& mkdir -p ${OTRS_HOME} \
	&& echo "Extracting OTRS archive otrs-${OTRS_VERSION}.tar.gz" \
	&& tar -xzf otrs-${OTRS_VERSION}.tar.gz -C ${OTRS_HOME} --strip 1 \
	&& echo "Extraction finished" \
	&& rm -rf /var/lib/apt/lists/* otrs-${OTRS_VERSION}.tar.gz

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		apache2 \
		cron \
		libapache2-mod-perl2 \
		libarchive-zip-perl \
		libauthen-sasl-perl \
		libcrypt-eksblowfish-perl \
		libcrypt-ssleay-perl \
		libdbd-mysql-perl \
		libdbi-perl \
		libdigest-md5-perl \
		libio-socket-ssl-perl \
		libjson-xs-perl \
		libmail-imapclient-perl \
		libmime-base64-perl \
		libnet-dns-perl \
		libnet-ldap-perl \
		libtemplate-perl \
		libtext-csv-xs-perl \
		libtimedate-perl \
		libxml-libxml-perl \
		libxml-libxslt-perl \
		libxml-parser-perl \
		libyaml-libyaml-perl \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV ENTRYPOINT_FILE /usr/local/sbin/entrypoint.sh

RUN a2enmod perl filter deflate headers \
	&& ln -s ${OTRS_HOME}/scripts/apache2-httpd.include.conf /etc/apache2/sites-available/zzz_otrs.conf \
	&& a2ensite zzz_otrs


COPY Config.pm ${OTRS_HOME}/Kernel/Config.pm
COPY entrypoint.sh ${ENTRYPOINT_FILE}

RUN useradd -G www-data -d ${OTRS_HOME} otrs \

	&& cp /opt/otrs/var/cron/aaa_base.dist /opt/otrs/var/cron/aaa_base \
	&& cp /opt/otrs/var/cron/otrs_daemon.dist /opt/otrs/var/cron/otrs_daemon \
	&& /opt/otrs/bin/Cron.sh start otrs \
	
	&& ${OTRS_HOME}/bin/otrs.SetPermissions.pl --web-group=otrs \
	&& chown www-data:www-data ${ENTRYPOINT_FILE} \
	&& chmod 554 ${ENTRYPOINT_FILE} \
	&& ln -s ${ENTRYPOINT_FILE} /entrypoint.sh

VOLUME /opt/otrs

EXPOSE 80
CMD ["entrypoint.sh"]
