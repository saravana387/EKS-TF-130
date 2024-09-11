aws_region      = "eu-west-1"
cluster_name    = "DataApi_EKS_Staging_130"
cluster_version = "1.30"


eks_role_name  = "eks-cluster-role-staging"
eksctl_version = "0.140.0"
node_role_name = "eks-nodegroup-role-staging"


subnet_ids = [
  "subnet-039f2e894005b6ee3",
  "subnet-0413cced8f6f0405e",
  "subnet-08bfb537f46bd53ce",
  "subnet-0f157f665b5744fe3",
  "subnet-00bb7c6581e64e06e",
  "subnet-07936f426743ef10c"
]


service_ipv4_cidr = "10.100.0.0/16"

cluster_tags = {
  Environment = "new-staging-1.30"
}

launch_template_managed_large_name     = "EKS_NG_large_01_Template"
launch_template_managed_large_key_name = "sre_ew1_linux"
#launch_template_managed_large_sg_ids        = ["sg-03f10d465b5ec021e", "sg-08566a9d89765c240"]
launch_template_managed_large_tags_instance = { Name = "eks-node-large-01", alpha_eksctl_io_nodegroup_name = "managed-large-01", alpha_eksctl_io_nodegroup_type = "managed" }
launch_template_managed_large_tags_volume   = { Name = "eks-node-large-01", alpha_eksctl_io_nodegroup_name = "managed-large-01", alpha_eksctl_io_nodegroup_type = "managed" }
launch_template_managed_large_tags_network  = { Name = "eks-node-large-01", alpha_eksctl_io_nodegroup_name = "managed-large-01", alpha_eksctl_io_nodegroup_type = "managed" }

launch_template_managed_xlarge_name     = "EKS_NG_xlarge_01_Template"
launch_template_managed_xlarge_key_name = "sre_ew1_linux"
#launch_template_managed_xlarge_sg_ids        = ["sg-03f10d465b5ec021e", "sg-08566a9d89765c240"]
launch_template_managed_xlarge_tags_instance = { Name = "eks-node-xlarge-01", alpha_eksctl_io_nodegroup_name = "managed-xlarge-01", alpha_eksctl_io_nodegroup_type = "managed" }
launch_template_managed_xlarge_tags_volume   = { Name = "eks-node-xlarge-01", alpha_eksctl_io_nodegroup_name = "managed-xlarge-01", alpha_eksctl_io_nodegroup_type = "managed" }
launch_template_managed_xlarge_tags_network  = { Name = "eks-node-xlarge-01", alpha_eksctl_io_nodegroup_name = "managed-xlarge-01", alpha_eksctl_io_nodegroup_type = "managed" }

nodegroup_configs = [
  {
    name          = "EKS_NG_large_01"
    instance_type = "t3a.large"
    min_size      = 1
    max_size      = 5
    desired_size  = 2
    ami_type      = "AL2_x86_64"
    #node_role_arn           = "arn:aws:iam::833792052071:role/old-nodegroup-role"
    subnets                 = ["subnet-039f2e894005b6ee3", "subnet-0413cced8f6f0405e", "subnet-08bfb537f46bd53ce"]
    capacity_type           = "ON_DEMAND"
    launch_template_version = "1"
    labels                  = { "nodegroup-role" = "worker", "deployment-tag" = "3.0.0" }
    tags                    = { "Environment" = "staging-1.30" }
  },
  {
    name          = "EKS_NG_xlarge_01"
    instance_type = "t3a.xlarge"
    min_size      = 1
    max_size      = 5
    desired_size  = 2
    ami_type      = "AL2_x86_64"
    #node_role_arn           = "arn:aws:iam::833792052071:role/new-nodegroup-role"
    subnets                 = ["subnet-0f157f665b5744fe3", "subnet-00bb7c6581e64e06e", "subnet-07936f426743ef10c"]
    capacity_type           = "ON_DEMAND"
    launch_template_version = "1"
    labels                  = { "nodegroup-role" = "worker", "deployment-tag" = "3.0.0" }
    tags                    = { "Environment" = "staging-1.30" }
  }
]

addons = [
  {
    name    = "vpc-cni"
    version = "v1.18.3-eksbuild.2"
  },
  {
    name    = "coredns"
    version = "v1.11.1-eksbuild.8"
  },
  {
    name    = "kube-proxy"
    version = "v1.30.3-eksbuild.2"

  }

]
