####################
# Create a cluster #
####################

# Follow the instructions from https://github.com/weaveworks/eksctl to intall eksctl if you do not have it already

export AWS_ACCESS_KEY_ID=[...] # Replace [...] with the AWS Access Key ID

export AWS_SECRET_ACCESS_KEY=[...] # Replace [...] with the AWS Secret Access Key

export AWS_DEFAULT_REGION=eu-west-1

eksctl create cluster \
    --name dev-cluster \
    --version 1.18 \
    --region $AWS_DEFAULT_REGION \
    --nodegroup-name standrad-workers \
    --node-type t3.micro \
    --nodes 3 \
    --nodes-min 1 \
    --nodes-max 4 \
    --managed

aws eks update-kubeconfig --name dev-cluster --region us-east-1

#######################
# Destroy the cluster #
#######################

eksctl delete cluster \
    --name dev-cluster \
    --region $AWS_DEFAULT_REGION

# Delete unused volumes
for volume in `aws ec2 describe-volumes --output text| grep available | awk '{print $8}'`; do 
    echo "Deleting volume $volume"
    aws ec2 delete-volume --volume-id $volume
done
