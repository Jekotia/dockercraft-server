#! /bin/bash

case $1 in
	vanilla)
		SOURCE_URL=https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar
		OUTPUT_FILE=${DATA}minecraft_server.jar
		RECORD_FILE=${DATA}minecraft_server.txt
	;;
	paper)
		jq
		$server_type=vanilla,paper
		https://papermc.io/api/v1/paper/${mcversion}/${build}
		$MC_version/
		$build/
		$autoupdate=false
	;;
esac

echo "Downloading jar file from ${SOURCE_URL}"
curl -o ${OUTPUT_FILE} ${SOURCE_URL} \
&& cat > ${RECORD_FILE} <<- EOM
CURRENT_ACQUIRE_DATE="$(date --rfc-3339=seconds)"
CURRENT_SERVER_TYPE="${SERVER_TYPE}"
CURRENT_MC_VERSION="${MC_VERSION}"
CURRENT_SOURCE_URL="${SOURCE_URL}"
CURRENT_OUTPUT_FILE="${OUTPUT_FILE}"
EOM
