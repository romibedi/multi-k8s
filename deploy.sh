docker build -t romibedi/multi-client:latest -t romibedi/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t romibedi/multi-server:latest -t romibedi/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t romibedi/multi-worker:latest -t romibedi/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push romibedi/multi-client:latest
docker push romibedi/multi-server:latest
docker push romibedi/multi-worker:latest

docker push romibedi/multi-client:$SHA
docker push romibedi/multi-server:$SHA
docker push romibedi/multi-worker:$SHA

kubectl apply -f k8ss

kubectl set image deployments/server-deployment server=romibedi/multi-server:$SHA  
kubectl set image deployments/client-deployment client=romibedi/multi-client:$SHA  
kubectl set image deployments/worker-deployment worker=romibedi/multi-worker:$SHA  