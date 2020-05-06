docker build -t sampetrie/multi-client:latest -t sampetrie/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sampetrie/multi-server:latest -t sampetrie/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sampetrie/multi-worker:latest -t sampetrie/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sampetrie/multi-client:latest
docker push sampetrie/multi-client:$SHA
docker push sampetrie/multi-server:latest
docker push sampetrie/multi-server:$SHA
docker push sampetrie/multi-worker:latest
docker push sampetrie/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sampetrie/multi-server:$SHA
kubectl set image deployments/client-deployment client=sampetrie/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sampetrie/multi-worker:$SHA