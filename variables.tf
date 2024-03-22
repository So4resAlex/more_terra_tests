variable "queue_name" {
  description = "The name from queue to be created"
  type = string
}

variable "policy_sqs_name" {
  description = "The name from policy queue"
  type = string
}
variable "user_arn" {
  description = "User ARN for binding"
  type = string
}

variable "enviroment" {
    description = "Enviroment"
    type = string
}
