resource "aws_iam_role" "iam_role" {
  name = "${var.environment}-${var.application}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "iam.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-iam-role",
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application
    },
    var.tags
  )
}

resource "aws_iam_policy" "iam_policy" {
  name = "${var.environment}-${var.application}-iam-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "Stmt1693214608532",
        Action   = "*",
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}


resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}