# k8s_HW_Vankov_N

ИНСТРУКЦИЯ ПО РАЗВЕРТЫВАНИЮ:

1. Развернуть все компоненты:
   kubectl apply -f deploy/

2. Проверить созданные ресурсы:
   kubectl get all -n webapp-demo
   Убедитесь, что все Pod'ы перешли в состояние Running, а Service — Available.

3. Проверить логи приложения:
   kubectl logs -n webapp-demo deployment/webapp -f

4. Получить NodePort для доступа:
   kubectl get svc -n webapp-demo webapp-service
# Шаг 4A: Получить NodePort (он будет 30080, как указано в манифесте)
kubectl get svc -n webapp-demo webapp-service

# Шаг 4B: Получить внешний IP-адрес одной из нод кластера
kubectl get nodes -o wide

5. Доступ к приложению:

Веб-интерфейс MongoDB (mongo-express): Откройте в браузере: http://<NODE_IP>:30080
Данные для аутентификации:
Логин: admin
Пароль: admin123
MongoDB доступна внутри кластера по адресу: mongodb.webapp-demo.svc.cluster.local:27017
