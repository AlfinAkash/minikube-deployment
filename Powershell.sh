PS D:\minikube> ls


    Directory: D:\minikube


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        25-08-2025  09.44 AM            712 deployment.yaml
-a----        22-05-2025  11.43 PM         265118 logo.ico
-a----        24-08-2025  11.57 AM       50764638 minikube-installer.exe
-a----        22-05-2025  11.43 PM      133410816 minikube.exe
-a----        25-08-2025  10.05 AM            227 service.yaml
-a----        25-08-2025  09.28 AM         440234 uninstall.exe
-a----        22-05-2025  11.43 PM           2982 update_path.ps1


PS D:\minikube> minikube start --driver=docker
😄  minikube v1.36.0 on Microsoft Windows 11 Home Single Language 10.0.26100.4946 Build 26100.4946
✨  Using the docker driver based on user configuration
📌  Using Docker Desktop driver with root privileges
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.47 ...
🔥  Creating docker container (CPUs=2, Memory=3900MB) ...
❗  Failing to connect to https://registry.k8s.io/ from inside the minikube container
💡  To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
🐳  Preparing Kubernetes v1.33.1 on Docker 28.1.1 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
PS D:\minikube> minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

PS D:\minikube> kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   43s   v1.33.1
PS D:\minikube> kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   82s
PS D:\minikube> kubectl apply -f deployment.yaml
deployment.apps/matrimony-deployment created
service/matrimony-service created
PS D:\minikube> kubectl get pods
NAME                                   READY   STATUS              RESTARTS   AGE
matrimony-deployment-fc5c447d9-6cwmq   0/1     ContainerCreating   0          16s
matrimony-deployment-fc5c447d9-drr2j   0/1     ContainerCreating   0          16s
PS D:\minikube> kubectl get svc
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes          ClusterIP   10.96.0.1       <none>        443/TCP        2m15s
matrimony-service   NodePort    10.96.246.225   <none>        80:30080/TCP   17s
PS D:\minikube> kubectl describe pod matrimony-deployment-fc5c447d9-6cwmq
Name:             matrimony-deployment-fc5c447d9-6cwmq
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Mon, 25 Aug 2025 11:05:36 +0530
Labels:           app=matrimony
                  pod-template-hash=fc5c447d9
Annotations:      <none>
Status:           Running
IP:               10.244.0.3
IPs:
  IP:           10.244.0.3
Controlled By:  ReplicaSet/matrimony-deployment-fc5c447d9
Containers:
  matrimony-container:
    Container ID:   docker://faf1885ed874e6babba32114fe64a72bc8764a1b4f60a3c962165c85f4f3f780
    Image:          alfinakash/matrimony:latest
    Image ID:       docker-pullable://alfinakash/matrimony@sha256:44a87a5f82a2643dfed63ed478d69f653a071ab6e177bbbb50fa2f396526eb0e
    Port:           3000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 25 Aug 2025 11:06:35 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zt55r (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-zt55r:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  74s   default-scheduler  Successfully assigned default/matrimony-deployment-fc5c447d9-6cwmq to minikube
  Normal  Pulling    73s   kubelet            Pulling image "alfinakash/matrimony:latest"
  Normal  Pulled     15s   kubelet            Successfully pulled image "alfinakash/matrimony:latest" in 58.369s (58.369s including waiting). Image size: 589713513 bytes.
  Normal  Created    15s   kubelet            Created container: matrimony-container
  Normal  Started    15s   kubelet            Started container matrimony-container
PS D:\minikube> kubectl apply -f service.yaml
service/matrimony-service configured
PS D:\minikube> kubectl get pods -o wide
NAME                                   READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
matrimony-deployment-fc5c447d9-6cwmq   1/1     Running   0          2m29s   10.244.0.3   minikube   <none>           <none>
matrimony-deployment-fc5c447d9-drr2j   1/1     Running   0          2m29s   10.244.0.4   minikube   <none>           <none>
PS D:\minikube> minikube ip
192.168.49.2
PS D:\minikube> kubectl get svc matrimony-service
NAME                TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
matrimony-service   NodePort   10.96.246.225   <none>        80:30080/TCP   2m54s
PS D:\minikube> kubectl port-forward svc/matrimony-service 8080:8080
error: Service matrimony-service does not have a service port 8080
PS D:\minikube> minikube service matrimony-service
|-----------|-------------------|-------------|---------------------------|
| NAMESPACE |       NAME        | TARGET PORT |            URL            |
|-----------|-------------------|-------------|---------------------------|
| default   | matrimony-service |          80 | http://192.168.49.2:30080 |
|-----------|-------------------|-------------|---------------------------|
🏃  Starting tunnel for service matrimony-service.
|-----------|-------------------|-------------|------------------------|
| NAMESPACE |       NAME        | TARGET PORT |          URL           |
|-----------|-------------------|-------------|------------------------|
| default   | matrimony-service |             | http://127.0.0.1:63899 |
|-----------|-------------------|-------------|------------------------|
🎉  Opening service default/matrimony-service in default browser...
❗  Because you are using a Docker driver on windows, the terminal needs to be open to run it.

----------------------------------------------------------------------------------------------------------------------------------------
PS D:\minikube> kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
matrimony-deployment-fc5c447d9-6cwmq   1/1     Running   0          12m
matrimony-deployment-fc5c447d9-drr2j   1/1     Running   0          12m
PS D:\minikube>
