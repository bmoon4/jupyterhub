# jupyterhub


## KinD start

```
(in my how-to-kinD repo local path)
❯ kind create cluster --config kind-example-config.yaml --name moon
```


## image build and push
```
docker build -t bmoon0702/jupyterhub:test .

docker push bmoon0702/jupyterhub:test
```

## load image in cluster

```
kind load docker-image bmoon0702/jupyterhub:test --name moon
```

## k8s deployment

```
kubectl apply -f k8s/deployment.yaml

kubectl apply -f k8s/service.yaml
```

## port forwarding

```
❯ kubectl port-forward svc/jupyterhub 8080:8000
Forwarding from 127.0.0.1:8080 -> 8000
Forwarding from [::1]:8080 -> 8000
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
...
```

## web gui

```
http://localhost:8080
```
![Image](https://github.com/user-attachments/assets/eb05f63b-67cf-4221-8558-af05927304fb)

