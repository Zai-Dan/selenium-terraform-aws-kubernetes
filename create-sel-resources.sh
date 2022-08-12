kubectl create ns selenium-ingress

kubectl apply -f k8s/selenium_deployment.yml

kubectl create -f k8s/service.yml

kubectl create -f k8s/service.yml

kubectl create -f k8s/selenium_node.yml

kubectl create -f k8s/cluster-autoscaler.yml

kubectl -n selenium-ingress get pods 