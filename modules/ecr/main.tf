data "aws_ecr_repository" "this" {
  name = var.repository_name
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = var.enable_lifecycle_policy ? 1 : 0
  repository = data.aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images beyond the most recent ${var.lifecycle_max_image_count}"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.lifecycle_max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

