#->	CHECK AGAINST https://www.fromlatest.io/#/

FROM	ubuntu

ENV	SRV=/minecraft/
ENV	DATA=${SRV}data/
ENV	SCRIPTS=${SRV}scripts/

ENV	SRV_USER=minecraft \
	SRV_UID=1000

ENV	SRV_GROUP=${SRV_USER} \
	SRV_GID=${SRV_UID}

#-> INSTALL DEPENDENCIES
RUN	apt-get update \
	&& apt-get install -y \
		curl \
		jq \
		openjdk-8-jre-headless \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

#-> SETUP THE STANDARD USER AT UID:GID ${SRV_UID}:${SRV_GID}
RUN	groupadd \
		-g ${SRV_GID} \
		${SRV_GROUP} \
	&& useradd \
		--create-home \
		--home-dir ${SRV} \
		--shell /bin/bash \
		--gid ${SRV_GID} \
		--uid ${SRV_UID} \
		${SRV_USER}

#-> SETUP SERVER
USER	${SRV_USER}
WORKDIR	${SRV}
RUN	mkdir -p ${DATA} ${SCRIPTS}

COPY	--chown=1000:1000 "scripts/*" "${SCRIPTS}"

WORKDIR	${DATA}

VOLUME	${DATA}

ENTRYPOINT	[ "/minecraft/scripts/entrypoint.sh" ]
