#!/bin/bash

BIN="${1}"
BIN_DIR="${BIN_DIR:-$(dirname "$BIN")}"

set -e

if [ ! -f "${BIN}" ]; then
  TMP_DIR="$(mktemp -d)"
  cd "${TMP_DIR}"
  wget "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
  chmod u+x install_kustomize.sh
  ./install_kustomize.sh 3.8.7 ${BIN_DIR}
  rm -rf "${TMP_DIR}"
fi
