resource "aws_sqs_queue" "terraform_queue" {
  name                       = var.queue_name
  delay_seconds              = 20
  visibility_timeout_seconds = 60
  receive_wait_time_seconds  = 20
  message_retention_seconds  = 1209600
  max_message_size           = 2048
  tags = {
    Name = var.queue_name
    Enviroment = var.enviroment
    Manager = "Terraform"
  }
}

resource "aws_sqs_queue_policy" "terraform_queue_policy" {
  queue_url = aws_sqs_queue.terraform_queue.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = var.policy_sqs_name
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.user_arn
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.terraform_queue.arn
      },
    ]
  })
}
