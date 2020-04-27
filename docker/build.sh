set -e

# Change to scripts working directory
cd "$(dirname ${BASH_SOURCE[0]})"

# Defines for script.
IMAGE="beergarden"
CONTAINER_NAME="beergarden"
UI_IMAGE="beergarden_ui"
UI_CONTAINER_NAME="beergarden_ui"
GO_IMAGE="beergarden_go"
GO_CONTAINER_NAME="beergarden_go"
VERSION="1"

# Remove old container if it exists.
docker rm -f ${CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'
docker rm -f ${UI_CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'
docker rm -f ${GO_CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'

# Build image if necessary.
docker build -t ${IMAGE} .
docker build -t ${UI_IMAGE} ui/
docker build -t ${GO_IMAGE} ../api

# Build GO
docker run --rm -it \
--name=${GO_CONTAINER_NAME} \
-v $(pwd)/../api:/app:cached \
${GO_IMAGE}
#docker rm -f ${GO_CONTAINER_NAME}

# Build UI
docker run --rm -it \
--name=${UI_CONTAINER_NAME} \
-v $(pwd)/..:/beergarden:cached \
${UI_IMAGE}
#docker rm -f ${UI_CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'

# Run the container.
docker run -d -it \
-e VERSION=$VERSION \
-p 80:80  \
-p 8080:8080  \
--name=${CONTAINER_NAME} \
-v $(pwd)/..:/beergarden:cached \
${IMAGE}

docker exec -u 0 -ti beergarden bash -c 'cp /beergarden/docker/nginx.conf /etc/nginx/; /etc/init.d/nginx start'
docker exec -ti beergarden bash -c '/beergarden/docker/entry.sh'

# Jump into docker container.
docker exec -ti beergarden bash
