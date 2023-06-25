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

| Name                                     | Description                                                                                          | Value    |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------- | -------- |
| `security.sessionCookie.httpOnly`        | whether to set the HttpOnly flag for session cookies                                                 | `true`   |
| `security.sessionCookie.sameSite`        | the value to use for the SameSite parameter of session cookies                                       | `Lax`    |
| `security.permanentSessionLifetime`      | the flask session lifetime, in seconds                                                               | `604800` |
| `mail.addressFrom`                       | SMTP FROM field value                                                                                | `""`     |
| `mail.smtp.enabled`                      | whether to send emails at all                                                                        | `false`  |
| `mail.smtp.server`                       | SMTP server address                                                                                  | `""`     |
| `mail.smtp.port`                         | SMTP server port                                                                                     | `465`    |
| `mail.smtp.useAuth`                      | whether to use authentication with the SMTP server                                                   | `false`  |
| `mail.smtp.username`                     | the username to use for SMTP authentication                                                          | `""`     |
| `mail.smtp.password`                     | the password to use for SMTP authentication                                                          | `""`     |
| `mail.smtp.tls`                          | whether to use tls when communicating with the SMTP server                                           | `true`   |
| `mail.smtp.ssl`                          | whether to use ssl when communicating with the SMTP server                                           | `false`  |
| `mail.smtp.addressSender`                | SMTP SENDER field value                                                                              | `""`     |
| `mail.smtp.existingSecret`               | the name of an existing secret with smtpUsername and smtpPassword keys                               | `""`     |
| `mail.mailgun.enabled`                   | whether to use the mailgun API to send emails                                                        | `false`  |
| `mail.mailgun.apiKey`                    | an API key for mailgun                                                                               | `""`     |
| `mail.mailgun.baseUrl`                   | base url for the mailgun API                                                                         | `""`     |
| `mail.mailgun.existingSecret`            | the name of an existing secret with a mailgunApiKey key                                              | `""`     |
| `logFolder`                              | a folder where CTFd should store logs for submissions, registrations and logins                      | `""`     |
| `optional.reverseProxy`                  | whether CTFd should trust X-Forwarded headers. Checkout the CTFd documentation for more information. | `true`   |
| `optional.themeFallback`                 | whether CTFd should fallback to the core theme for missing resources                                 | `true`   |
| `optional.swaggerUi`                     | whether to enable the swagger endpoint at /api/v1                                                    | `false`  |
| `optional.updateCheck`                   | whether to check for updates                                                                         | `true`   |
| `optional.serverSentEvents`              | whether to use server sent event notifications                                                       | `true`   |
| `optional.htmlSanitization`              | whether CTFd should sanitize html content                                                            | `false`  |
| `optional.sqlAlchemy.trackModifications` | leave disabled to save memory                                                                        | `false`  |
| `optional.sqlAlchemy.maxOverflow`        | SqlAlchemy max overflow engine setting                                                               | `""`     |
| `optional.sqlAlchemy.poolPrePing`        | SqlAlchemy pool pre ping engine setting                                                              | `""`     |
| `optional.safeMode`                      | if enabled, CTFd will not load any plugins                                                           | `false`  |
| `oauth.enabled`                          | whether to enable MajorLeagueCyber integration                                                       | `false`  |
| `oauth.clientId`                         | MajorLeagueCyber oauth client ID                                                                     | `""`     |
| `oauth.clientSecret`                     | MajorLeagueCyber oauth client secret                                                                 | `""`     |
| `oauth.existingSecret`                   | name of a secret containing the MajorLeagueCyber oauth client secret                                 | `""`     |

### CTFd deployment basic parameters

| Name                 | Description                                                          | Value                     |
| -------------------- | -------------------------------------------------------------------- | ------------------------- |
| `image.image`        | full container image path for the CTFd deployment                    | `ghcr.io/ctfd/ctfd:3.5.1` |
| `image.pullSecret`   | a pull secret name for the CTFd image                                | `""`                      |
| `image.pullPolicy`   | CTFd image pull policy                                               | `IfNotPresent`            |
| `httpPort`           | The http port the CTFd container listens on                          | `8000`                    |
| `replicaCount`       | number of replicas for the CTFd deployment                           | `1`                       |
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
| `startupProbe.enabled`   | whether to enable the probe      | `false` |
| `startupProbe`           | a template for the startup probe |         |
| `readinessProbe.enabled` | whether to enable the probe      | `true`  |
| `livenessProbe`          | a template for the startup probe |         |
| `livenessProbe.enabled`  | whether to enable the probe      | `true`  |

### CTFd service parameters

| Name           | Description  | Value       |
| -------------- | ------------ | ----------- |
| `service.type` | service type | `ClusterIP` |
| `service.port` | service port | `80`        |

### CTFd ingress parameters

| Name                  | Description                               | Value         |
| --------------------- | ----------------------------------------- | ------------- |
| `ingress.enabled`     | whether to enable the CTFd ingress        | `true`        |
| `ingress.hostname`    | the ingress hostname                      | `example.com` |
| `ingress.annotations` | annotation to add to the ingress resource | `{}`          |

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
| `externalRedis.enabled`        | whether to use an external redis instance                              | `false`      |
| `externalRedis.protocol`       | the redis protocol scheme to use                                       | `redis`      |
| `externalRedis.host`           | the redis host to connect to                                           | `localhost`  |
| `externalRedis.port`           | the redis port to connect to                                           | `6379`       |
| `externalRedis.user`           | the redis user to use for authentication                               | `""`         |
| `externalRedis.index`          | the redis index (database) to use                                      | `""`         |
| `externalRedis.password`       | the redis password to use for authentication                           | `""`         |
| `externalRedis.existingSecret` | the name of an existing secret containing a redis-password key         | `""`         |

### S3 parameters

| Name                        | Description                                                              | Value              |
| --------------------------- | ------------------------------------------------------------------------ | ------------------ |
| `externalS3.enabled`        | whether to use an external S3 endpoint to store uploads                  | `false`            |
| `externalS3.endpoint`       | the S3 endpoint to use                                                   | `s3.amazonaws.com` |
| `externalS3.region`         | the S3 region to use                                                     | `us-east-1`        |
| `externalS3.bucket`         | the S3 bucket name to use to store uploads                               | `ctfd`             |
| `externalS3.accessKey`      | the S3 access key                                                        | `""`               |
| `externalS3.secretKey`      | the S3 secret key                                                        | `""`               |
| `externalS3.existingSecret` | the name of an existing secret containing a accessKey and secretKey keys | `""`               |
