docker build -t numendivinum/multi-client:latest -t numendivinum/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t numendivinum/multi-server:latest -t numendivinum/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t numendivinum/multi-worker:latest -t numendivinum/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push numendivinum/multi-client:latest
docker push numendivinum/multi-server:latest
docker push numendivinum/multi-worker:latest
docker push numendivinum/multi-client:$GIT_SHA
docker push numendivinum/multi-server:$GIT_SHA
docker push numendivinum/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=numendivinum/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=numendivinum/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=numendivinum/multi-worker:$GIT_SHA
