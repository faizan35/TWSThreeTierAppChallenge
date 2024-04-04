#!/bin/bash

# Function to apply manifest files in a directory
apply_manifests() {
    local dir=$1
    echo "Applying manifest files in directory: $dir"
    kubectl apply -f "$dir"
}

# Main script
echo "Starting manifest application process..."

# Main script
echo "Starting manifest application process..."

# Create namespace three-tier if it doesn't exist
if ! kubectl get namespace three-tier &> /dev/null; then
    echo "Creating namespace three-tier..."
    kubectl create namespace three-tier
fi

sleep 1

# Apply manifest files in Database directory
apply_manifests "Database"

# Wait for 5 seconds before proceeding to the next directory
echo "Waiting for 5 seconds before applying manifests in the next directory..."
sleep 5

# Apply manifest files in Backend directory
apply_manifests "Backend"

# Wait for 5 seconds before proceeding to the next directory
echo "Waiting for 5 seconds before applying manifests in the next directory..."
sleep 5

# Apply manifest files in Frontend directory
apply_manifests "Frontend"

echo "Manifest application process completed."

# Get pods in namespace three-tier
echo "Getting pods in namespace three-tier..."
kubectl get pods -n three-tier

# Get svc in namespace three-tier
echo "Getting Services in namespace three-tier..."
kubectl get svc -n three-tier