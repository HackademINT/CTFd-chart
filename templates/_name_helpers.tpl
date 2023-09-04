{{/* CTFd deployment name */}}
{{- define "ctfd.ctfd.deployment.name" -}}
{{- printf "%s-ctfd" (include "ctfd.fullname" .) -}}
{{- end -}}

{{/* MariaDB service */}}
{{- define "ctfd.maridb.serviceName" -}}
    {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
  Returns the name of the secret which contains credentials to the SMTP server.
  This will either be :
    - The CTFd configuration secret
    - or a user provided secret if the mail.smtp.existingSecret value is set
*/}}
{{- define "ctfd.smtp.smtpSecretName" -}}
{{- if .Values.mail.smtp.existingSecret -}}
  {{- .Values.mail.smtp.existingSecret -}}
{{- else -}}
  {{- include "ctfd.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
  Returns the name of the secret which contains the mailgun API key.
  This will either be :
    - The CTFd configuration secret
    - or a user provided secret if the mail.mailgun.existingSecret value is set
*/}}
{{- define "ctfd.mailgun.mailgunSecretName" -}}
{{- if .Values.mail.mailgun.existingSecret -}}
  {{- .Values.mail.mailgun.existingSecret -}}
{{- else -}}
  {{- include "ctfd.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
  Returns the name of the secret which contains the OAuth credentials.
  This will either be :
    - The CTFd configuration secret
    - or a user provided secret if the oauth.existingSecret value is set
*/}}
{{- define "ctfd.oauth.oauthSecretName" -}}
{{- if .Values.oauth.existingSecret -}}
  {{- .Values.oauth.existingSecret -}}
{{- else -}}
  {{- include "ctfd.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
  Returns the database Secret Name, which contains the database password.
  The secret may stem from different places:
    - If the MariaDB sub-chart is enabled, its secret will be used
    - Else, if an external database is enabled and an existing secret is provided, it is used
    - Finally, if an external database is enabled but no existing secret is provided, a secret is created using externalDatabase.password
  If no database is enabled, CTFd will fallback to a temporary sqlite database.
*/}}
{{- define "ctfd.maridb.databaseSecretName" -}}
{{- if .Values.mariadb.enabled }}
  {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- else if .Values.externalDatabase.enabled -}}
  {{- if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
  {{- else -}}
    {{- printf "%s-db" (include "common.names.fullname" .) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/* Redis service */}}
{{- define "ctfd.redis.serviceName" -}}
    {{- printf "%s-redis-master" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
  Returns the redis Secret Name, which contains the Redis password.
  The secret may stem from different places:
    - If the Redis sub-chart is enabled, its secret will be used
    - Else, if an external redis is enabled and an existing secret is provided, it is used
    - Finally, if an external Redis is enabled but no existing secret is provided, a secret is created using externalRedis.password
  If Redis disabled, CTFd will fallback to its internal file system cache.
*/}}
{{- define "ctfd.redis.redisSecretName" -}}
{{- if .Values.redis.enabled -}}
  {{- printf "%s-redis" (include "common.names.fullname" .) -}}
{{- else if .Values.externalRedis.enabled -}}
  {{- if .Values.externalRedis.existingSecret -}}
    {{- printf "%s" .Values.externalRedis.existingSecret -}}
  {{- else -}}
    {{- printf "%s-redis" (include "common.names.fullname" .) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/* MinIO service */}}
{{- define "ctfd.minio.serviceName" -}}
    {{- printf "%s-minio" (include "common.names.fullname" .) -}}
{{- end -}}

{{/* MinIO service */}}
{{- define "ctfd.minio.bucketName" -}}
    {{- $parts := split "." .Values.minio.defaultBuckets -}}
    {{- $parts._0 -}}
{{- end -}}

{{/* MinIO endpoint */}}
{{- define "ctfd.minio.endpoint" -}}
    {{- if .Values.minio.externalEndpoint -}}
        {{ .Values.minio.externalEndpoint }}
    {{- else if .Values.minio.apiIngress.enabled -}}
        {{- $scheme := .Values.minio.apiIngress.tls | ternary "https" "http" -}}
        {{- $path := .Values.minio.apiIngress.path | default "" -}}
        {{- printf "%s://%s%s" $scheme .Values.minio.apiIngress.hostname $path -}}
    {{- else -}}
        {{ printf "http://%s:%s" (include "ctfd.minio.serviceName" . ) (.Values.minio.service.ports.api | default 80) }}
    {{- end -}}
{{- end -}}

{{/* MinIO secret */}}
{{- define "ctfd.minio.secretName" -}}
    {{- printf "%s-minio" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
  Returns the name of the secret which contains the S3 credentials credentials.
  This will either be :
    - A secret generated from the externalS3.accessKey and externalS3.secretKey values
    - or a user provided secret if the externalS3.existingSecret value is set
*/}}
{{- define "ctfd.s3.s3SecretName" -}}
{{- if .Values.externalS3.existingSecret -}}
  {{- .Values.externalS3.existingSecret -}}
{{- else -}}
  {{- printf "%s-s3" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}