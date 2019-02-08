#!/usr/bin/env bats
#
# Copyright (c) 2018 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0
#

load "${BATS_TEST_DIRNAME}/../../.ci/lib.sh"

setup() {
	export KUBECONFIG="$HOME/.kube/config"
	if kubectl get runtimeclass | grep -q kata; then
		pod_config_dir="${BATS_TEST_DIRNAME}/runtimeclass_workloads"
	else
		pod_config_dir="${BATS_TEST_DIRNAME}/untrusted_workloads"
	fi
}

@test "ConfigMap for a pod" {
	config_name="test-configmap"
	pod_name="config-env-test-pod"

	# Create ConfigMap
	kubectl create -f "${pod_config_dir}/configmap.yaml"

	# View the values of the keys
	kubectl get configmaps $config_name -o yaml | grep -q "data-"

	# Create a pod that consumes the ConfigMap
	kubectl create -f "${pod_config_dir}/pod-configmap.yaml"

	# Check pod creation
	kubectl wait --for=condition=Ready pod "$pod_name"

	# Check env
	cmd="env"
	kubectl exec $pod_name -- sh -c $cmd | grep "KUBE_CONFIG_1=value-1"
	kubectl exec $pod_name -- sh -c $cmd | grep "KUBE_CONFIG_2=value-2"
}

teardown() {
	kubectl delete pod "$pod_name"
	kubectl delete configmap "$config_name"
}