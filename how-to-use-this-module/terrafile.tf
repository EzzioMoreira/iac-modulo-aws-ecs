module "ecs_mentoria" {
  source         = "../"
  create_cluster = true
  app_port       = 80
  region         = "us-east-1"
  app_count      = 1
  fargate_cpu    = 256
  fargate_memory = 512
  subnet_ids     = ["subnet-06399d8a8ab548ac5", "subnet-0736facc920782b02"]
  vpc_id         = "vpc-0d5dbc81d1124c013"
  protocol       = "HTTP"
  family_name    = "mentoria"
  service_name   = "mentoria"
  cluster_name   = "mentoria"
  template_container = [{
    name      = "nginx"
    image     = "httpd"
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
        awslogs-group         = "mentoria-iac"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "nginx"

      }
    }
  }]
}

#output "load_balancer_dns_name" {
#  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
#}
