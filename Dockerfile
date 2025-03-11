FROM ubuntu:focal

ENV WORKSPACE_DIR=/workspace

ENV JAVA_VERSION=17
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64

ENV JAVAFX_VERSION=21.0.5
ENV JAVAFX_HOME=/usr/local/javafx-sdk-${JAVAFX_VERSION}
ENV DISPLAY=:0

ENV TOMCAT_MAJOR=10
ENV TOMCAT_VERSION=10.1.39
ENV TOMCAT_SHA512=e29c4d0e26295d64dfeee399e7719b5baac2682ac0e7b53702f26d630fea761f93ddf60674dfe87c41ddd9b79d4938a6a533a280bb3d7fb83c2a1b7cd5da6b09
ENV TOMCAT_HOME=/usr/local/apache-tomcat-${TOMCAT_VERSION}

ENV CATALINA_HOME=/usr/local/apache-tomcat-${TOMCAT_VERSION}
ENV PATH=$CATALINA_HOME/bin:/workspace/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR=$CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR

# see https://www.apache.org/dist/tomcat/tomcat-10/KEYS
# see also "versions.sh" (https://github.com/docker-library/tomcat/blob/master/versions.sh)
ENV GPG_KEYS="5C3C5F3E314C866292F359A8F3AD5C94A67F707E A9C5DF4D22E99998D9875A5110C01C5A2F6059E7"

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		jq \
		curl \
		wget \
		unzip \
		xorg \
		xauth \
		xserver-xorg-video-dummy \
		openjdk-${JAVA_VERSION}-jre \
		openjdk-${JAVA_VERSION}-jdk \
	; \
	rm -rf /var/lib/apt/lists/* ; \
	wget https://download2.gluonhq.com/openjfx/${JAVAFX_VERSION}/openjfx-${JAVAFX_VERSION}_linux-x64_bin-sdk.zip ; \
	unzip openjfx-${JAVAFX_VERSION}_linux-x64_bin-sdk.zip -d /usr/local ; \
	rm -f openjfx-${JAVAFX_VERSION}_linux-x64_bin-sdk.zip ; \
	wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip ; \
	unzip apache-tomcat-${TOMCAT_VERSION}.zip -d /usr/local ; \
	rm -f apache-tomcat-${TOMCAT_VERSION}.zip ; \
	chmod -R +w /usr/local/apache-tomcat-${TOMCAT_VERSION}/webapps ; \
	chmod +x /usr/local/apache-tomcat-${TOMCAT_VERSION}/bin/*.sh

RUN set -eux; \
	apt-get update ; \
	apt-get install -y git ; \
    git clone --no-checkout --depth=1 https://github.com/fripouillon/R401.git ; \
    mv R401 ${WORKSPACE_DIR} ; \
    cd ${WORKSPACE_DIR} ; \
    git checkout main -- bin ; \
    git checkout main -- 0-WebTest
 
RUN echo 'export PS1="\u@r401-unify> "' >> /root/.bashrc

WORKDIR ${WORKSPACE_DIR}
ENTRYPOINT update.sh && deploy.sh 0-WebTest --no-restart && catalina.sh start && /bin/bash
