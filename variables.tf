variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "eks_role_name" {
  description = "Name of the IAM role for the EKS cluster"
  type        = string
}

variable "eksctl_version" {
  description = "Version of eksctl used for the EKS cluster"
  type        = string

}

variable "subnet_ids" {
  description = "Subnets for EKS Cluster"
  type        = list(string)
}

variable "service_ipv4_cidr" {
  description = "Cluster service IPv4 CIDR range"
  type        = string
  default     = "10.100.0.0/16"
}

variable "cluster_tags" {
  description = "Tags for the EKS cluster"
  type        = map(string)
  default = {
    Environment = "Staging-1.30"
  }
}

variable "launch_template_managed_large_name" {
  description = "Name of the managed large launch template"
  type        = string
}

variable "launch_template_managed_large_key_name" {
  description = "Key name for the managed large launch template"
  type        = string
}

# variable "launch_template_managed_large_sg_ids" {
#   description = "Security group IDs for the managed large launch template"
#   type        = list(string)
# }

variable "launch_template_managed_large_tags_instance" {
  description = "Tags for the instance in managed large launch template"
  type        = map(string)
}

variable "launch_template_managed_large_tags_volume" {
  description = "Tags for the volume in managed large launch template"
  type        = map(string)
}

variable "launch_template_managed_large_tags_network" {
  description = "Tags for the network interface in managed large launch template"
  type        = map(string)
}

variable "launch_template_managed_xlarge_name" {
  description = "Name of the managed xlarge launch template"
  type        = string
}

variable "launch_template_managed_xlarge_key_name" {
  description = "Key name for the managed xlarge launch template"
  type        = string
}

# variable "launch_template_managed_xlarge_sg_ids" {
#   description = "Security group IDs for the managed xlarge launch template"
#   type        = list(string)
# }

variable "launch_template_managed_xlarge_tags_instance" {
  description = "Tags for the instance in managed xlarge launch template"
  type        = map(string)
}

variable "launch_template_managed_xlarge_tags_volume" {
  description = "Tags for the volume in managed xlarge launch template"
  type        = map(string)
}

variable "launch_template_managed_xlarge_tags_network" {
  description = "Tags for the network interface in managed xlarge launch template"
  type        = map(string)
}
variable "node_role_name" {
  description = "Name of the IAM role for the EKS node group"
  type        = string
}

variable "nodegroup_configs" {
  description = "Configuration for EKS Node Groups"
  type = list(object({
    name                    = string
    instance_type           = string
    min_size                = number
    max_size                = number
    desired_size            = number
    ami_type                = string
    subnets                 = list(string)
    capacity_type           = string
    launch_template_version = string
    labels                  = map(string)
    tags                    = map(string)
  }))
}

variable "addons" {
  description = "EKS Addons configuration"
  type = list(object({
    name                     = string
    version                  = string
    service_account_role_arn = optional(string)
  }))
}
