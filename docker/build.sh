set -e

# Change to scripts working directory
cd "$(dirname ${BASH_SOURCE[0]})"

# Defines for script.
IMAGE="beergarden"
CONTAINER_NAME="beergarden"
VERSION="1"

# Remove old container if it exists.
docker rm -f beergarden > /dev/null 2>&1 && echo 'removed container' || echo 'nothing to remove'

# Build image if necessary.
docker build -t beergarden .

# Run the container.
docker run -d -it \
-e VERSION=$VERSION \
--name=${CONTAINER_NAME} \
-v $(pwd)/..:/beergarden:cached \
${IMAGE}

# Jump into docker container.
docker exec -u 0 -ti beergarden bash
