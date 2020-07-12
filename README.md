# TEMPLATE_SUBSTITUTE_PROJECT_NAME


## To write

- README.md
- docs
- examples
- test

- cmd
- pkg
- internal
- vendor

(if not golang)
- Dockerfile
- Makefile: vendor, fmt, lint 

## Gitlab Configurations

CICD Variables: GITLAB_API_TOKEN, GITLAB_PRODUCTION_OKD_TOKEN, GITLAB_STAGING_OKD_TOKEN

## Development

You can use docker-compose to run a local copy of the application. Here are useful Make commands:
* `make build` builds Docker image locally.
* `make run` spins up local Docker containers so you can access via web or command line.
* `make test` runs all tests locally.
* `make rsh` spins up a temporary container based on the built image and gives you a bash inside that container.
* `make debug` spins up a temporary container based on the build image with sleep entrypoint, and gives you a bash inside that container to debug in case container stops immediately.

## License

GNU Affero General Public License v3.0, see [LICENSE](LICENSE).