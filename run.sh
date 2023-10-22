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