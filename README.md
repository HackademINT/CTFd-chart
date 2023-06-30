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

## Parameters

### CTFd configuration parameters

| Name                                     | Description                                                                                                             | Value                 |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | --------------------- |
| `security.sessionCookie.httpOnly`        | Value of the HttpOnly flag for session cookies                                                                          | `true`                |
| `security.sessionCookie.sameSite`        | Value of the SameSite parameter of session cookies                                                                      | `Lax`                 |
| `security.permanentSessionLifetime`      | The Flask session lifetime, in seconds                                                                                  | `604800`              |
| `mail.addressFrom`                       | A source address for sent emails                                                                                        | `noreply@example.com` |
| `mail.smtp.enabled`                      | Enable to send emails through an SMTP server                                                                            | `false`               |
| `mail.smtp.server`                       | Address of the SMTP server                                                                                              | `""`                  |
| `mail.smtp.port`                         | Port of the SMTP                                                                                                        | `465`                 |
| `mail.smtp.useAuth`                      | Whether CTFd should authenticate to the SMTP server                                                                     | `false`               |
| `mail.smtp.username`                     | SMTP username for authentication                                                                                        | `""`                  |
| `mail.smtp.password`                     | SMTP password for authentication                                                                                        | `""`                  |
| `mail.smtp.tls`                          | Use TLS to communicate with the SMTP server                                                                             | `true`                |
| `mail.smtp.ssl`                          | Use SSL to communicate with the SMTP server                                                                             | `false`               |
| `mail.smtp.addressSender`                | SMTP SENDER field value                                                                                                 | `""`                  |
| `mail.smtp.existingSecret`               | Name of an existing secret with smtpUsername and smtpPassword keys                                                      | `""`                  |
| `mail.mailgun.enabled`                   | Enable to send emails through a mailgun API                                                                             | `false`               |
| `mail.mailgun.apiKey`                    | A mailgun API key                                                                                                       | `""`                  |
| `mail.mailgun.baseUrl`                   | Base url for the mailgun API                                                                                            | `""`                  |
| `mail.mailgun.existingSecret`            | Name of an existing secret with a mailgunApiKey key                                                                     | `""`                  |
| `logFolder`                              | A folder where CTFd should store logs for submissions, registrations and logins                                         | `""`                  |
| `optional.reverseProxy`                  | Whether CTFd should trust X-Forwarded headers. Checkout the CTFd documentation for more details on the possible values. | `true`                |
| `optional.themeFallback`                 | Whether CTFd should fallback to the core theme for missing resources                                                    | `true`                |
| `optional.swaggerUi`                     | Whether to enable the swagger endpoint at /api/v1                                                                       | `false`               |
| `optional.updateCheck`                   | Whether to check for updates                                                                                            | `true`                |
| `optional.serverSentEvents`              | Whether to use server sent event notifications                                                                          | `true`                |
| `optional.htmlSanitization`              | Whether CTFd should sanitize html content                                                                               | `false`               |
| `optional.sqlAlchemy.trackModifications` | Leave disabled to save memory                                                                                           | `false`               |
| `optional.sqlAlchemy.maxOverflow`        | SqlAlchemy max overflow engine setting                                                                                  | `""`                  |
| `optional.sqlAlchemy.poolPrePing`        | SqlAlchemy pool pre ping engine setting                                                                                 | `""`                  |
| `optional.safeMode`                      | If enabled, CTFd will not load any plugins                                                                              | `false`               |
| `oauth.enabled`                          | Whether to enable MajorLeagueCyber integration                                                                          | `false`               |
| `oauth.clientId`                         | MajorLeagueCyber oauth client ID                                                                                        | `""`                  |
| `oauth.clientSecret`                     | MajorLeagueCyber oauth client secret                                                                                    | `""`                  |

### CTFd deployment basic parameters

