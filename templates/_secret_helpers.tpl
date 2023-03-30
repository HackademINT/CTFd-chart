{{/* Flask secret key */}}
{{- define "ctfd.secret.flaskSecretKey" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.flaskSecretKey -}}
{{ $secret.data.flaskSecretKey | b64dec }}
{{- else -}}
{{ randAlphaNum 64 }}
{{- end -}}
{{- end -}}

{{/* SMTP username */}}
{{- define "ctfd.secret.smtp.username" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.smtpUsername -}}
{{ $secret.data.smtpUsername | b64dec }}
{{- else -}}
{{ .Values.mail.smtp.username }}
{{- end -}}
{{- end -}}

{{/* SMTP password */}}
{{- define "ctfd.secret.smtp.password" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.smtpPassword -}}
{{ $secret.data.smtpPassword | b64dec }}
{{- else -}}
{{ .Values.mail.smtp.password }}
{{- end -}}
{{- end -}}

{{/* Mailgun API key */}}
{{- define "ctfd.secret.mailgun.apiKey" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.mailgunApiKey -}}
{{ $secret.data.mailgunApiKey | b64dec }}
{{- else -}}
{{ .Values.mail.mailgun.apiKey }}
{{- end -}}
{{- end -}}

{{/* OAuth client id */}}
{{- define "ctfd.secret.oauth.clientId" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.oauthClientId -}}
{{ $secret.data.oauthClientId | b64dec }}
{{- else -}}
{{ .Values.oauth.clientId }}
{{- end -}}
{{- end -}}

{{/* OAuth client secret */}}
{{- define "ctfd.secret.oauth.clientSecret" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace ( include "ctfd.fullname" . ) -}}
{{- if and $secret $secret.data.oauthClientSecret -}}
{{ $secret.data.oauthClientSecret | b64dec }}
{{- else -}}
{{ .Values.oauth.clientSecret }}
{{- end -}}
{{- end -}}