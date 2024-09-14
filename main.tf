resource "aws_eks_cluster" "new_eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
  }

  tags = var.cluster_tags
}

resource "aws_launch_template" "EKS_NG_large_01_Template" {
  name     = var.launch_template_managed_large_name
  key_name = var.launch_template_managed_large_key_name ## Need to check this
  #vpc_security_group_ids = var.launch_template_managed_large_sg_ids

  tag_specifications {
    resource_type = "instance"
    tags          = var.launch_template_managed_large_tags_instance
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.launch_template_managed_large_tags_volume
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = var.launch_template_managed_large_tags_network
  }
}

resource "aws_launch_template" "EKS_NG_xlarge_01_Template" {
  name     = var.launch_template_managed_xlarge_name
  key_name = var.launch_template_managed_xlarge_key_name
  #vpc_security_group_ids = var.launch_template_managed_xlarge_sg_ids

  tag_specifications {
    resource_type = "instance"
    tags          = var.launch_template_managed_xlarge_tags_instance
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.launch_template_managed_xlarge_tags_volume
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = var.launch_template_managed_xlarge_tags_network
  }
}

resource "aws_eks_node_group" "new_eks_node_group" {
  for_each = { for nodegroup in var.nodegroup_configs : nodegroup.name => nodegroup }

  cluster_name    = aws_eks_cluster.new_eks_cluster.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = each.value.subnets
  ami_type        = each.value.ami_type
  capacity_type   = each.value.capacity_type
  instance_types  = [each.value.instance_type]

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  launch_template {
    id      = each.value.name == "EKS_NG_large_01" ? aws_launch_template.EKS_NG_large_01_Template.id : aws_launch_template.EKS_NG_xlarge_01_Template.id
    version = "$Latest" # Automatically uses the latest version
  }

  labels = each.value.labels
  tags   = each.value.tags
}

resource "aws_eks_addon" "new_eks_addon" {
  for_each = { for addon in var.addons : addon.name => addon }

  cluster_name             = aws_eks_cluster.new_eks_cluster.name
  addon_name               = each.value.name
  addon_version            = each.value.version
  service_account_role_arn = lookup(each.value, "service_account_role_arn", null)
}