| Name                 | Description                                                          | Value                     |
| -------------------- | -------------------------------------------------------------------- | ------------------------- |
| `image.image`        | Full container image path for the CTFd deployment                    | `ghcr.io/ctfd/ctfd:3.5.3` |
| `image.pullSecret`   | A pull secret name for the CTFd image                                | `""`                      |
| `image.pullPolicy`   | CTFd image pull policy                                               | `IfNotPresent`            |
| `httpPort`           | The http port the CTFd container listens on                          | `8000`                    |
| `replicaCount`       | Number of replicas for the CTFd deployment                           | `1`                       |
| `command`            | Override default container command (useful when using custom images) | `[]`                      |
| `args`               | Override default container args (useful when using custom images)    | `[]`                      |
| `extraEnvVars`       | Array with extra environment variables to add to the CTFd container  | `[]`                      |
| `extraEnvVarsCM`     | Name of existing ConfigMap containing extra env vars                 | `""`                      |
| `extraEnvVarsSecret` | Name of existing Secret containing extra env vars                    | `""`                      |

### CTFd deployment security contexts

| Name                                                | Description                                           | Value            |
| --------------------------------------------------- | ----------------------------------------------------- | ---------------- |
| `podSecurityContext.enabled`                        | Enabled CTFd pods' Security Context                   | `true`           |
| `podSecurityContext.fsGroup`                        | Set CTFd pod's Security Context fsGroup               | `1001`           |
| `podSecurityContext.seccompProfile.type`            | Set CTFd container's Security Context seccomp profile | `RuntimeDefault` |
| `containerSecurityContext.enabled`                  | Enabled CTFd containers' Security Context             | `true`           |
| `containerSecurityContext.runAsUser`                | Set CTFd container's Security Context runAsUser       | `1001`           |
| `containerSecurityContext.runAsNonRoot`             | Set CTFd container's Security Context runAsNonRoot    | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set CTFd container's privilege escalation             | `false`          |
| `containerSecurityContext.capabilities.drop`        | Set CTFd container's Security Context runAsNonRoot    | `["ALL"]`        |

### CTFd deployment probes parameters

| Name                     | Description                      | Value   |
| ------------------------ | -------------------------------- | ------- |
| `startupProbe`           | a template for the startup probe |         |
| `startupProbe.enabled`   | Whether to enable the probe      | `false` |
| `startupProbe`           | a template for the startup probe |         |
| `readinessProbe.enabled` | Whether to enable the probe      | `true`  |
| `livenessProbe`          | a template for the startup probe |         |
| `livenessProbe.enabled`  | Whether to enable the probe      | `true`  |

### CTFd deployment resource requests and limits

| Name                        | Description                                                               | Value   |
| --------------------------- | ------------------------------------------------------------------------- | ------- |
| `resources`                 | A container resource template                                             |         |
| `resources.requests.memory` | Requested amount of RAM for CTFd containers                               | `200Mi` |
| `resources.requests.cpu`    | Requested amount of CPU for CTFd containers                               | `400m`  |
| `resources.limits`          | Maximum resources for CTFd containers before they get restarted or killed | `{}`    |

### CTFd service parameters

| Name           | Description             | Value       |
| -------------- | ----------------------- | ----------- |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port            | `80`        |

### CTFd ingress parameters

| Name                  | Description                               | Value         |
| --------------------- | ----------------------------------------- | ------------- |
| `ingress.enabled`     | Whether to enable the CTFd ingress        | `true`        |
| `ingress.hostname`    | Ingress hostname                          | `example.com` |
| `ingress.annotations` | annotation to add to the ingress resource | `{}`          |

### CTFd deployment autoscaling parameters

| Name                                               | Description                                                              | Value   |
| -------------------------------------------------- | ------------------------------------------------------------------------ | ------- |
| `autoscaling.enabled`                              | Set this to true to deploy a horizontal pod autoscaler for CTFd          | `false` |
| `autoscaling.minReplicas`                          | Minimum number of CTFd pods                                              | `1`     |
| `autoscaling.maxReplicas`                          | Maximum number of CTFd pods                                              | `25`    |
| `autoscaling.targetCPU`                            | Target CPU usage for CTFd pods (in % of requested). Set to 0 to disable. | `65`    |
| `autoscaling.targetMemory`                         | Target RAM usage for CTFd pods (in % of requested). Set to 0 to disable. | `0`     |
| `autoscaling.scaleDown.stabilizationWindowSeconds` | Scale down stabilization window                                          | `300`   |
| `autoscaling.scaleDown.periodSeconds`              | Scale down period                                                        | `15`    |
| `autoscaling.scaleDown.percent`                    | Maximum percent of pods to remove in the given period                    | `100`   |
| `autoscaling.scaleDown.pods`                       | Maximum number of pods to remove in the given period                     | `5`     |
| `autoscaling.scaleUp.stabilizationWindowSeconds`   | Scale up stabilization window                                            | `0`     |
| `autoscaling.scaleUp.periodSeconds`                | Scale up period                                                          | `15`    |
| `autoscaling.scaleUp.percent`                      | Maximum percent of pods to add in the given period                       | `100`   |
| `autoscaling.scaleUp.pods`                         | Maximum number of pods to add in the given period                        | `10`    |

