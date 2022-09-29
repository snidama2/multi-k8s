docker build -t sreehan/multi-client:latest -t sreehan/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t sreehan/multi-server:latest -t sreehan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sreehan/multi-worker:latest -t sreehan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sreehan/multi-client:latest
docker push sreehan/multi-server:latest
docker push sreehan/multi-worker:latest

docker push sreehan/multi-client:$SHA
docker push sreehan/multi-server:$SHA
docker push sreehan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sreehan/multi-server:$SHA
kubectl set image deployments/client-deployment client=sreehan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sreehan/multi-worker:$SHA