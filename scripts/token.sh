#!/bin/bash -e

# Generate token for the admin user to be used on Kubernetes Dashboard
echo "Dashboard Token: $(kubectl -n kubernetes-dashboard create token admin-user)"