FROM alpine:3.8 AS downloader

ARG NAME="android-studio"
ARG DOWNLOAD_URL="https://dl.google.com/dl/android/studio/ide-zips/3.4.2.0/android-studio-ide-183.5692245-linux.tar.gz"
WORKDIR /tmp

RUN printf "downloading ${NAME} from [%s]...\n" "${DOWNLOAD_URL}" && \
	wget "${DOWNLOAD_URL}" -O "${NAME}.tar.gz" && \
	printf "installing ${NAME}...\n" && \
	tar -xf "${NAME}.tar.gz"

FROM openjdk:8-jdk-slim
LABEL maintainer="docker@seifrox.com"

ARG UID=1000
ARG GID=1000
ARG USER_NAME=user

ADD docker-entrypoint.sh /opt/.run/docker-entrypoint.sh
ADD template-android-studio.sh /opt/.run/template-android-studio.sh
ADD run.sh /opt/.run/run.sh
COPY --from=downloader /tmp/android-studio /opt/android-studio

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENTRYPOINT [ "/opt/.run/docker-entrypoint.sh" ]

RUN printf "disabling openjdk assistive technologies...\n" && \
	sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties && \
	\
	printf "installing packages...\n" && \
	apt-get update && \
	\
	apt-get install -y \
	bash \
	libgtk-3-0 \
	libswt-gtk-3-java \
	libwebkitgtk-3.0-0 \
	ttf-dejavu && \
	\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	\
	printf "user setup...\n" && \
	groupadd -g ${GID} ${USER_NAME} && \
	useradd -u ${UID} -s /bin/bash -m -g ${USER_NAME} ${USER_NAME} && \
	\
	printf "permission setup...\n" && \
	chown -R ${USER_NAME}.${USER_NAME} ${HOME} && \
	chown -R ${USER_NAME}.${USER_NAME} /opt/.run && \
	chmod +x /opt/android-studio/bin/studio.sh && \
	chmod +x /opt/.run/*.sh

USER ${USER_NAME}
ENV EXECUTABLE android-studio
CMD [ "android-studio" ]
VOLUME [ "/home/${USER_NAME}/.m2", "/home/${USER_NAME}/.gradle", "/home/${USER_NAME}/Android/Sdk", "/home/${USER_NAME}/android-studio-workspace" ]
