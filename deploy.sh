docker build -t suriyak8s/multi-client:latest -t suriyak8s/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t suriyak8s/multi-server:latest -t suriyak8s/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t suriyak8s/multi-worker:latest -t suriyak8s/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push suriyak8s/multi-client:latest
docker push suriyak8s/multi-server:latest
docker push suriyak8s/multi-worker:latest
docker push suriyak8s/multi-client:$SHA
docker push suriyak8s/multi-server:$SHA
docker push suriyak8s/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=suriyak8s/multi-server:$SHA
kubectl set image deployments/client-deployment client=suriyak8s/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=suriyak8s/multi-worker:$SHA