# alloy

This repository contains the pinned version of [Grafana Alloy] as used in all
cloud environments. In order to update the Docker image, prepare all desired
changes within the `main` branch and create a Github release for the Alloy
version. The responsible [Github Action] will then build and push the image to
the correct [Amazon ECR] upon tag creation. The following environment variables
are required for running the Alloy container.

- `ENVIRONMENT` - the environment name of the scraped deployment infrastructure
- `GRAFANA_CLOUD_API_KEY` - the API key of the Grafana Cloud metrics backend
- `PROMETHEUS_REMOTE_WRITE_URL` - the URL of the Grafana Cloud metrics backend
- `PROMETHEUS_USERNAME` - the basic auth username of the Grafana Cloud metrics backend
- `SERVER_DISCOVERY_HOST` - the host name of the DNS discovery service for the server component
- `SERVER_DISCOVERY_PORT` - the port number of the server components

[Amazon ECR]: https://docs.aws.amazon.com/ecr
[Github Action]: .github/workflows/docker-release.yaml
[Grafana Alloy]: https://grafana.com/docs/alloy/latest
