#!/bin/bash
sudo chmod 777 /var/run/docker.sock
$(aws ecr get-login --no-include-email --region us-east-1)
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm init;
sleep 10;
helm install devapp --name dev

