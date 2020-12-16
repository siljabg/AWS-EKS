#!/bin/bash

curl https://raw.githubusercontent.com/siljabg/content-python-for-sys-admins/master/helpers/bashrc -o ~/.bashrc
curl https://raw.githubusercontent.com/siljabg/content-python-for-sys-admins/master/helpers/vimrc -o ~/.vimrc
exec $SHELL  #to reload bash

export AWS_ACCESS_KEY_ID=AKIA3ZHOYC6ELX2ZTKTP                         # Replace [...] with the AWS Access Key ID
export AWS_SECRET_ACCESS_KEY=evNSRDg0TFbGtNukG8d/fpGBey0Tk5jhZsmHBxP3 # Replace [...] with the AWS Secret Access Key
export AWS_DEFAULT_REGION=us-east-1
export KUBECTL_VERSION=1.18.9

##OFFICIAL AWS EKS USERGUIDE
##https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

##install aws cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

##install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

##install kubectl
##kubectl version can be 2 version below master version
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/$KUBECTL_VERSION/2020-11-02/bin/linux/amd64/kubectl
curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/$KUBECTL_VERSION/2020-11-02/bin/linux/amd64/kubectl.sha256
openssl sha1 -sha256 kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client

##install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

##Configure AWS CLI credentials
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION

##Python 3 for centos
#add / in secure_path part in sudoers
#sudo vim /etc/sudoers
sudo su -
yum update -y
yum groupinstall -y "development tools"
yum install -y \
  libffi-devel \
  zlib-devel \
  bzip2-devel \
  openssl-devel \
  ncurses-devel \
  sqlite-devel \
  readline-devel \
  tk-devel \
  gdbm-devel \
  db4-devel \
  libpcap-devel \
  xz-devel \
  expat-devel \
  gcc \
  git
 
curl -O https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
tar -xzf Python-3.9.1.tgz
cd Python-3.9.1/
./configure --enable-optimizations
make altinstall
exit
python3.9
sudo pip3.9 install --upgrade pip
git config --global user.name "Dragan Siljanovski"
git config --global user.mail "dragan.siljanovski@gmail.com"
##check whether pip is installed
#python -m pip --version
pip3.9 list #to check installed package
sudo pip3.9 install boto3
pip3.9 freeze > requirements.txt
sudo pip3.9 uninstall -y -r requirements.txt
sudo pip3.9 install -r requirements.txt #put them in another directory

#python virtualenv
mkdir venvs
python3.9 -m venv venvs/experiment
ls venvs/experiment/
source venvs/experiment/bin/activate
which python
python --version
pip list
deactivate 



# Install chaostoolkit
#pip install -U chaostoolkit
# Discovering Kubernetes Plugin #
#pip install -U chaostoolkit-kubernetes
#chaos discover chaostoolkit-kubernetes
#cat discovery.json

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
