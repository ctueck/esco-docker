FROM tomcat:9.0-jdk8

RUN apt-get update && \
	apt-get install -y unzip wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# URL to download ESCO local API
ARG ESCO_DOWNLOAD_URL="https://ec.europa.eu/esco/download//ESCO%20dataset%20-%20v1.1.1%20-%20local_api%20-%20v1.1.1%20-%20zip.zip"
# name of the second, nested ZIP file
ARG ESCO_NESTED_ZIP="ESCO_Local_API_v1.1.1.zip"
# path to the main application directory in the ZIP file
ARG ESCO_LOCAL_API="ESCO_Local_API_v1.1.1/tomcat-esp-api-v03_94/"

# download ESCO local API and copy files in place
# (this is one long RUN statement from download to cleaning up to reduce image size)
RUN cd /tmp && \
	wget --progress=dot:giga -O esco.zip "$ESCO_DOWNLOAD_URL" && \
	unzip esco.zip && \
	unzip "$ESCO_NESTED_ZIP" && \
	cd "$ESCO_LOCAL_API" && \
	mkdir -p /usr/local/tomcat/webapps \
		/usr/local/tomcat/work \
		/usr/local/tomcat/bin && \
	cp -av webapps/fuseki.war /usr/local/tomcat/webapps && \
	cp -av webapps/esco-solr.war /usr/local/tomcat/webapps && \
	cp -av webapps/ROOT.war /usr/local/tomcat/webapps/esco\#api.war && \
	cp -av work/* /usr/local/tomcat/work && \
	cp -av bin/setenv.sh /usr/local/tomcat/bin && \
	rm -rf /tmp/esco.zip "/tmp/$ESCO_NESTED_ZIP" "/tmp/$ESCO_LOCAL_API"

# work-around for a small bug in work/fuseki/configuration/esco-v1_1_1.ttl
# (leading "../" leads one level too far up)
RUN ln -s /usr/local/tomcat/work /usr/local/work

