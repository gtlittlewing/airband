#!/bin/bash
if [ -z "${UDP_PORT}" ]; then
  UDP_PORT="61000"
fi

if [ -z "${ICE_GENRE}" ]; then
  ICE_GENRE="GENRE HERE"
fi

if [ -z "${ICE_NAME}" ]; then
  ICE_NAME="NAME HERE"
fi

if [ -z "${ICE_DESCRIPTION}" ]; then
  ICE_DESCRIPTION="DESCRIPTION HERE"
fi

if [ -z "${ICE_MOUNTPOINT}" ]; then
  ICE_MOUNTPOINT="MOUNTPOINT"
fi

if [ -z "${ICE_USERNAME}" ]; then
  ICE_USERNAME="source"
fi

if [ -z "${ICE_PASSWORD}" ]; then
  ICE_PASSWORD="icecast2-server-password"
fi

if [ -z "${ICE_HOSTNAME}" ]; then
  ICE_HOSTNAME="icecast2-server"
fi

if [ -z "${ICE_PORT}" ]; then
  ICE_PORT="60000"
fi


ffmpeg \
-f f32le \
-codec:a pcm_f32le \
-ar 8000 \
-ac 2 \
-i "udp://0.0.0.0:${UDP_PORT}" \
-f opus \
-codec:a libopus \
-b:a 64k \
-content_type "audio/ogg" \
-ice_genre "${ICE_GENRE}" \
-ice_name "${ICE_NAME}" \
-ice_description "${ICE_DESCRIPTION}" \
"icecast://${ICE_USERNAME}:${ICE_PASSWORD}@${ICE_HOSTNAME}:${ICE_PORT}/${ICE_MOUNTPOINT}"
