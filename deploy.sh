docker build -t farzanaeva/multi-client:latest -t farzanaeva/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t farzanaeva/multi-server:latest -t farzanaeva/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t farzanaeva/multi-worker:latest -t farzanaeva/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push farzanaeva/multi-client:latest
docker push farzanaeva/multi-server:latest
docker push farzanaeva/multi-worker:latest

docker push farzanaeva/multi-client:$SHA
docker push farzanaeva/multi-server:$SHA
docker push farzanaeva/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=farzanaeva/multi-server:$SHA
kubectl set image deployments/client-deployment client=farzanaeva/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=farzanaeva/multi-worker:$SHA