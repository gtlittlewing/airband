#!/bin/bash
source ./.env
source ./${APPNAME_CLIENT}/${APPNAME_CLIENT}.env
TIMESTAMP="date --rfc-3339=seconds"

echo "[start build ${APPNAME_CLIENT}]`${TIMESTAMP}`"
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

docker compose down

docker compose build \
 ${NO_CACHE} \
 --build-arg RTLSDR_Airband_REPOSITORY="${APP_ARG_RTLSDR_Airband_REPOSITORY}" \
 --build-arg RTLSDR_Airband_PROJECT="${APP_ARG_RTLSDR_Airband_PROJECT}" \
 --build-arg RTLSDR_Airband_BRANCH="${APP_ARG_RTLSDR_Airband_BRANCH}" \
 --force-rm \
${APPNAME_CLIENT}

echo "[finish build ${APPNAME_CLIENT}]`${TIMESTAMP}`"
