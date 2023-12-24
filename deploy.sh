docker build -t arahanthjain/multi-client:latest -t arahanthjain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arahanthjain/multi-server:latest -t arahanthjain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arahanthjain/multi-worker:latest -t arahanthjain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arahanthjain/multi-client:latest 
docker push arahanthjain/multi-server:latest 
docker push arahanthjain/multi-worker:latest 
docker push arahanthjain/multi-client:$SHA
docker push arahanthjain/multi-server:$SHA
docker push arahanthjain/multi-worker:$SHA

kubectl apply -f /k8s

kubectl set image deployment/server-deployment server=arahanthjain/multi-server:$SHA
kubectl set image deployment/client-deployment client=arahanthjain/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=arahanthjain/multi-worker:$SHA