#! /bin/bash

if [ -z ${DATA+x} ]; then
	export DATA=./testfiles/
	mkdir -p $DATA
	cd $DATA
fi

if [[ "${MANUAL_JAR}" == "false" ]] ; then
	echo "MANUAL_JAR=false"
	SERVERJAR="${DATA}minecraft_server.jar"
	if [ -z ${SERVER_TYPE+x} ] ; then
		echo "SERVER_TYPE not set. Exiting."
		exit 1
	elif [[ "${SERVER_TYPE}" == "vanilla" ]] ; then
		echo "SERVER_TYPE=vanilla"
		${SCRIPTS}get-jar.sh vanilla
	elif [[ "${SERVER_TYPE}" == "paper" ]] ; then
		echo "SERVER_TYPE=paper"
		${SCRIPTS}get-jar.sh paper
	fi
elif [[ "${MANUAL_JAR}" == "true" ]] ; then
	echo "MANUAL_JAR=true"
	SERVERJAR="${DATA}${JARFILE}"
fi

if [ -z ${JVM_ARGUMENTS+x} ] ; then
	echo "JVM_ARGUMENTS is not set. Using defaults."
	SERVERARGS="-Xms${SERVER_MEMORY} -Xmx${SERVER_MEMORY} -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs"
else
	echo "JVM_ARGUMENTS set."
	SERVERARGS=${JVM_ARGUMENTS}
fi

echo "Writing eula file"
echo "eula=true" > eula.txt

echo "Starting server..."
exec java ${SERVERARGS} -jar ${SERVERJAR} nogui
