# k8s_HW_Vankov_N

ИНСТРУКЦИЯ ПО РАЗВЕРТЫВАНИЮ:

# 1. Сначала создаем Namespace (основа всего)
kubectl apply -f deploy/namespace.yml

# 2. Создаем ConfigMaps (они не зависят от других ресурсов)
kubectl apply -f deploy/mongo-configmap.yml
kubectl apply -f deploy/webapp-configmap.yml

# 3. Создаем Secrets (пароли и чувствительные данные)
kubectl apply -f deploy/mongo-secret.yml
kubectl apply -f deploy/webapp-secret.yml

# 4. Запускаем MongoDB Deployment (база данных должна запуститься первой)
kubectl apply -f deploy/mongo-deployment.yml

# 5. Создаем Service для MongoDB (чтобы веб-приложение могло подключиться)
kubectl apply -f deploy/mongo-service.yml

# 6. Запускаем веб-приложение (mongo-express)
kubectl apply -f deploy/webapp-deployment.yml

# 7. Создаем Service для веб-приложения (NodePort)
kubectl apply -f deploy/webapp-service.yml


kubectl port-forward -n webapp-demo svc/webapp-service 8080:80 --address='0.0.0.0'
