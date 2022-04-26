/*
Copyright 2022 Red Hat, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"os"

	"github.com/jarrpa/cluster-config-service/pkg/cmd/server"

	api "github.com/jarrpa/ocs-operator/api/v1"
	k8sapiserver "k8s.io/apiserver/pkg/server"
	"k8s.io/component-base/cli"
)

func main() {
	_ = api.StorageCluster{}
	stopCh := k8sapiserver.SetupSignalHandler()
	options := server.NewWardleServerOptions(os.Stdout, os.Stderr)
	cmd := server.NewCommandStartWardleServer(options, stopCh)
	code := cli.Run(cmd)
	os.Exit(code)
}
