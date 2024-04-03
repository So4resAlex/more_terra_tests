resource "aws_sqs_queue" "terraform_queue" {
  name                       = var.queue_name
  delay_seconds              = 20
  visibility_timeout_seconds = 60
  receive_wait_time_seconds  = 20
  message_retention_seconds  = 1209600
  max_message_size           = 2048
  tags = {
    Eviroment = "Test"
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
          AWS = var.receiver_user_arn #TODO Receive user arn
        }
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.terraform_queue.arn
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = var.sender_user_arn #TODO Sender user arn
        }
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.terraform_queue.arn
      }
    ]
  })
}