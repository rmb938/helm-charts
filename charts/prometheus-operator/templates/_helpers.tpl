{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-operator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
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
{{- define "prometheus-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "prometheus-operator.labels" -}}
helm.sh/chart: {{ include "prometheus-operator.chart" . }}
{{ include "prometheus-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "prometheus-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "prometheus-operator.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the kubelet service namespace
*/}}
{{- define "prometheus-operator.kubeletNamespace" -}}
    {{ default .Release.Namespace .Values.kubeletService.namespace }}
{{- end -}}

{{/*
Create the name of the kubelet service names
*/}}
{{- define "prometheus-operator.kubeletName" -}}
    {{ default "kubelet" .Values.kubeletService.name }}
{{- end -}}

{{/*
Create the name of the webhook certificate to use
*/}}
{{- define "prometheus-operator.webhookCertificateName" -}}
{{- if .Values.webhook.certificate.create -}}
    {{ default (printf "%s-webhook-cert" (include "prometheus-operator.fullname" .)) .Values.webhook.certificate.name }}
{{- else -}}
    {{ default "default" .Values.webhook.certificate.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the webhook certificate secret to use
*/}}
{{- define "prometheus-operator.webhookCertificateSecretName" -}}
{{- if .Values.webhook.certificate.create -}}
    {{ default (printf "%s-webhook-cert" (include "prometheus-operator.fullname" .)) .Values.webhook.certificate.secretName }}
{{- else -}}
    {{ default "default" .Values.webhook.certificate.secretName }}
{{- end -}}
{{- end -}}
