#!/bin/bash
source ./.env
source ./${APPNAME_ENDPOINT}/${APPNAME_ENDPOINT}.env
TIMESTAMP="date --rfc-3339=seconds"

echo "[start build ${APPNAME_ENDPOINT}]`${TIMESTAMP}`"
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
 --force-rm \
${APPNAME_ENDPOINT}

echo "[finish build ${APPNAME_ENDPOINT}]`${TIMESTAMP}`"
