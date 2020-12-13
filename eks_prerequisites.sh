#!/bin/bash

# if you need docker check if docker is installed
which docker

if [ $? -eq 0 ]
then
    docker --version | grep "Docker version"
    if [ $? -eq 0 ]
    then
        echo "docker existing"
    else
        echo "Please install docker"
    fi
else
    echo "Please install docker" >&2
fi

#OFFICIAL AWS EKS USERGUIDE
#https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

#install aws cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

#install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

#install kubectl
#kubectl version can be 2 version below master version
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl.sha256
openssl sha1 -sha256 kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client

#install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#Configure AWS CLI credentials
aws configure set aws_access_key_id AKIASIZY5IJBXMAW2OFP
aws configure set aws_secret_access_key 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
aws configure set default.region us-west-2
