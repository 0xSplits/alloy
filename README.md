# alloy

This repository contains the pinned Docker version of [Grafana Alloy] as used in all
cloud environments.

### Configuration

All configuration and processing is defined in [config.alloy](./config.alloy).
We use DNS for service discovery to scrape targets dynamically. We apply certain
relabelling operations to streamline metric labels before storing them in
Grafana Cloud. The following environment variables are required for running the
Alloy container.

- `ENVIRONMENT` - the environment name of the scraped deployment infrastructure
- `GRAFANA_CLOUD_API_KEY` - the API key of the Grafana Cloud metrics backend
- `PROMETHEUS_REMOTE_WRITE_URL` - the URL of the Grafana Cloud metrics backend
- `PROMETHEUS_USERNAME` - the basic auth username of the Grafana Cloud metrics backend
- `SERVER_DISCOVERY_HOST` - the host name of the DNS discovery service for the server component
- `SERVER_DISCOVERY_PORT` - the port number of the server components

### Releases

In order to update the Docker image, prepare all desired changes within the
`main` branch and create a Github release for the pinned Alloy version. The
release tag should align with the pinned Alloy version in [Semver Format],
following a hyphen and the short Git SHA of the release commit. Creating the
Github release triggers the responsible [Github Action] to build and push the
Docker image to the configured [Amazon ECR].

```
v1.8.3-ffce1e2
```

[Amazon ECR]: https://docs.aws.amazon.com/ecr
[Github Action]: .github/workflows/docker-release.yaml
[Grafana Alloy]: https://grafana.com/docs/alloy/latest
[Semver Format]: https://semver.org
