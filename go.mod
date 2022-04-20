// This is a generated file. Do not edit directly.

module github.com/jarrpa/cluster-config-service

go 1.16

require (
	github.com/google/gofuzz v1.2.0
	github.com/jarrpa/ocs-operator/api v1.4.12-0.rc1
	github.com/spf13/cobra v1.2.1
	k8s.io/apimachinery v0.23.6
	k8s.io/apiserver v0.23.5
	k8s.io/client-go v12.0.0+incompatible
	k8s.io/code-generator v0.23.4
	k8s.io/component-base v0.23.5
	k8s.io/kube-openapi v0.0.0-20220124234850-424119656bbf
	k8s.io/utils v0.0.0-20211116205334-6203023598ed
)

// === Rook hacks ===

// This tag doesn't exist, but is imported by github.com/portworx/sched-ops.
exclude github.com/kubernetes-incubator/external-storage v0.20.4-openstorage-rc2

replace (
	github.com/kubernetes-incubator/external-storage => github.com/libopenstorage/external-storage v0.20.4-openstorage-rc3 // required by rook v1.7
	github.com/portworx/sched-ops => github.com/portworx/sched-ops v0.20.4-openstorage-rc3 // required by rook v1.7
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.23.4
	k8s.io/client-go => k8s.io/client-go v0.23.4
)
