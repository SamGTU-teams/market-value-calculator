API_IMAGE_NAME=ghcr.io/samgtu-teams/market-calculator-api
API_CONTAINER_NAME=calculator-api
API_PORT=8080
API_TAG=local

CLIENT_IMAGE_NAME=ghcr.io/samgtu-teams/market-calculator-client
CLIENT_CONTAINER_NAME=calculator-client
CLIENT_PORT=8081
CLIENT_TAG=local

api-build:
	cd api; ./gradlew build;

api-docker: api-build
	docker build --tag $(API_IMAGE_NAME):${API_TAG} api/

api-run-docker: api-rm-docker
	docker run -p $(API_PORT):80 -d --name $(API_CONTAINER_NAME) $(API_IMAGE_NAME):${API_TAG}

api-docker-build-run: api-docker api-run-docker

api-stop-docker:
	docker stop $(API_CONTAINER_NAME) || echo 1

api-rm-docker: api-stop-docker
	docker rm -f $(API_CONTAINER_NAME) || echo 1

api-image-rm-docker: api-rm-docker
	docker rmi $(API_IMAGE_NAME):${API_TAG} || echo 1


client-dependencies:
	cd client; yarn install --frozen-lockfile;

client-build: client-dependencies
	cd client; yarn build;

client-docker:
	docker build --tag $(CLIENT_IMAGE_NAME):${CLIENT_TAG} client/

client-run-docker: client-rm-docker
	docker run -p $(CLIENT_PORT):80 -d --name $(CLIENT_CONTAINER_NAME) $(CLIENT_IMAGE_NAME):${CLIENT_TAG}

client-docker-build-run: client-docker client-run-docker

client-stop-docker:
	docker stop $(CLIENT_CONTAINER_NAME) || echo 1

client-rm-docker: client-stop-docker
	docker rm -f $(CLIENT_CONTAINER_NAME) || echo 1

client-image-rm-docker: client-rm-docker
	docker rmi $(CLIENT_IMAGE_NAME):${CLIENT_TAG} || echo 1


all-image-rm-docker: api-image-rm-docker client-image-rm-docker
