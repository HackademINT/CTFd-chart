{{/* Flask secret key */}}
{{- define "ctfd.secret.flaskSecretKey" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.flaskSecretKey -}}
{{ $secret.data.flaskSecretKey | b64dec }}
{{- else -}}
{{ randAlphaNum 64 }}
{{- end -}}
{{- end -}}

{{/* Email username */}}
{{- define "ctfd.secret.email.username" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.emailUsername -}}
{{ $secret.data.emailUsername | b64dec }}
{{- else -}}
{{ .Values.ctfd.email.username }}
{{- end -}}
{{- end -}}

{{/* Email password */}}
{{- define "ctfd.secret.email.password" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.emailPassword -}}
{{ $secret.data.emailPassword | b64dec }}
{{- else -}}
{{ .Values.ctfd.email.password }}
{{- end -}}
{{- end -}}

{{/* Mailgun API key */}}
{{- define "ctfd.secret.email.mailgun.apiKey" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.mailgunApiKey -}}
{{ $secret.data.mailgunApiKey | b64dec }}
{{- else -}}
{{ .Values.ctfd.email.mailgun.apiKey }}
{{- end -}}
{{- end -}}

{{/* OAuth client id */}}
{{- define "ctfd.secret.oauth.clientId" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.oauthClientId -}}
{{ $secret.data.oauthClientId | b64dec }}
{{- else -}}
{{ .Values.ctfd.oauth.clientId }}
{{- end -}}
{{- end -}}

{{/* OAuth client secret */}}
{{- define "ctfd.secret.oauth.clientSecret" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.oauthClientSecret -}}
{{ $secret.data.oauthClientSecret | b64dec }}
{{- else -}}
{{ .Values.ctfd.oauth.clientSecret }}
{{- end -}}
{{- end -}}