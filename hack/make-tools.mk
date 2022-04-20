##@ Tools

CONTROLLER_GEN = $(BIN_DIR)/controller-gen
.PHONY: controller-gen
controller-gen: ## Download controller-gen locally if necessary.
	./hack/get-tool.sh $(CONTROLLER_GEN) sigs.k8s.io/controller-tools/cmd/controller-gen@v0.4.1

KUSTOMIZE = $(BIN_DIR)/kustomize
.PHONY: kustomize
kustomize: ## Download kustomize locally if necessary.
	./hack/get-kustomize.sh $(KUSTOMIZE)

# ENVTEST_K8S_VERSION refers to the version of kubebuilder assets to be downloaded by envtest binary.
ENVTEST_K8S_VERSION = 1.23
ENVTEST = $(BIN_DIR)/setup-envtest
.PHONY: envtest
envtest: ## Download setup-envtest locally if necessary.
	./hack/get-tool.sh $(ENVTEST) sigs.k8s.io/controller-runtime/tools/setup-envtest@latest
