variable "cria_cluster" {
  type        = bool
  default     = true
  description = "Define se cluster será criado"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "container_insights" {
  type        = bool
  default     = true
  description = "Usado para habilitar CloudWatch Container Insights para o cluster"
}

variable "delete_protection" {
  type        = bool
  default     = false
  description = "Impede que terraform exclua o load balance"
}

variable "region" {
  type        = string
  description = "Região AWS"
}

variable "service_name" {
  type        = string
  description = "Nome do service cluster"
}

variable "app_count" {
  type        = number
  description = "Números de tarefas em execução task definition"
}

variable "family_name" {
  type        = string
  description = "Nome para task definition"
}

variable "fargate_cpu" {
  type        = number
  description = "Número de CPUs usados na taskde finition"
}

variable "fargate_memory" {
  type        = number
  description = "Quantidade de memória usada pela task definition"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Id da subnet"
}

variable "security_groups" {
  type        = list(string)
  description = "Id do security group"
}

variable "vpc_id" {
  type        = string
  description = "Id da vpc"
}

variable "app_port" {
  type        = number
  description = "Porta que será utilizada pela aplicação"
}

variable "protocol" {
  type        = string
  description = "Protocolo que será utilizado na aplicação <http, https, tcp>"
}

variable "policy_ssl" {
  type        = string
  description = "Nome da política SSL. Obrigatório se o protocolo for HTTPS ou TLS"
}

variable "certificate_arn" {
  type        = string
  description = "ARN do certificado de servidor SSL padrão"
}

variable "template_container" {
  type = list(object(
    {
      name      = string
      image     = string
      cpu       = number
      memory    = number
      essential = bool
      portMappings = list(object({
        containerPort = number
        hostPort      = number
      }))

      logConfiguration = object({
        logDriver = string
        options = object({
          awslogs-group         = string
          awslogs-region        = string
          awslogs-stream-prefix = string

        })

      })


  }))
  default = [{
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
        awslogs-region        = "us-east-2"
        awslogs-stream-prefix = "nginx"

      }
    }
  }]
  description = "Um arquivo json que contém as definições do container"
}

