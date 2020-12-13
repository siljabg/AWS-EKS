# AWS-EKS

Download eks_prerequisites.sh script \
Edit and enter your aws credentials details \
give execute permissions and run it \
chmod +x eks_prerequisites.sh \
./eks_prerequisites.sh \

eksctl utils update-cluster-logging --config-file eks-course.yaml --approve  (--disable-types all)

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
