include hack/make-project-vars.mk
include hack/make-tools.mk

# Setting SHELL to bash allows bash commands to be executed by recipes.
# This is a requirement for 'setup-envtest.sh' in the test target.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

.DEFAULT_GOAL := help

.PHONY: all
all: build

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## Display this help.
	@./hack/make-help.sh $(MAKEFILE_LIST)

##@ Development

.PHONY: fmt
fmt: ## Run go fmt against code.
	go fmt ./...

.PHONY: vet
vet: ## Run go vet against code.
	go vet ./...

.PHONY: lint
lint: ## Run golangci-lint against code.
	docker run --rm -v $(PROJECT_DIR):/app -w /app $(GO_LINT_IMG) golangci-lint run -E gosec --timeout=6m

.PHONY: vendor-update
vendor-update: ## Run go mod tidy & go mod vendor
	go mod tidy && go mod vendor

.PHONY: test
test: fmt vet envtest ## Run tests.
	KUBEBUILDER_ASSETS="$(shell $(ENVTEST) use $(ENVTEST_K8S_VERSION) -p path)" go test ./... -coverprofile cover.out

##@ Build

.PHONY: build
build: fmt vet go-build ## Build manager binary.

.PHONY: go-build
go-build: ## Run go build against code.
	@GOBIN=${GOBIN} ./hack/go-build.sh

.PHONY: run
run: fmt vet ## Run a controller from your host.
	go run ./main.go --etcd-servers=http://localhost:2379

.PHONY: docker-build
docker-build: vendor-update ## Build docker image with the manager.
	docker build -t ${IMG} .

.PHONY: docker-push
docker-push: ## Push docker image with the manager.
	docker push ${IMG}

.PHONY: logs
logs: ## Tail the controller Deployment logs.
	kubectl logs -f -n ${DEPLOYMENT_NAMESPACE} deploy/${DEPLOYMENT_NAME}

##@ Deployment

ifndef ignore-not-found
  ignore-not-found = false
endif

.PHONY: deploy
deploy: kustomize ## Deploy service to the K8s cluster specified in ~/.kube/config.
	KUSTOMIZE=$(KUSTOMIZE) DEPLOYMENT_NAMESPACE=$(DEPLOYMENT_NAMESPACE) ./hack/kustomize-build.sh | kubectl apply -f -

.PHONY: remove
remove: ## Remove service from the K8s cluster specified in ~/.kube/config. Call with ignore-not-found=true to ignore resource not found errors during deletion.
	KUSTOMIZE=$(KUSTOMIZE) DEPLOYMENT_NAMESPACE=$(DEPLOYMENT_NAMESPACE) ./hack/kustomize-build.sh | kubectl delete -f -
