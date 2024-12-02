# FILE: api_gateway/api_gateway.tf

resource "aws_api_gateway_rest_api" "auth_api" {
  name = "AuthAPI"
}

# Define resources
resource "aws_api_gateway_resource" "customer" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_rest_api.auth_api.root_resource_id
  path_part   = "customer"
}

resource "aws_api_gateway_resource" "customer_cpf" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.customer.id
  path_part   = "{cpf}"
}

resource "aws_api_gateway_resource" "product" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_rest_api.auth_api.root_resource_id
  path_part   = "product"
}

resource "aws_api_gateway_resource" "product_id" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.product.id
  path_part   = "{id}"
}

resource "aws_api_gateway_resource" "product_category" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.product.id
  path_part   = "{category}"
}

resource "aws_api_gateway_resource" "order" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_rest_api.auth_api.root_resource_id
  path_part   = "order"
}

resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.order.id
  path_part   = "orders"
}

resource "aws_api_gateway_resource" "order_id" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.order.id
  path_part   = "{orderId}"
}

resource "aws_api_gateway_resource" "order_status_payment" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.order_id.id
  path_part   = "status/payment"
}

resource "aws_api_gateway_resource" "order_status" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_resource.order_id.id
  path_part   = "status"
}

resource "aws_api_gateway_resource" "webhook_order_payment_status" {
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  parent_id   = aws_api_gateway_rest_api.auth_api.root_resource_id
  path_part   = "webhook/order/payment/status"
}

# Define authorizer
resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name            = "CognitoAuthorizer"
  rest_api_id     = aws_api_gateway_rest_api.auth_api.id
  identity_source = "method.request.header.Authorization"
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [var.aws_cognito_user_pool.arn]
}

# Define methods and integrations
resource "aws_api_gateway_method" "customer_get" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.customer.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "customer_cpf_get" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.customer_cpf.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "product_post" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "product_put" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.product_id.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "product_delete" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.product_id.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "product_category_get" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.product_category.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "order_post" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.order.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "orders_get" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "order_status_payment_get" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.order_status_payment.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "order_status_post" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.order_status.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "webhook_order_payment_status_post" {
  rest_api_id   = aws_api_gateway_rest_api.auth_api.id
  resource_id   = aws_api_gateway_resource.webhook_order_payment_status.id
  http_method   = "POST"
  authorization = "NONE"
}

# Define integrations
resource "aws_api_gateway_integration" "customer_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.customer.id
  http_method             = aws_api_gateway_method.customer_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://your-kubernetes-service/customer"
}

resource "aws_api_gateway_integration" "customer_cpf_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.customer_cpf.id
  http_method             = aws_api_gateway_method.customer_cpf_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://your-kubernetes-service/customer/{cpf}"
}

resource "aws_api_gateway_integration" "product_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.product.id
  http_method             = aws_api_gateway_method.product_post.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://your-kubernetes-service/product"
}

resource "aws_api_gateway_integration" "product_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.product_id.id
  http_method             = aws_api_gateway_method.product_put.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "PUT"
  uri                     = "http://your-kubernetes-service/product/{id}"
}

resource "aws_api_gateway_integration" "product_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.product_id.id
  http_method             = aws_api_gateway_method.product_delete.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "DELETE"
  uri                     = "http://your-kubernetes-service/product/{id}"
}

resource "aws_api_gateway_integration" "product_category_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.product_category.id
  http_method             = aws_api_gateway_method.product_category_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://your-kubernetes-service/product/{category}"
}

resource "aws_api_gateway_integration" "order_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.order.id
  http_method             = aws_api_gateway_method.order_post.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://your-kubernetes-service/order"
}

resource "aws_api_gateway_integration" "orders_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.orders.id
  http_method             = aws_api_gateway_method.orders_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://your-kubernetes-service/orders"
}

resource "aws_api_gateway_integration" "order_status_payment_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.order_status_payment.id
  http_method             = aws_api_gateway_method.order_status_payment_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://your-kubernetes-service/order/{orderId}/status/payment"
}

resource "aws_api_gateway_integration" "order_status_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.order_status.id
  http_method             = aws_api_gateway_method.order_status_post.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://your-kubernetes-service/order/{orderId}/status"
}

resource "aws_api_gateway_integration" "webhook_order_payment_status_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.auth_api.id
  resource_id             = aws_api_gateway_resource.webhook_order_payment_status.id
  http_method             = aws_api_gateway_method.webhook_order_payment_status_post.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://your-kubernetes-service/webhook/order/payment/status"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.auth_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.auth_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "auth_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.customer_get_integration,
    aws_api_gateway_integration.customer_cpf_get_integration,
    aws_api_gateway_integration.product_post_integration,
    aws_api_gateway_integration.product_put_integration,
    aws_api_gateway_integration.product_delete_integration,
    aws_api_gateway_integration.product_category_get_integration,
    aws_api_gateway_integration.order_post_integration,
    aws_api_gateway_integration.orders_get_integration,
    aws_api_gateway_integration.order_status_payment_get_integration,
    aws_api_gateway_integration.order_status_post_integration,
    aws_api_gateway_integration.webhook_order_payment_status_post_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.auth_api.id
  stage_name  = "prod"
}
