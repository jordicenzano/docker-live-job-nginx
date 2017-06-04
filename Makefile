# DOCKER TASKS
# Build the container

# Import docker repo (docker hub creds)
include ./secrets/docker-creds

DOCKER_IMAGE_NAME = livejob
DOCKER_IMAGE_VERSION = 1.0

# Import docker repo (docker hub creds)

.PHONY: build run tag_latest push push_latest last_built_date shell

build: Dockerfile nginx.conf
	docker build -t $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) --rm .

run:
	docker run --rm -p 1935:1935 -p 8080:8080 $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

tag_latest:
	docker tag $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):latest

push:
	docker login -u $(DOCKER_REPO_USER) -p $(DOCKER_REPO_PASS)
	docker push $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)
	docker logout

push_latest:
	docker login -u $(DOCKER_REPO_USER) -p $(DOCKER_REPO_PASS)
	docker push $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):latest
	docker logout

last_built_date:
	docker inspect -f '{{ .Created }}' $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

shell:
	docker run --rm -i -t -p 1935:1935 -p 8080:8080 $(DOCKER_REPO_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) /bin/bash

default: build
