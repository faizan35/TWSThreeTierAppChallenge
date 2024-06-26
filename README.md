# #TWSThreeTierAppChallenge

## Overview
This repository hosts the `#TWSThreeTierAppChallenge` for the TWS community. 
The challenge involves deploying a Three-Tier Web Application using ReactJS, NodeJS, and MongoDB, with deployment on AWS EKS. Participants are encouraged to deploy the application, add creative enhancements, and submit a Pull Request (PR). Merged PRs will earn exciting prizes!

## Troubleshoot

- Works also: `kubectl exec -it frontend-67fd64687-9nvsm -n three-tier -- curl http://api:3500/api/tasks`


```bash
git clone https://github.com/faizan35/TWSThreeTierAppChallenge.git
```

## K8s

- Namespace: `kubectl create namespace three-tier`


## add policy

- `arn:aws:iam::325954021681:root`: EKS Access


## Docker

### Build Docker Images

1. Frontend

```bash
cd frontend/
sudo docker build -t faizan44/tws_three_tier_app_frontend:latest .
```

2. Backend

```bash
cd backend/
sudo docker build -t faizan44/tws_three_tier_app_backend:latest .
```

### Push to DockerHub

- `sudo docker push faizan44/tws_three_tier_app_frontend`
- `sudo docker push faizan44/tws_three_tier_app_backend`


## Getting Started
To get started with this project, refer to our [comprehensive guide](https://amanpathakdevops.medium.com/advanced-end-to-end-devsecops-kubernetes-three-tier-project-using-aws-eks-argocd-prometheus-fbbfdb956d1a) that walks you through IAM user setup, infrastructure provisioning, CI/CD pipeline configuration, EKS cluster creation, and more.

### Step 1: IAM Configuration
- Create a user `eks-admin` with `AdministratorAccess`.
- Generate Security Credentials: Access Key and Secret Access Key.

### Step 2: EC2 Setup
- Launch an Ubuntu instance in your favourite region (eg. region `us-west-2`).
- SSH into the instance from your local machine.

### Step 3: Install AWS CLI v2

``` shell
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin --update
/usr/local/bin/aws --version
```

##### configure AWS

``` shell
aws configure
```

### Step 4: Install Docker
``` shell
sudo apt-get update
sudo apt install docker.io
docker ps
sudo chown $USER /var/run/docker.sock
```

### Step 5: Install kubectl
``` shell
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client
```

### Step 6: Install eksctl
``` shell
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

### Step 7: Setup EKS Cluster

``` shell
eksctl create cluster --name three-tier-cluster --region us-west-2 --node-type t2.medium --nodes-min 2 --nodes-max 2
```

``` shell
aws eks update-kubeconfig --region us-west-2 --name three-tier-cluster
kubectl get nodes
```

### Step 8: Run Manifests with Script

```bash
git clone https://github.com/faizan35/TWSThreeTierAppChallenge.git
cd TWSThreeTierAppChallenge/Kubernetes-Manifests-file
```

``` shell
bash all-three-tier-manifest.sh
```

### Step 9: Install AWS Load Balancer

``` shell
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
eksctl utils associate-iam-oidc-provider --region=us-west-2 --cluster=three-tier-cluster --approve
```

``` shell
eksctl create iamserviceaccount --cluster=three-tier-cluster --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::325954021681:policy/AWSLoadBalancerControllerIAMPolicy --approve --region=us-west-2
```


- If error append this in `eksctl create iamserviceaccount` Command: `--override-existing-serviceaccounts`



### Step 10: Deploy AWS Load Balancer Controller

``` shell
sudo snap install helm --classic
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=three-tier-cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## Step 11: Apply Ingerss

``` shell
kubectl apply -f ingress.yaml
```

``` shell
kubectl get ing -n three-tier
```

### Cleanup

- To delete the EKS cluster:

``` shell
eksctl delete cluster --name three-tier-cluster --region us-west-2
```

## Contribution Guidelines
- Fork the repository and create your feature branch.
- Deploy the application, adding your creative enhancements.
- Ensure your code adheres to the project's style and contribution guidelines.
- Submit a Pull Request with a detailed description of your changes.

## Rewards
- Successful PR merges will be eligible for exciting prizes!

## Support
For any queries or issues, please open an issue in the repository.

---
Happy Learning! 🚀👨‍💻👩‍💻
