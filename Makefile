API_IMAGE_NAME=ghcr.io/samgtu-teams/market-calculator-api
API_CONTAINER_NAME=calculator-api
API_PORT=8080

api-build:
	cd api; ./gradlew build;

api-docker: api-build
	docker build --tag $(API_IMAGE_NAME):local api/

api-run-docker: api-rm-docker
	docker run -p $(API_PORT):80 -d --name $(API_CONTAINER_NAME) $(API_IMAGE_NAME):local

api-docker-build-run: api-docker api-run-docker

api-stop-docker:
	docker stop $(API_CONTAINER_NAME) || echo 1

api-rm-docker: api-stop-docker
	docker rm -f $(API_CONTAINER_NAME) || echo 1
