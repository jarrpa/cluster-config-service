#!/bin/bash

KUSTOMIZE="${KUSTOMIZE:-kustomize}"

set -ex

cd kustomize/base/cluster

cat <<EOF > namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ${DEPLOYMENT_NAMESPACE}
EOF

${KUSTOMIZE} edit add resource namespace.yaml
${KUSTOMIZE} build .
