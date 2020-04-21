set -e

# Change to scripts working directory
cd "$(dirname ${BASH_SOURCE[0]})"

# Defines for script.
IMAGE="beergarden"
CONTAINER_NAME="beergarden"
UI_IMAGE="beergarden_ui"
UI_CONTAINER_NAME="beergarden_ui"
VERSION="1"

# Remove old container if it exists.
docker rm -f ${CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'
docker rm -f ${UI_CONTAINER_NAME} > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'

# Build image if necessary.
docker build -t ${IMAGE} .
docker build -t ${UI_IMAGE} ui/

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
--name=${CONTAINER_NAME} \
-v $(pwd)/..:/beergarden:cached \
${IMAGE}

docker exec -u 0 -ti beergarden bash -c 'cp /beergarden/docker/nginx.conf /etc/nginx/; /etc/init.d/nginx start'

# Jump into docker container.
docker exec -ti beergarden bash
