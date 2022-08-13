kubectl config set-context --current --namespace=selenium-grid

kubectl delete -f k8s/nginx-deploy.yml

kubectl delete -f k8s/selenium_deployment.yml

kubectl delete -f k8s/service.yml

kubectl delete -f k8s/selenium-hub-deployement-ingress.yaml

kubectl delete -f k8s/selenium_node.yml

kubectl delete -f k8s/cluster-autoscaler.yml

kubectl -n selenium-grid get pods