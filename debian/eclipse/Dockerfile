FROM openjdk:8-jre-slim AS downloader

ARG NAME="eclipse"
ARG DOWNLOAD_URL="http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/2019-06/R/eclipse-java-2019-06-R-linux-gtk-x86_64.tar.gz"
WORKDIR /tmp

RUN printf "installing packages...\n" && \
	apt-get update && \
	\
	apt-get install -y \
	wget && \
	\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	\
	printf "downloading ${NAME} from [%s]...\n" "${DOWNLOAD_URL}" && \
	wget "${DOWNLOAD_URL}" -O eclipse.tar.gz && \
	printf "installing ${NAME}...\n" && \
	tar -xf eclipse.tar.gz

RUN chmod +x /tmp/eclipse/eclipse && \
	echo 'installing [DBeaver] plugin...' && \
	/tmp/eclipse/eclipse -application org.eclipse.equinox.p2.director -repository https://dbeaver.io/update/latest/ -installIU org.jkiss.dbeaver.ide.feature.feature.group -tag DBeaver -nosplash && \
	echo 'installing [ANSI Escape in Console] plugin...' && \
	/tmp/eclipse/eclipse -application org.eclipse.equinox.p2.director -repository http://www.mihai-nita.net/eclipse -installIU net.mihai-nita.ansicon.feature.group -tag AnsiConsole -nosplash && \
	echo 'installing [MoreUnit] plugin...' && \
	/tmp/eclipse/eclipse -application org.eclipse.equinox.p2.director -repository https://moreunit.github.io/eclipse-update-site/ -installIU org.moreunit.feature.group,org.moreunit.mock.feature.group,org.moreunit.light.feature.group -tag MoreUnit -nosplash && \
	echo 'installing [SonarLint] plugin...' && \
	/tmp/eclipse/eclipse -application org.eclipse.equinox.p2.director -repository https://eclipse-uc.sonarlint.org -installIU org.sonarlint.eclipse.feature.feature.group -tag SonarLint -nosplash


FROM openjdk:8-jdk-slim
LABEL maintainer="docker@seifrox.com"

ARG UID=1000
ARG GID=1000
ARG USER_NAME=user

ADD docker-entrypoint.sh /opt/.run/docker-entrypoint.sh
ADD template-eclipse.sh /opt/.run/template-eclipse.sh
ADD run.sh /opt/.run/run.sh
COPY --from=downloader /tmp/eclipse /opt/eclipse

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
	chmod +x /opt/eclipse/eclipse && \
	chmod +x /opt/.run/*.sh

USER ${USER_NAME}
ENV EXECUTABLE eclipse
CMD [ "eclipse" ]
VOLUME [ "/home/${USER_NAME}/.m2", "/home/${USER_NAME}/workspace" ]
