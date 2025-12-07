kubectl apply -f deploy/

после применения манифестов 
открыть два терминала
в одном сделать
kubectl port-forward -n nightmare-project svc/frontend 8080:80 &
в другом сделать 
kubectl port-forward -n nightmare-project svc/backend 5001:5000 &
