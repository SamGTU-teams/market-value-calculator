API_IMAGE_NAME=ghcr.io/samgtu-teams/market-calculator-api
API_CONTAINER_NAME=calculator-api
API_PORT=8080
API_TAG=local

CLIENT_IMAGE_NAME=ghcr.io/samgtu-teams/market-calculator-client
CLIENT_CONTAINER_NAME=calculator-client
CLIENT_PORT=8081
CLIENT_TAG=local

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
