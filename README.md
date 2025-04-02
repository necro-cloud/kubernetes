# necronizer's cloud self hosted cluster implementation

This repository mainly handles scripts for automation of setting up and destroying kubernetes cluster using k3s for usage with personal projects. YAML Configuration and scripts related to bringing up and down the cluster lives in this repository.

# Requirements and Dependencies

The following is required to provision a kubernetes cluster using this repository:

1. [Docker](https://www.docker.com/) - k3s runs kubernetes nodes in Docker hence Docker is required to be installed on the host machine to run kubernetes successfully.
2. [k3d](https://k3d.io/stable/) - Lightweight wrapper around k3s running on Docker, can be used to bring up single-node and multi-node clusters easily. 

# Usage Instructions:

**Step 1:** Make sure you have installed Docker and k3d on your system since we will be using them to bring up the cluster

**Step 2:** Navigate yourself to the scripts folder where we have the configuration for the cluster present in the [cluster.yml](scripts/cluster.yml) file for which the reference can be found [here](https://k3d.io/stable/usage/configfile/)

**Step 3:** Grant execution permissions to the following scripts: [up.sh](cluster/up.sh) and [down.sh](cluster/down.sh) with the following command:
```
chmod +x up.sh
chmod +x down.sh
```

**Step 4:** To bring up the cluster, execute the [up.sh](cluster/up.sh) using the command: `bash up.sh`. Running this command will also generate the KubeConfig in your home directory as well (present in `~/.kube/config`)

**Step 5:** To bring down the cluster, execute the [down.sh](cluster/down.sh) using the command: `bash down.sh`. Running this remove the cluster and also get rid of all containers which were running to support the uptime of the cluster.
