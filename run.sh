# install kubectl
brew install kubectl
# install package distribution manager
brew install helm
# install kind for local development
brew install kind
# get all namespaces in the cluster
kubectl get ns
# create a namespace
kubectl create ns airflow
# add official helm chart for airflow
helm repo add apache-airflow https://airflow.apache.org
# update the repo
helm repo update
# install helm chart 
helm install airflow apache-airflow/airflow --namespace airflow --debug
# get the pods in the airflow namespace
kubectl get pods -n airflow
# get the services in the airflow namespace
kubectl get svc -n airflow
# get the logs of the scheduler pod
kubectl logs -f airflow-scheduler-pod-id -n airflow
# run the airflow webserver
kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow
# store helm chart values in a file
helm show values apache-airflow/airflow > values.yaml
# upload config map in the kubernetes cluster
kubectl apply -f variables.yaml -n airflow
# update helm chart
helm upgrade --install airflow apache-airflow/airflow -n airflow -f values.yaml --debug
# get status for a single pod
kubectl describe pods airflow-scheduler-7fdf9d7cd6-r95sn -n airflow
# execute a bash command inside a pod
kubectl exec --stdin --tty airflow-webserver-57fc95f474-5kplt -n airflow -- /bin/bash
# load a docker image inside the kubernetes cluster
kind load docker-image airflow-custom:1.0.0 --name airflow-cluster
# get some info on the running airflow instance
kubectl exec --stdin --tty airflow-webserver-57fc95f474-5kplt -n airflow -- airflow info