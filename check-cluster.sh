#!/bin/bash

# Script to check current Kubernetes cluster and Helm deployment locations
# To run - chmod +x /Users/jameshill/Learning/helm-course/check-cluster.sh

#to use it:
#./check-cluster.sh
#To check a specific GKE cluster:
# Switch to a GKE cluster first
#
#kubectl config use-context gke_jh-learning_europe-west1_cluster-1

# Then run the script  ./check-cluster.sh

echo "=========================================="
echo "Kubernetes Cluster Information"
echo "=========================================="
echo ""

# Get current kubectl context
CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "Current Context: $CURRENT_CONTEXT"
else
    echo "❌ Error: No kubectl context found. Is kubectl configured?"
    exit 1
fi

echo ""

# Get current cluster from context
CURRENT_CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}' 2>/dev/null)
echo "Current Cluster: $CURRENT_CLUSTER"

# Get cluster server URL
CLUSTER_SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' 2>/dev/null)
echo "Cluster Server: $CLUSTER_SERVER"

# Check if it's a GKE cluster
if [[ "$CLUSTER_SERVER" == *"gke"* ]] || [[ "$CLUSTER_SERVER" == *"googleapis"* ]]; then
    echo "✅ This is a GKE (Google Kubernetes Engine) cluster"
    
    # Try to extract GKE cluster details
    if [[ "$CLUSTER_SERVER" =~ gke\.([^/]+)\.([^/]+)\.([^/]+) ]]; then
        GKE_ZONE="${BASH_REMATCH[2]}"
        GKE_PROJECT="${BASH_REMATCH[1]}"
        GKE_CLUSTER="${BASH_REMATCH[3]}"
        echo "   Project: $GKE_PROJECT"
        echo "   Zone/Region: $GKE_ZONE"
        echo "   Cluster Name: $GKE_CLUSTER"
    fi
else
    echo "ℹ️  This is not a GKE cluster"
    if [[ "$CLUSTER_SERVER" == *"minikube"* ]]; then
        echo "   Detected: Minikube"
    elif [[ "$CLUSTER_SERVER" == *"localhost"* ]] || [[ "$CLUSTER_SERVER" == *"127.0.0.1"* ]]; then
        echo "   Detected: Local cluster"
    fi
fi

echo ""
echo "=========================================="
echo "Helm Releases and Deployment Locations"
echo "=========================================="
echo ""

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "❌ Helm is not installed"
    exit 1
fi

# Get all Helm releases across all namespaces
HELM_RELEASES=$(helm list --all-namespaces 2>/dev/null)

if [ -z "$HELM_RELEASES" ] || [ "$HELM_RELEASES" == "NAME	NAMESPACE	REVISION	UPDATED	STATUS	CHART	APP VERSION" ]; then
    echo "ℹ️  No Helm releases found"
else
    echo "Helm Releases:"
    echo "$HELM_RELEASES" | while IFS= read -r line; do
        if [[ "$line" != "NAME"* ]]; then
            RELEASE_NAME=$(echo "$line" | awk '{print $1}')
            NAMESPACE=$(echo "$line" | awk '{print $2}')
            STATUS=$(echo "$line" | awk '{print $5}')
            echo "   - Release: $RELEASE_NAME"
            echo "     Namespace: $NAMESPACE"
            echo "     Status: $STATUS"
            echo ""
        fi
    done
    
    # Show summary by namespace
    echo "Summary by Namespace:"
    helm list --all-namespaces --output json 2>/dev/null | \
        jq -r '.[] | "\(.namespace): \(.name) (\(.status))"' 2>/dev/null || \
        helm list --all-namespaces | tail -n +2 | awk '{print $2}' | sort | uniq -c | \
        awk '{print "   " $2 ": " $1 " release(s)"}'
fi

echo ""
echo "=========================================="
echo "Current Namespace"
echo "=========================================="
echo ""

CURRENT_NS=$(kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null)
if [ -z "$CURRENT_NS" ]; then
    CURRENT_NS="default"
fi
echo "Current Namespace: $CURRENT_NS"

echo ""
echo "=========================================="
echo "All Available Contexts"
echo "=========================================="
echo ""

kubectl config get-contexts

echo ""
echo "=========================================="
echo "Quick Commands"
echo "=========================================="
echo ""
echo "To switch context: kubectl config use-context <context-name>"
echo "To list all Helm releases: helm list --all-namespaces"
echo "To see cluster info: kubectl cluster-info"
