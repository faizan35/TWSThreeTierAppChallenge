#!/bin/bash

# Function to apply manifest files in a directory
apply_manifests() {
    local dir=$1
    echo "Applying manifest files in directory: $dir"
    kubectl apply -f "$dir"
}

# Function to apply manifest files with waiting
apply_manifests_with_waiting() {
    local dir=$1
    local wait_time=$2
    apply_manifests "$dir"
    echo "Waiting $wait_time seconds after applying manifest files in $dir"
    sleep "$wait_time"
}

# Create namespace three-tier if it doesn't exist
if ! kubectl get namespace three-tier &> /dev/null; then
    echo "."
    kubectl create namespace three-tier
    echo "."
fi

sleep 1

# Main script
echo "Starting manifest application process..."

echo "."

# Apply manifest files in Database directory
apply_manifests_with_waiting "Database" 10

# Apply manifest files in Backend directory
apply_manifests_with_waiting "Backend" 5

# Apply manifest files in Frontend directory
apply_manifests "Frontend"

echo "."

echo "Manifest application process completed."

echo "."

# Get pods in namespace three-tier
echo "kubectl get pods -n three-tier"
kubectl get pods -n three-tier

# Get svc in namespace three-tier
echo "kubectl get svc -n three-tier"
kubectl get svc -n three-tier








# # Function to apply manifest files in a directory
# apply_manifests() {
#     local dir=$1
#     echo "Applying manifest files in directory: $dir"
#     kubectl apply -f "$dir"
# }

# # Create namespace three-tier if it doesn't exist
# if ! kubectl get namespace three-tier &> /dev/null; then
#     echo "."
#     kubectl create namespace three-tier
#     echo "."
# fi

# sleep 1

# # Main script
# echo "Starting manifest application process..."

# echo "."

# # Apply manifest files in Database directory
# apply_manifests "Database"

# # Wait for 5 seconds 
# echo "."
# sleep 5

# # Apply manifest files in Backend directory
# apply_manifests "Backend"

# # Wait for 5 seconds 
# echo "."
# sleep 5

# # Apply manifest files in Frontend directory
# apply_manifests "Frontend"

# echo "."

# echo "Manifest application process completed."

# echo "."

# # Get pods in namespace three-tier
# echo "kubectl get pods -n three-tier"
# kubectl get pods -n three-tier

# # Get svc in namespace three-tier
# echo "kubectl get svc -n three-tier"
# kubectl get svc -n three-tier