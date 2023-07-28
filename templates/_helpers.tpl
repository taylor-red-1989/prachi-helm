{{/*
Expand the name of the chart.
*/}}
{{- define "prachi.name" -}}
{{- default .Chart.Name .Values.prachi.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prachi.fullname" -}}
{{- if .Values.prachi.fullnameOverride }}
{{- .Values.prachi.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.prachi.nameOverride }}
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
{{- define "prachi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prachi.labels" -}}
helm.sh/chart: {{ include "prachi.chart" . }}
{{ include "prachi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prachi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prachi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prachi.serviceAccountName" -}}
{{- if .Values.prachi.serviceAccount.create }}
{{- default (include "prachi.fullname" .) .Values.prachi.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.prachi.serviceAccount.name }}
{{- end }}
{{- end }}
