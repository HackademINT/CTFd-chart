{{/* CTFd deployment name */}}
{{- define "ctfd.ctfd.deployment.name" -}}
{{- printf "%s-ctfd" (include "ctfd.fullname" .) -}}
{{- end -}}

{{/* MariaDB service */}}
{{- define "ctfd.maridb.serviceName" -}}
    {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
  Return the database Secret Name, which contains the database password.
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
  Return the redis Secret Name, which contains the Redis password.
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
    {{- printf "%s-db" (include "common.names.fullname" .) -}}
  {{- end -}}
{{- end -}}
{{- end -}}