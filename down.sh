#!/bin/bash

# Cluster name to check and delete
CLUSTER_NAME="photoatom"

# Check if cluster exists or not
CHECK_CLUSTER_EXISTENCE=$(k3d cluster list | grep -c "$CLUSTER_NAME" || true)

# Delete cluster if it exists
if [[ "$CHECK_CLUSTER_EXISTENCE" != "0" ]]
then
  k3d cluster delete --config cluster.yml
fi