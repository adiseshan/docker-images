#!/bin/bash
set -e

USAGE="export TARGET_IMAGE as IMAGE_NAME:IMAGE_TAG"
REPO_HOST="${REPO_HOST:-devex-dock.artifactory-ha.tmc-stargate.com}"
CONFIGS_DIR="${CONFIGS_DIR:-configs}"

if [ -z "$TARGET_IMAGE" ]
then
    echo "${USAGE}"
    exit 1
fi

cd "${CONFIGS_DIR}/${TARGET_IMAGE//://}" || exit 1

if [ -e revision ]
then
    REVISION_SUFFIX="-$(cat revision)"
fi

if [ -n "$DRY_RUN" ]
then
    ECHO="echo +"
fi

echo ">> Push ${REPO_HOST}/${DOCKER_REGISTRY_ORG}/${TARGET_IMAGE}${REVISION_SUFFIX}"
${ECHO}docker push "${REPO_HOST}/${DOCKER_REGISTRY_ORG}/${TARGET_IMAGE}${REVISION_SUFFIX}"
