
## Setup the Environment

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv. 
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m venv ~/.devops
#source .devops/bin/activate
source ~/.devops/bin/activate
```
* Run `make install` to install the necessary dependencies
make install
### Running `app.py`

1. Standalone:  `python app.py`

2. Run in Docker:  `./run_docker.sh`
chmod +x run_docker.sh
./run_docker.sh

3. Run in Kubernetes:  `./run_kubernetes.sh`
chmod +x run_kubernetes.sh
./run_kubernetes.sh

### Kubernetes Steps

Setup and Configure Docker locally
Build docker locally using: `docker build -t my-docker-repo/app-name:tag .`
```
docker build -t halimausman/flaskapp:1 .
```

Setup and Configure Kubernetes locally
1. use eksctl to create k8s cluster
```
eksctl create cluster --region=us-east-1 --name=cluster-name
```

* Create Flask app in Container
* Run via kubectl
```
kubectl create deploy NAME_OF_DEPLOYMENT --image=DockerHubImage 
kubectl create deploy flaskapp --image=halimausman/flaskapp:1
```

To get deployed nodes use:
```
kubectl get nodes
```

To get more info about the pod use:
```
kubectl get deploy,rs,scv,pods
``` 

Expose the app to Port thus Port forwarding, use:
kubectl port-forward pod/NAME --address 0.0.0.0 PORT:PORT

