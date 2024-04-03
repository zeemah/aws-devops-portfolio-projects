#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=halimausman/flaskapp:1

# Step 2
# Run the Docker Hub container with kubernetes
kubectl create deploy flaskapp --image=halimausman/flaskapp:1

# Step 3:
# List kubernetes pods
kubectl get deploy.rs.svc.pods

# Step 4:
# Forward the container port to a host
kubectl port-forward pod/flaskapp-5bb987f58d-grpk7 --address 0.0.0.0 8001:80
