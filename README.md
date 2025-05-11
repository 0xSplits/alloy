# alloy

This repository contains the pinned version of [Grafana Alloy] as used in all
cloud environments. In order to update the Docker image, prepare all desired
changes within the `main` branch and create a Github release for the Alloy
version. The responsible [Github Action] will then build and push the image to
the correct [Amazon ECR] upon tag creation.

[Amazon ECR]: https://docs.aws.amazon.com/ecr
[Github Action]: .github/workflows/docker-release.yaml
[Grafana Alloy]: https://grafana.com/docs/alloy/latest
