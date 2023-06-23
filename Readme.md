# CTFd Helm chart

This Helm charts provides a straightforward way to deploy a CTFd instance on Kubernetes. CTFd is a capture the flag framework with theming and plugin support. CTFd is developed on [GitHub](https://github.com/CTFd/CTFd) under the Apache2 license.

This Helm chart was originally developed by [HackademINT](https://www.hackademint.org) for internal use and was first used in production for the 2023 edition of the [404 CTF](https://www.404ctf.fr).

This chart is inspired by [Bitnami](https://bitnami.com/)'s [high quality charts](https://github.com/bitnami/charts/tree/main), and uses Bitnami packages for its dependencies.

## State of this project

While this chart can, and has been used in production successfully, it is still an ongoing project and will not work in all configurations. Upload support is especially limited, and the only reliable solution at present is to use an external S3 bucket.

## TL;DR

```console
helm install my-release oci://registry-1.docker.io/hackademint/ctfd
```