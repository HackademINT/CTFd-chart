{{/* CTFd deployment name */}}
{{- define "ctfd.ctfd.deployment.name" -}}
{{- printf "%s-ctfd" (include "ctfd.fullname" .) -}}
{{- end -}}

{{/*
  Return the database Secret Name, which contains the database's password.
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

{{/* CTFd service */}}
{{- define "ctfd.maridb.serviceName" -}}
    {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- end -}}

