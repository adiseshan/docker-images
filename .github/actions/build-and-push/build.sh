#!/bin/bash
set -e

COPY_IMAGE_CONFIG_FILE=copy_image.json
USAGE="export TARGET_IMAGE as IMAGE_NAME:IMAGE_TAG"
PLATFORM="${PLATFORM:-linux/x86_64}"
# TARGET_IMAGE=$1
DOCKER_REGISTRY_ORG="${DOCKER_REGISTRY_ORG:-commons}"
REPO_HOST="${REPO_HOST:-registry.hub.docker.com}"
CONFIGS_DIR="${CONFIGS_DIR:-configs}"

if [ -z "$TARGET_IMAGE" ] || ! echo "${TARGET_IMAGE}" | grep -E "[^:]+:[^:]+"
then
    echo "${USAGE}"
    exit 1
fi

if [ ! -d "${CONFIGS_DIR}/${TARGET_IMAGE//://}" ]
then
    echo "${TARGET_IMAGE} is not found"
    exit 1
fi

cd "${CONFIGS_DIR}/${TARGET_IMAGE//://}" || exit 1

if [ -e Dockerfile ] && [ -e $COPY_IMAGE_CONFIG_FILE ]
then
    echo "Dockerfile and $COPY_IMAGE_CONFIG_FILE are exclusive"
    exit 1
fi

if [ -n "$DRY_RUN" ]
then
    ECHO="echo +"
fi

# Build docker image if Dockerfile exists
if [ -e Dockerfile ]
then
    if [ -e revision ]
    then
        REVISION_SUFFIX="-$(cat revision)"
    fi
    echo ">> Build image ${REPO_HOST}/${DOCKER_REGISTRY_ORG}/${TARGET_IMAGE}${REVISION_SUFFIX} from ${TARGET_IMAGE//://}/Dockerfile for ${PLATFORM}"
    export DOCKER_BUILDKIT=1
    # shellcheck disable=SC2086
    ${ECHO}docker build --network host --platform "${PLATFORM}" --tag "${REPO_HOST}/${DOCKER_REGISTRY_ORG}/${TARGET_IMAGE}${REVISION_SUFFIX}" .
fi

# Copy docker image if COPY_IMAGE_CONFIG_FILE exists
if [ -e $COPY_IMAGE_CONFIG_FILE ]
then
    FROM=$(jq -r .from $COPY_IMAGE_CONFIG_FILE)
    TO=$(jq -r .to $COPY_IMAGE_CONFIG_FILE)

    echo ">> Copy image $TO from $FROM for ${PLATFORM}"
    # shellcheck disable=SC2086
    ${ECHO}docker pull --platform "${PLATFORM}" $FROM
    # shellcheck disable=SC2086
    ${ECHO}docker tag $FROM $TO
fi
