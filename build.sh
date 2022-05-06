#!/bin/bash
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --no-cache)
      NO_CACHE="$1"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

./build.soapysdr-server.sh ${NO_CACHE} && \
./build.rtlsdr-airband.sh ${NO_CACHE} && \
./build.ffmpeg-transrelay-server.sh ${NO_CACHE} && \
./build.icecast2-server.sh ${NO_CACHE}
