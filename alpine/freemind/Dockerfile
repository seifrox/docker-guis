FROM alpine:3.8 AS downloader

ARG DOWNLOAD_URL="https://sourceforge.net/projects/freemind/files/freemind/1.0.1/freemind-bin-max-1.0.1.zip/download"
WORKDIR /tmp

ARG NAME="freemind"

RUN printf "downloading ${NAME} from [%s]...\n" "${DOWNLOAD_URL}" && \
	wget "${DOWNLOAD_URL}" -O freemind.zip && \
	printf "extracting ${NAME}...\n" && \
	mkdir ${NAME} && \
	unzip ${NAME}.zip -d ${NAME}

FROM openjdk:8-jre-alpine
LABEL maintainer="docker@seifrox.com"

ARG UID=1000
ARG GID=1000
ARG USER_NAME=user

ADD docker-entrypoint.sh /opt/.run/docker-entrypoint.sh
ADD template-freemind.sh /opt/.run/template-freemind.sh
ADD run.sh /opt/.run/run.sh
COPY --from=downloader /tmp/freemind /opt/freemind

ENTRYPOINT [ "/opt/.run/docker-entrypoint.sh" ]
ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}

RUN printf "installing packages...\n" && \
	apk add --no-cache \
	bash \
	gtk+3.0 \
	libcanberra-gtk3 \
	ttf-dejavu && \
	\
	printf "user setup...\n" && \
	addgroup -g ${GID} ${USER_NAME} && \
	adduser -u ${UID} -s /bin/bash -G ${USER_NAME} -D ${USER_NAME} && \
	\
	printf "permission setup...\n" && \
	chown -R ${USER_NAME}.${USER_NAME} ${HOME} && \
	chown -R ${USER_NAME}.${USER_NAME} /opt/.run && \
	chmod +x /opt/.run/*.sh && \
	chmod +x /opt/freemind/*.sh

USER ${USER_NAME}
ENV EXECUTABLE "freemind"
CMD [ "freemind" ]
