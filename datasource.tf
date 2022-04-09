data "aws_ecs_cluster" "cluster_iac" {
  cluster_name = var.cluster_name
}

data "aws_lb_target_group" "iac_tg" {
  name = "target-group-${var.cluster_name}"
}
