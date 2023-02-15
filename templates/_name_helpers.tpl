{{/* CTFd deployment name */}}
{{- define "ctfd.ctfd.deployment.name" -}}
{{- printf "%s-ctfd" (include "ctfd.fullname" .) -}}
{{- end -}}

{{/* Return the database Secret Name */}}
{{- define "ctfd.maridb.databaseSecretName" -}}
{{- if .Values.mariadb.enabled }}
    {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- else if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-externaldb" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* CTFd service */}}
{{- define "ctfd.maridb.serviceName" -}}
    {{- printf "%s-mariadb" (include "common.names.fullname" .) -}}
{{- end -}}

