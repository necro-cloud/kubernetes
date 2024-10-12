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

# CONFIG_JSON_PATH=$1

# # Function to set up cluster with the provided configuration.
# function set_up_cluster {
#   echo "##################################"
#   echo "##                              ##"
#   echo "##      Setting Up Cluster      ##"
#   echo "##                              ##"
#   echo "##################################"

#   # Setup cluster using minikube.

#   if [[ $? != 0 ]]
#   then
#     echo "##################################"
#     echo "##                              ##"
#     echo "##  Setting Up Cluster Failed   ##"
#     echo "## Please check the above logs! ##"
#     echo "##                              ##"
#     echo "##################################"

#     exit 1
#   else

#     echo "##################################"
#     echo "##                              ##"
#     echo "## Setting Up Cluster Success!  ##"
#     echo "##                              ##"
#     echo "##################################"

#   fi
# }

# function set_up_dashboard {

#   echo "##################################"
#   echo "##                              ##"
#   echo "##     Installing Dashboard     ##"
#   echo "##                              ##"
#   echo "##################################"

#   helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
#   helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

#   if [[ $? != 0 ]]
#   then
#     echo "##################################"
#     echo "##                              ##"
#     echo "## Installing Dashboard Failed  ##"
#     echo "## Please check the above logs! ##"
#     echo "##                              ##"
#     echo "##################################"

#     exit 1
#   else

#     kubectl apply -f config/serviceaccount.yml
#     kubectl apply -f config/clusterrolebinding.yml

#     echo "##################################"
#     echo "##                              ##"
#     echo "## Setting Up Dashboard Success ##"
#     echo "##                              ##"
#     echo "##################################"

#     echo "Dashboard Token: $(kubectl -n kubernetes-dashboard create token admin-user)"

#   fi

# }

# function install_operators {
#   CONFIG_JSON_PATH=$1

#   echo "##################################"
#   echo "##                              ##"
#   echo "##     Installing Operators     ##"
#   echo "##                              ##"
#   echo "##################################"

#   OPERATORS_LIST=$(jq -rc '.operators[] | @base64' "$CONFIG_JSON_PATH")

#   for OPERATOR_HASHED in $OPERATORS_LIST
#   do
#     OPERATOR=$(echo "$OPERATOR_HASHED" | base64 --decode)
#     OPERATOR_NAME=$(echo "$OPERATOR" | jq -rc '.name')
#     OPERATOR_STEPS=$(echo "$OPERATOR" | jq -rc '.steps[] | @base64')

#     echo "Installing Operator: $OPERATOR_NAME..."

#     for STEP_HASHED in $OPERATOR_STEPS
#     do
#       STEP=$(echo "$OPERATOR_STEPS" | base64 --decode)

#       echo "Executing step: $STEP"
#       eval "${STEP}"

#       if [[ $? != 0 ]]
#       then
#         echo "##################################"
#         echo "##                              ##"
#         echo "## Installing Operator Failed!  ##"
#         echo "## Please check the above logs! ##"
#         echo "##                              ##"
#         echo "##################################"

#         exit 1
#       fi
#     done

#     echo -e "\n\n$OPERATOR_NAME is installed"
#   done

# }

# # --------------------------------- SCRIPT START --------------------------------- #

# CLUSTER_NAME=$(jq -rc '.cluster_name' "$CONFIG_JSON_PATH")

# CHECK_CLUSTER_EXISTENCE=$(k3d cluster list | grep -c "$CLUSTER_NAME" || true)

# if [[ "$CHECK_CLUSTER_EXISTENCE" == "0" ]]
# then
#   set_up_cluster
#   set_up_dashboard
# fi

# install_operators "$CONFIG_JSON_PATH"