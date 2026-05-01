#!/bin/bash

# Configuration variables for the cluster
CLUSTER_ENV="cluster.env"
SERVER_CONTAINER="k3s-cloud-server"

# Check if the cluster is already running
if [ "$(docker ps -q -f name=$SERVER_CONTAINER)" ]; then
    echo "Cluster '$SERVER_CONTAINER' is already running. Skipping deployment..."
else
    echo "Cluster not found. Starting fresh deployment..."

    # Generating a fresh random token
    echo "Generating a fresh K3s Token..."
    NEW_TOKEN=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    
    # Updating cluster.env with the new token
    if grep -q "K3S_TOKEN=" "$CLUSTER_ENV"; then
      sed -i "s/^K3S_TOKEN=.*/K3S_TOKEN=$NEW_TOKEN/" "$CLUSTER_ENV"
    else
      echo "K3S_TOKEN=$NEW_TOKEN" >> "$CLUSTER_ENV"
    fi

    # Clearing local kubeconfig if it exists
    echo "Clearing local kubeconfig if it exists..."
    rm -f ~/.kube/config

    # Bringing up the cluster as a compose stack
    echo "Bringing up the cluster as a compose stack..."
    docker compose --env-file "$CLUSTER_ENV" up -d

    # Waiting for the cluster to be ready
    echo "Waiting for the cluster to be ready..."
    until docker exec "$SERVER_CONTAINER" ls /etc/rancher/k3s/k3s.yaml >/dev/null 2>&1; do
      sleep 2
    done

    # Extracting and patching kubeconfig for the host to use
    echo "Extracting and patching kubeconfig for the host to use..."
    docker exec "$SERVER_CONTAINER" cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config
    sed -i 's/127.0.0.1:6443/127.0.0.1:6445/g' ~/.kube/config
    chmod 600 ~/.kube/config

    echo "Cluster '$SERVER_CONTAINER' is deployed and ready to be consumed"
fi
