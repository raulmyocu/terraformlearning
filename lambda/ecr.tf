resource "aws_ecr_repository" "lambda_ecr" {
  name = "${var.function_name}"

  # Push a dummy image
  provisioner "local-exec" {

    command     = <<EOF
docker login ${data.aws_ecr_authorization_token.token.proxy_endpoint} -u AWS -p ${data.aws_ecr_authorization_token.token.password}
docker pull ${data.docker_registry_image.dummy.name}
docker tag ${data.docker_registry_image.dummy.name} ${self.repository_url}:latest
docker push ${self.repository_url}:latest
EOF
  }

  depends_on = [
    data.aws_ecr_authorization_token.token,
    data.docker_registry_image.dummy
  ]
}

resource "aws_ecr_lifecycle_policy" "lambda_ecr_lifecycle" {
  repository = aws_ecr_repository.lambda_ecr.name

  policy = jsonencode({
    rules = [
      {
        "rulePriority" : 1,
        "description" : "Expire images older than 3 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

# For creating dummy image
data "aws_ecr_authorization_token" "token" {}

data "docker_registry_image" "dummy" {
  name = "hello-world:latest"
}
