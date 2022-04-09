resource "aws_iam_role" "ecs_task_execution_role" {
  count = (local.cluster_count == 0 ? 1 : 0)
  name  = "allow_execution_svc_log${var.service_name}-${count.index}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com",

          ]
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  count = (local.cluster_count == 0 ? 1 : 0)
  role       = aws_iam_role.ecs_task_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
