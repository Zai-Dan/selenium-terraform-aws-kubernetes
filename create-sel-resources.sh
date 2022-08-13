kubectl create ns selenium-grid

kubectl config set-context --current --namespace=ingress-nginx

kubectl apply -f k8s/ingress.yml

kubectl create -f k8s/nginx-deploy.yml

kubectl apply -f k8s/selenium_deployment.yml

kubectl create -f k8s/service.yml

kubectl create -f k8s/selenium_node.yml

kubectl create -f k8s/cluster-autoscaler.yml

kubectl -n ingress-nginx get pods 