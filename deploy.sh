docker build -t syam3222/multi-client:latest -t syam3222/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t syam3222/multi-server:latest -t syam3222/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t syam3222/multi-worker:latest -t syam3222/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push syam3222/multi-client:latest
docker push syam3222/multi-server:latest
docker push syam3222/multi-worker:latest

docker push syam3222/multi-client:$SHA
docker push syam3222/multi-server:$SHA
docker push syam3222/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=syam3222/multi-server:$SHA
kubectl set image deployments/client-deployment client=syam3222/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=syam3222/multi-worker:$SHA