# TEMPLATE_SUBSTITUTE_PROJECT_NAME


## TODO
### To write

- README.md
- docs
- examples
- test

- cmd
- pkg
- internal



### Github Configuration

- description
- tags
- setting > security > security alerts enabled
- setting > security > dependabot update enabled
- protect main: no one
- require resolved discussion
- required pipeline pass

### Gitlab Configurations

- creat API token
- CICD Variables: GITLAB_API_TOKEN, GITLAB_PRODUCTION_OKD_TOKEN, GITLAB_STAGING_OKD_TOKEN
- master: protected: no one
- pipeline must suceed
- Jira integration?


TODO: description

## Development

You can use docker-compose to run a local copy of the application. Here are useful Make commands:
* `make build` builds Docker image locally.
* `make run` spins up local Docker containers so you can access via web or command line.
* `make test` runs all tests locally.
* `make rsh` spins up a temporary container based on the built image and gives you a bash inside that container.
* `make debug` spins up a temporary container based on the build image with sleep entrypoint, and gives you a bash inside that container to debug in case container stops immediately.

## Security

### Reporting security vulnerabilities

If you find a security vulnerability or any security related issues, please DO NOT file a public issue, instead send your report privately to TODO@gmail.com. Security reports are greatly appreciated and we will publicly thank you for it.

For more info please see [here](SECURITY.md).

## License

GNU Affero General Public License v3.0, see [LICENSE](LICENSE).
