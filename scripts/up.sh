#!/bin/bash

# Cluster name to check and deploy
CLUSTER_NAME="photoatom"

# Check if cluster exists or not
CHECK_CLUSTER_EXISTENCE=$(k3d cluster list | grep -c "$CLUSTER_NAME" || true)

# Deploy cluster if it does not exist
if [[ "$CHECK_CLUSTER_EXISTENCE" == "0" ]]
then
  k3d cluster create --config cluster.yml
else
  echo "Cluster is already created..."
fi