### Database Parameters

| Name                                       | Description                                                                       | Value           |
| ------------------------------------------ | --------------------------------------------------------------------------------- | --------------- |
| `mariadb.enabled`                          | Deploy a MariaDB server to satisfy the applications database requirements         | `true`          |
| `mariadb.architecture`                     | MariaDB architecture. Allowed values: `standalone` or `replication`               | `standalone`    |
| `mariadb.auth.database`                    | MariaDB custom database                                                           | `ctfd`          |
| `mariadb.auth.username`                    | MariaDB custom username                                                           | `ctfd`          |
| `mariadb.primary.persistence.enabled`      | Enable persistence on MariaDB using PVC(s)                                        | `true`          |
| `mariadb.primary.persistence.storageClass` | Persistent Volume storage class                                                   | `""`            |
| `mariadb.primary.persistence.accessModes`  | Persistent Volume access modes                                                    | `[]`            |
| `mariadb.primary.persistence.size`         | Persistent Volume size                                                            | `8Gi`           |
| `externalDatabase.enabled`                 | Whether to use an external database                                               | `false`         |
| `externalDatabase.protocol`                | Protocol schema to use when connecting to the external database                   | `mysql+pymysql` |
| `externalDatabase.host`                    | External Database server host                                                     | `localhost`     |
| `externalDatabase.port`                    | External Database server port                                                     | `3306`          |
| `externalDatabase.user`                    | External Database username                                                        | `ctfd`          |
| `externalDatabase.password`                | External Database user password                                                   | `""`            |
| `externalDatabase.database`                | External Database database name                                                   | `ctfd`          |
| `externalDatabase.existingSecret`          | The name of an existing secret with database credentials. Evaluated as a template | `""`            |

### Redis cache parameters

| Name                           | Description                                                            | Value        |
| ------------------------------ | ---------------------------------------------------------------------- | ------------ |
| `redis.enabled`                | Deploy a Redis server to satisfy the applications caching requirements | `true`       |
| `redis.architecture`           | Redis chart architecture option                                        | `standalone` |
| `externalRedis.enabled`        | Whether to use an external redis instance                              | `false`      |
| `externalRedis.protocol`       | Redis protocol scheme to use                                           | `redis`      |
| `externalRedis.host`           | External Redis server host                                             | `localhost`  |
| `externalRedis.port`           | External Redis server port                                             | `6379`       |
| `externalRedis.user`           | External Redis user                                                    | `""`         |
| `externalRedis.index`          | External Redis index (database)                                        | `""`         |
| `externalRedis.password`       | External Redis password                                                | `""`         |
| `externalRedis.existingSecret` | Name of an existing secret containing a redis-password key             | `""`         |

### S3 parameters

| Name                        | Description                                                          | Value                      |
| --------------------------- | -------------------------------------------------------------------- | -------------------------- |
| `externalS3.enabled`        | Whether to use an external S3 endpoint to store uploads              | `false`                    |
| `externalS3.endpoint`       | External S3 API endpoint URL                                         | `https://s3.amazonaws.com` |
| `externalS3.region`         | External S3 API region                                               | `us-east-1`                |
| `externalS3.bucket`         | External S3 bucket name                                              | `ctfd`                     |
| `externalS3.accessKey`      | External S3 API access key                                           | `""`                       |
| `externalS3.secretKey`      | External S3 API secret key                                           | `""`                       |
| `externalS3.existingSecret` | Name of an existing secret containing a accessKey and secretKey keys | `""`                       |
