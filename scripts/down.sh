#!/bin/bash

# Configuration variables for the cluster
CLUSTER_ENV="cluster.env"
SERVER_CONTAINER="k3s-cloud-server"

# Check if the cluster exists (running or stopped)
if [ "$(docker ps -aq -f name=$SERVER_CONTAINER)" ]; then
    echo "Deleting cluster and purging volumes..."
    
    # Bringing down the cluster and its associated volumes
    docker compose --env-file "$CLUSTER_ENV" down -v

    # Resetting the cluster.env token to a template state
    sed -i "s/^K3S_TOKEN=.*/K3S_TOKEN=/" "$CLUSTER_ENV"

    # Clearing local kubeconfig
    rm -f ~/.kube/config
    
    echo "Cluster deleted successfully."
else
    echo "Cluster is already deleted or not found."
fi
