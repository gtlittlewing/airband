#!/bin/bash
source ./.env
source ./${APPNAME_SERVER}/${APPNAME_SERVER}.env
TIMESTAMP="date --rfc-3339=seconds"

echo "[start build ${APPNAME_SERVER}]`${TIMESTAMP}`"
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
 --build-arg SOAPYSDR_REPOSITORY="${APP_ARG_SOAPYSDR_REPOSITORY}" \
 --build-arg SOAPYSDR_PROJECT="${APP_ARG_SOAPYSDR_PROJECT}" \
 --build-arg SOAPYRTLSDR_PROJECT="${APP_ARG_SOAPYRTLSDR_PROJECT}" \
 --build-arg SOAPYAIRSPY_PROJECT="${APP_ARG_SOAPYAIRSPY_PROJECT}" \
 --build-arg SOAPYREMOTE_PROJECT="${APP_ARG_SOAPYREMOTE_PROJECT}" \
 --build-arg SOAPYSDR_BRANCH="${APP_ARG_SOAPYSDR_BRANCH}" \
 --build-arg LIMESUITE_REPOSITORY="${APP_ARG_LIMESUITE_REPOSITORY}" \
 --build-arg LIMESUITE_PROJECT="${APP_ARG_LIMESUITE_PROJECT}" \
 --build-arg LIMESUITE_BRANCH="${APP_ARG_LIMESUITE_BRANCH}" \
 --force-rm \
${APPNAME_SERVER}

echo "[finish build ${APPNAME_SERVER}]`${TIMESTAMP}`"
