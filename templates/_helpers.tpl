{{/*
Expand the name of the chart.
*/}}
{{- define "fastinx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fastinx.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fastinx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fastinx.labels" -}}
helm.sh/chart: {{ include "fastinx.chart" . }}
{{ include "fastinx.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fastinx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fastinx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fastinx.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fastinx.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define the proxy's SSL directory.
*/}}
{{- define "fastinx.sslDirectory" -}}
{{- default "/etc/nginx/ssl" .Values.sslDirectory }}
{{- end }}

{{/*
Define the proxy's root directory.
*/}}
{{- define "fastinx.rootDirectory" -}}
{{- default "/usr/share/nginx/html" .Values.rootDirectory }}
{{- end }}

{{/*
Define the static content extension.
*/}}
{{- define "fastinx.staticContent.extensions" -}}
{{- .Values.staticContent.extensions | join "|" }}
{{- end -}}

{{- define "fastinx.livenessProbe" -}}
{{- default "/favicon.ico" .Values.livenessProbe }}
{{- end -}}
{{- define "fastinx.readinessProbe" -}}
{{- default "/favicon.ico" .Values.readinessProbe }}
{{- end -}}