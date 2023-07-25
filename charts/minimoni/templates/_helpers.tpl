{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "minimoni.name" -}}
{{- default .Chart.Name .Values.core.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "minimoni.fullname" -}}
{{- if .Values.core.fullnameOverride -}}
{{- .Values.core.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.core.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "minimoni.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "minimoni.labels" -}}
helm.sh/chart: {{ include "minimoni.chart" . }}
{{ include "minimoni.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "minimoni.selectorLabels" -}}
app: {{ include "minimoni.name" . }}
app.kubernetes.io/name: {{ include "minimoni.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common operator labels
*/}}
{{- define "mm-operator.labels" -}}
helm.sh/chart: {{ include "minimoni.chart" . }}
{{ include "mm-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Operator selector labels
*/}}
{{- define "mm-operator.selectorLabels" -}}
app.kubernetes.io/name: mm-operator
app.kubernetes.io/instance: mm-operator
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "minimoni.serviceAccountName" -}}
{{- if .Values.mmoperator.serviceAccount.create -}}
    {{ default (include "minimoni.fullname" .) .Values.mmoperator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.mmoperator.serviceAccount.name }}
{{- end -}}
{{- end -}}
