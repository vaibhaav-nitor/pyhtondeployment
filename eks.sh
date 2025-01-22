#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Download and install kubectl
echo "Downloading kubectl..."
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin
echo "kubectl installed successfully"
kubectl version --short --client

# Step 2: Download and install eksctl
echo "Downloading eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
# sudo mv /eksctl /usr/local/bin
echo "eksctl installed successfully"
eksctl version

# Step 3: Create Kubernetes namespace
echo "Creating namespace 'workshop'..."
kubectl create namespace workshop

# Step 4: Update kubeconfig for EKS cluster
echo "Updating kubeconfig for cluster 'three-tier-cluster-2'..."
aws eks --region us-west-2 update-kubeconfig --name three-tier-cluster-2
echo "kubeconfig updated successfully"

echo "All commands executed successfully!"
