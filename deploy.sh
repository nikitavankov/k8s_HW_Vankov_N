#!/bin/bash

echo "1. Creating namespace..."
kubectl apply -f deploy/namespace.yml
sleep 2

echo "2. Creating ConfigMaps..."
kubectl apply -f deploy/mongo-configmap.yml
kubectl apply -f deploy/webapp-configmap.yml
sleep 1

echo "3. Creating Secrets..."
kubectl apply -f deploy/mongo-secret.yml
kubectl apply -f deploy/webapp-secret.yml
sleep 1

echo "4. Deploying MongoDB..."
kubectl apply -f deploy/mongo-deployment.yml

echo "   Waiting for MongoDB to be ready..."
kubectl wait --namespace webapp-demo --for=condition=available --timeout=60s deployment/mongodb

echo "5. Creating MongoDB Service..."
kubectl apply -f deploy/mongo-service.yml
sleep 3

echo "6. Deploying Web Application..."
kubectl apply -f deploy/webapp-deployment.yml

echo "7. Creating Web Application Service..."
kubectl apply -f deploy/webapp-service.yml

echo "8. Checking status..."
kubectl get all -n webapp-demo
echo ""
echo "Access the application at: http://<node-ip>:30081"
echo "Login: admin / Password: admin123"