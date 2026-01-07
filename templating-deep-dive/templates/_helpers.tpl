{{- define "templating-deep-dive.fullname" -}}
{{- $defaultname := printf "%s-%s" .Release.Name .Chart.Name }}
{{- .Values.customName | default $defaultname | trunc 63 | trimSuffix "-"  -}}
{{- end -}}

{{- define "templating-deep-dive.selectorLabels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
managed-by: "helm"
{{- end -}}

{{/*Expects a interger or string to be passed as the context*/}}
{{- define "templating-deep-dive.validators.portRange" -}}
{{- $sanitizedport := int . -}}
{{/*Port validation*/}}
{{- if or (lt $sanitizedport 1) (gt $sanitizedport 65535) -}}
{{- fail "Error: Ports must always be between 1 and 65535" -}}
{{- end -}}
{{- end -}}


{{/*Expects a object with port and type to be passed as the context*/}}
{{- define "templating-deep-dive.validators.service" -}}
{{- include "templating-deep-dive.validators.portRange" .port -}}

{{/*Service tyoe validation*/}}
{{- $allowedSvctypes := list "ClusterIP" "NodePort" -}}
{{- if not (has .type $allowedSvctypes) -}}
{{- fail (printf "Error: Service type %s is not allowed. Allowed types are: %s" .type (join ", " $allowedSvctypes)) -}}
{{- end }}
{{- end -}}