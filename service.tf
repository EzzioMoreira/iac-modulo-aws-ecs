resource "aws_ecs_service" "service_cluster" {
  count           = (local.cluster_count == 0 ? 1 : 0)
  name            = var.service_name
  cluster         = (local.cluster_count == 0 ? data.aws_ecs_cluster.cluster_iac.arn : aws_ecs_cluster.cluster_iac[0].arn)
  task_definition = aws_ecs_task_definition.task_cluster[0].arn
  launch_type     = "FARGATE"
  desired_count   = var.app_count


  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = aws_security_group.allow_access[*].id
  }

  load_balancer {
    target_group_arn = (local.cluster_count == 0 ? data.aws_lb_target_group.iac_tg.id : aws_lb_target_group.iac_tg[0].id)
    container_name   = element(var.template_container.*.name, 0)
    container_port   = var.app_port == null ? null : var.app_port
  }

  tags = local.tags

  depends_on = [aws_iam_role.ecs_task_execution_role]
}
