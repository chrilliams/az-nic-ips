DOCKER_IMAGE_NAME := azip
DOCKER_CONTAINER_NAME := ${DOCKER_IMAGE_NAME}-build-container_$(shell date +"%s")

default: build

build: clean
	docker build -t ${DOCKER_IMAGE_NAME} -f Dockerfile.build .
	docker create --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}
	mkdir -p bin
	docker cp ${DOCKER_CONTAINER_NAME}:/go/bin/azip bin/azip
	-docker rm -f ${DOCKER_CONTAINER_NAME}

clean:
	-docker rm -f ${DOCKER_CONTAINER_NAME}
	-rm bin/azip