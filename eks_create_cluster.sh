####################
# Create a cluster #
####################

# Follow the instructions from https://github.com/weaveworks/eksctl to intall eksctl if you do not have it already

export AWS_ACCESS_KEY_ID=[...] # Replace [...] with the AWS Access Key ID

export AWS_SECRET_ACCESS_KEY=[...] # Replace [...] with the AWS Secret Access Key

export AWS_DEFAULT_REGION=eu-west-1

eksctl create cluster \
    --name <cluster_name> \
    --version 1.17 \
    --region $AWS_DEFAULT_REGION \
    --nodegroup-name <name>
    --node-type t3.micro \
    --nodes 2 \
    --managed

#######################
# Destroy the cluster #
#######################

eksctl delete cluster \
    --name <cluster_name> \
    --region $AWS_DEFAULT_REGION

# Delete unused volumes
for volume in `aws ec2 describe-volumes --output text| grep available | awk '{print $8}'`; do 
    echo "Deleting volume $volume"
    aws ec2 delete-volume --volume-id $volume
done
