module "ecs_mentoria" {
  source         = "../"
  create_cluster = false
  #app_port       = 80
  region         = "us-east-1"
  app_count      = 1
  fargate_cpu    = 256
  fargate_memory = 512
  subnet_ids     = ["subnet-06399d8a8ab548ac5", "subnet-0736facc920782b02"]
  vpc_id         = "vpc-0d5dbc81d1124c013"
  protocol       = "HTTP"
  family_name    = "mentoria-app2"
  service_name   = "mentoria-app2"
  cluster_name   = "mentoria"
  template_container = [{
    name      = "app-2"
    image     = "nginx"
    cpu       = 128
    memory    = 256
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "mentoria-iac-app2"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "app2"

      }
    }
  }]
}

#output "load_balancer_dns_name" {
#  value = "http://${module.ecs_mentoria[0].loadbalance_dns_name}"
#}
