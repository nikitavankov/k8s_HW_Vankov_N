Task Manager (React + Express + MongoDB)
Простое веб-приложение для управления задачами (таск-менеджер), развернутое в Kubernetes кластере.

Архитектура
Приложение состоит из трех компонентов:

Frontend: React-приложение
Backend: Express.js сервер
Database: MongoDB

Развертывание в Kubernetes

1. Развертывание всех компонентов
kubectl apply -f deploy/

2. Проверка статуса развертывания
kubectl get all -n task-board -o wide

Убедитесь, что все Pods находятся в состоянии Running:
frontend-deployment-*
backend-deployment-*
mongodb-deployment-*

А также что созданы три сервиса:
frontend-service
backend-service
mongodb-service

Доступ к приложению
После успешного развертывания получите URL для доступа к фронтенду:


NODE_PORT=$(kubectl get svc frontend-service -n task-board -o jsonpath='{.spec.ports[0].nodePort}')

NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
echo "Откройте в браузере: http://$NODE_IP:$NODE_PORT"

Структура манифестов Kubernetes
В директории deploy/ находятся следующие файлы:

	Файл /	Назначение
	namespace.yaml	               / Создает namespace task-board
	configmap.yaml                 /	Переменные окружения (аналогично docker-compose)
	secret.yaml                    /	Учетные данные для MongoDB
	mongodb-deployment.yaml        /	Deployment для MongoDB с использованием emptyDir volume
	mongodb-service.yaml           /	ClusterIP сервис для доступа к MongoDB
	backend-deployment.yaml        /	Deployment для бэкенда с liveness/readiness пробами
	backend-service.yaml           /	ClusterIP сервис для бэкенда
	frontend-deployment.yaml       /	Deployment для фронтенда с liveness/readiness пробами
	frontend-service.yaml          /	NodePort сервис для доступа к фронтенду


Приложение использует следующие предварительно собранные образы:

Frontend образ: nikitavankov/react-express-mongodb-frontend


Backend образ: nikitavankov/react-express-mongodb-backend


Основа проекта

Исходный код приложения и Docker конфигурация основаны на примере из репозитория:
https://github.com/docker/awesome-compose/tree/master/react-express-mongodb

Удаление приложения
Для полного удаления приложения из кластера:

kubectl delete -f deploy/
