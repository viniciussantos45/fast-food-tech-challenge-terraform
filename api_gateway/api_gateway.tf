resource "aws_api_gateway_rest_api" "fast_food_api" {
  name        = "FastFoodAPI"
  description = "API Gateway for Fast Food Microservices"
}

resource "aws_api_gateway_resource" "order" {
  rest_api_id = aws_api_gateway_rest_api.fast_food_api.id
  parent_id   = aws_api_gateway_rest_api.fast_food_api.root_resource_id
  path_part   = "order"
}

resource "aws_api_gateway_resource" "preparation" {
  rest_api_id = aws_api_gateway_rest_api.fast_food_api.id
  parent_id   = aws_api_gateway_rest_api.fast_food_api.root_resource_id
  path_part   = "preparation"
}

resource "aws_api_gateway_resource" "payment" {
  rest_api_id = aws_api_gateway_rest_api.fast_food_api.id
  parent_id   = aws_api_gateway_rest_api.fast_food_api.root_resource_id
  path_part   = "payment"
}

resource "aws_api_gateway_method" "order_method" {
  rest_api_id   = aws_api_gateway_rest_api.fast_food_api.id
  resource_id   = aws_api_gateway_resource.order.id
  http_method   = "POST" # Use "POST" para corresponder à integração
  authorization = "NONE"
}

resource "aws_api_gateway_method" "preparation_method" {
  rest_api_id   = aws_api_gateway_rest_api.fast_food_api.id
  resource_id   = aws_api_gateway_resource.preparation.id
  http_method   = "POST" # Use "POST" para corresponder à integração
  authorization = "NONE"
}

resource "aws_api_gateway_method" "payment_method" {
  rest_api_id   = aws_api_gateway_rest_api.fast_food_api.id
  resource_id   = aws_api_gateway_resource.payment.id
  http_method   = "POST" # Use "POST" para corresponder à integração
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "order_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fast_food_api.id
  resource_id             = aws_api_gateway_resource.order.id
  http_method             = aws_api_gateway_method.order_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://${var.cluster_endpoint}/fast-food-order"
}

resource "aws_api_gateway_integration" "preparation_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fast_food_api.id
  resource_id             = aws_api_gateway_resource.preparation.id
  http_method             = aws_api_gateway_method.preparation_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://${var.cluster_endpoint}/fast-food-preparation"
}

resource "aws_api_gateway_integration" "payment_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fast_food_api.id
  resource_id             = aws_api_gateway_resource.payment.id
  http_method             = aws_api_gateway_method.payment_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://${var.cluster_endpoint}/fast-food-payment"
}

resource "aws_api_gateway_deployment" "fast_food_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.fast_food_api.id
  stage_name  = "prod"

  depends_on = [
    aws_api_gateway_integration.order_integration,
    aws_api_gateway_integration.preparation_integration,
    aws_api_gateway_integration.payment_integration
  ]
}

output "api_gateway_url" {
  value = aws_api_gateway_rest_api.fast_food_api.execution_arn
}
