{{/*
Expand the name of the chart.
*/}}
{{- define "backend-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "backend-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ include "backend-chart.fullname" . }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
