resource "aws_ecs_task_definition" "task_cluster" {
  count                    = (local.cluster_count == 0 ? 1 : 0)
  family                   = "${var.family_name}-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  network_mode             = "awsvpc"
  container_definitions    = jsonencode(var.template_container)
  execution_role_arn       = aws_iam_role.ecs_task_execution_role[0].arn

  tags = local.tags
}
