NAME = TEMPLATE_SUBSTITUTE_PROJECT_NAME


### vars
SHELL = bash
IMAGE = $(NAME):local
COMPOSE = IMAGE=$(IMAGE) docker-compose
VERSION ?= $(shell svu next)

### commands
vendor:
	go mod download && go mod tidy && go mod verify

lint: vendor
	go fmt ./...
	go vet ./...
	golangci-lint run ./...

test: lint
	go test ./... -race -covermode=atomic -coverprofile=coverage.out
	go tool cover -html=coverage.out -o coverage.html

build: test
	go build -o bin/main main.go

run: test
	go run main.go


###### docker images
docker-build:
	sudo podman build -t $(IMAGE) .

docker-login:
	sudo podman login ${REG} -u ${REG_USER} -p ${REG_PASSWORD}

docker-push:
	sudo podman push $(IMAGE)

docker-run:
	$(COMPOSE) up --force-recreate

docker-clean: build
	$(COMPOSE) down

docker-rsh:
	$(COMPOSE) exec --user root $(NAME) sh -c 'bash || sh'
	$(RUN) bash

docker-debug:
	$(COMPOSE) run --entrypoint='sh' $(NAME) -c 'tail -f /dev/null'


#############
##@ Release


.PHONY: changelog
changelog: build ## Generate changelog
	echo $(VERSION)
	git-chglog --next-tag $(VERSION) -o CHANGELOG.md

.PHONY: release
release: changelog   ## Release a new tag
	git add CHANGELOG.md
	git commit -m "chore: update changelog for $(VERSION)"
	git tag $(VERSION) -m "$(VERSION)"
	git push origin main $(VERSION)

