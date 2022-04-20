# Project name
export PROJECT_NAME := cluster-config-service

# VERSION defines the project version.
VERSION ?= 0.0.1

# Repository locations
export PROJECT_DIR := $(PWD)
export BIN_DIR := $(PROJECT_DIR)/bin
export ENVTEST_ASSETS_DIR := $(PROJECT_DIR)/testbin

# Go config
export GOBIN ?= $(BIN_DIR)
export GOOS ?= linux
export GOARCH ?= amd64

# golangci-lint container image
GO_LINT_IMG_LOCATION ?= golangci/golangci-lint
GO_LINT_IMG_TAG ?= v1.45.2
GO_LINT_IMG ?= $(GO_LINT_IMG_LOCATION):$(GO_LINT_IMG_TAG)

# Image URL to use all building/pushing image targets
IMAGE_REGISTRY ?= docker.io
REGISTRY_NAMESPACE ?= jarrpa
IMAGE_TAG ?= latest
IMAGE_NAME ?= $(PROJECT_NAME)

# IMG defines the image used for the controller.
IMG ?= $(IMAGE_REGISTRY)/$(REGISTRY_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

# deployment env variables
DEPLOYMENT_NAMESPACE ?= ccs-default
DEPLOYMENT_NAME ?= $(PROJECT_NAME)

# kube rbac proxy image variables
CLUSTER_ENV ?= kubernetes
KUBE_RBAC_PROXY_IMG ?= gcr.io/kubebuilder/kube-rbac-proxy:v0.8.0
OSE_KUBE_RBAC_PROXY_IMG ?= registry.redhat.io/openshift4/ose-kube-rbac-proxy:v4.9.0

ifeq ($(CLUSTER_ENV), openshift)
	RBAC_PROXY_IMG ?= $(OSE_KUBE_RBAC_PROXY_IMG)
else ifeq ($(CLUSTER_ENV), kubernetes)
	RBAC_PROXY_IMG ?= $(KUBE_RBAC_PROXY_IMG)
endif
