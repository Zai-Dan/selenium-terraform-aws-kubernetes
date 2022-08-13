cd kubernetes-ingress/
cd deployments/
kubectl config set-context --current --namespace=selenium-grid
kubectl delete -f common/ns-and-sa.yaml
kubectl delete -f common/default-server-secret.yaml
kubectl delete -f common/nginx-config.yaml
kubectl delete -f common/custom-resource-definitions.yaml
kubectl delete -f rbac/rbac.yaml
kubectl delete -f daemon-set/nginx-ingress.yaml
kubectl get pods -n selenium-ingress