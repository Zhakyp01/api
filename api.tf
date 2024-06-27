variable "vpc_endpoint_ids" {
  type    = list(string)
  default = ["vpce-02a094bd495586628"]
}

resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "MPS.CipSupportServiceApi"
  description = "Terraform Serverless Application"
  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = var.vpc_endpoint_ids
  }
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "execute-api:Invoke",
      "Resource": "arn:aws:execute-api:us-west-2:*:*/MPS.CipSupportServiceApi",
      "Condition": {
        "StringNotEquals": {
          "aws:sourceVpce": "${var.vpc_endpoint_ids[0]}"
        }
      }
    }
  ]
}
EOF
}


resource "aws_api_gateway_resource" "CipSupportServiceApi" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "CipSupportServiceApi"
}

resource "aws_api_gateway_resource" "IndividualResults" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "IndividualResults"
}

resource "aws_api_gateway_resource" "IndividualResults_AddIndividualVerificationResults" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.IndividualResults.id
  path_part   = "AddIndividualVerificationResults"
}

resource "aws_api_gateway_resource" "individual_results_controller" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "IndividualResultsController"
}

resource "aws_api_gateway_resource" "individual_results_controller_v1" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.individual_results_controller.id
  path_part   = "V1"
}

resource "aws_api_gateway_resource" "add_individual_verification_results" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.individual_results_controller_v1.id
  path_part   = "AddIndividualVerificationResults"
}

resource "aws_api_gateway_resource" "Ping" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "Ping"
}

resource "aws_api_gateway_resource" "ping_controller" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "PingController"
}

resource "aws_api_gateway_resource" "ping_controller_v1" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.ping_controller.id
  path_part   = "V1"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "v1_IndividualResults" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "IndividualResults"
}

resource "aws_api_gateway_resource" "v1_IndividualResults_AddIndividualVerificationResults" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1_IndividualResults.id
  path_part   = "AddIndividualVerificationResults"
}

resource "aws_api_gateway_resource" "v1_Ping" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "Ping"
}

resource "aws_api_gateway_resource" "v1_VerifyBusiness" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "VerifyBusiness"
}

resource "aws_api_gateway_resource" "v1_VerifyBusiness_GetVerificationResult" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1_VerifyBusiness.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "v1_VerifyBusiness_Verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1_VerifyBusiness.id
  path_part   = "Verify"
}

resource "aws_api_gateway_resource" "v1_VerifyIndividual" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "VerifyIndividual"
}

resource "aws_api_gateway_resource" "v1_VerifyIndividual_GetVerificationResult" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1_VerifyIndividual.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "v1_VerifyIndividual_Verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.v1_VerifyIndividual.id
  path_part   = "Verify"
}

resource "aws_api_gateway_resource" "verify_business" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "VerifyBusiness"
}

resource "aws_api_gateway_resource" "VerifyBusiness_GetVerificationResult" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_business.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "VerifyBusiness_Verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_business.id
  path_part   = "Verify"
}

resource "aws_api_gateway_resource" "verify_business_v1" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_business.id
  path_part   = "V1"
}

resource "aws_api_gateway_resource" "get_verification_result" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_business_v1.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "verify_business_verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_business_v1.id
  path_part   = "Verify"
}

resource "aws_api_gateway_resource" "verify_individual" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.CipSupportServiceApi.id
  path_part   = "VerifyIndividual"
}

resource "aws_api_gateway_resource" "VerifyIndividual_GetVerificationResult" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_individual.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "VerifyIndividual_Verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_individual.id
  path_part   = "Verify"
}

resource "aws_api_gateway_resource" "verify_individual_v1" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_individual.id
  path_part   = "V1"
}

resource "aws_api_gateway_resource" "get_verification_result_individual" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_individual_v1.id
  path_part   = "GetVerificationResult"
}

resource "aws_api_gateway_resource" "verify_individual_verify" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.verify_individual_v1.id
  path_part   = "Verify"
}

resource "aws_api_gateway_method" "IndividualResults_AddIndividualVerificationResults_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.IndividualResults_AddIndividualVerificationResults.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "add_individual_verification_results" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.add_individual_verification_results.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.X-Enterprise-Id" = false
  }
}

resource "aws_api_gateway_method" "Ping_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.Ping.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ping_controller" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.ping_controller_v1.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.X-Enterprise-Id" = false
  }
}

resource "aws_api_gateway_method" "v1_IndividualResults_AddIndividualVerificationResults_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_IndividualResults_AddIndividualVerificationResults.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_Ping_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_Ping.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_VerifyBusiness_GetVerificationResult_GET" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_VerifyBusiness_GetVerificationResult.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_VerifyBusiness_Verify_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_VerifyBusiness_Verify.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_VerifyIndividual_GetVerificationResult_GET" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_VerifyIndividual_GetVerificationResult.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_VerifyIndividual_Verify_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.v1_VerifyIndividual_Verify.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "VerifyBusiness_GetVerificationResult_GET" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.VerifyBusiness_GetVerificationResult.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "VerifyBusiness_Verify_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.VerifyBusiness_Verify.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_verification_result" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.get_verification_result.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.X-Enterprise-Id"           = false
    "method.request.querystring.requestCorrelationId" = true
  }
}

resource "aws_api_gateway_method" "verify_business_verify" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.verify_business_verify.id
  http_method   = "POST"
  authorization = "NONE"
    request_parameters = {
    "method.request.header.X-Enterprise-Id"           = false
  }
}

resource "aws_api_gateway_method" "VerifyIndividual_GetVerificationResult_GET" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.VerifyIndividual_GetVerificationResult.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "VerifyIndividual_Verify_POST" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.VerifyIndividual_Verify.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_verification_result_individual" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.get_verification_result_individual.id
  http_method   = "GET"
  authorization = "NONE"
    request_parameters = {
    "method.request.header.X-Enterprise-Id"           = false
    "method.request.querystring.requestCorrelationId" = true
  }
}

resource "aws_api_gateway_method" "verify_individual_verify" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.verify_individual_verify.id
  http_method   = "POST"
  authorization = "NONE"
    request_parameters = {
    "method.request.header.X-Enterprise-Id"           = false
  }
}

# Integration for methods
resource "aws_api_gateway_integration" "IndividualResults_AddIndividualVerificationResults_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.IndividualResults_AddIndividualVerificationResults.id
  http_method             = aws_api_gateway_method.IndividualResults_AddIndividualVerificationResults_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_add_individual_verification_results" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.add_individual_verification_results.id
  http_method             = aws_api_gateway_method.add_individual_verification_results.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "Ping_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.Ping.id
  http_method             = aws_api_gateway_method.Ping_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_ping_controller" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.ping_controller_v1.id
  http_method             = aws_api_gateway_method.ping_controller.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_IndividualResults_AddIndividualVerificationResults_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_IndividualResults_AddIndividualVerificationResults.id
  http_method             = aws_api_gateway_method.v1_IndividualResults_AddIndividualVerificationResults_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_Ping_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_Ping.id
  http_method             = aws_api_gateway_method.v1_Ping_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_VerifyBusiness_GetVerificationResult_GET" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_VerifyBusiness_GetVerificationResult.id
  http_method             = aws_api_gateway_method.v1_VerifyBusiness_GetVerificationResult_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_VerifyBusiness_Verify_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_VerifyBusiness_Verify.id
  http_method             = aws_api_gateway_method.v1_VerifyBusiness_Verify_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_VerifyIndividual_GetVerificationResult_GET" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_VerifyIndividual_GetVerificationResult.id
  http_method             = aws_api_gateway_method.v1_VerifyIndividual_GetVerificationResult_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "v1_VerifyIndividual_Verify_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.v1_VerifyIndividual_Verify.id
  http_method             = aws_api_gateway_method.v1_VerifyIndividual_Verify_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "VerifyBusiness_GetVerificationResult_GET" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.VerifyBusiness_GetVerificationResult.id
  http_method             = aws_api_gateway_method.VerifyBusiness_GetVerificationResult_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "VerifyBusiness_Verify_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.VerifyBusiness_Verify.id
  http_method             = aws_api_gateway_method.VerifyBusiness_Verify_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_get_verification_result" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.get_verification_result.id
  http_method             = aws_api_gateway_method.get_verification_result.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_verify_business_verify" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.verify_business_verify.id
  http_method             = aws_api_gateway_method.verify_business_verify.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "VerifyIndividual_GetVerificationResult_GET" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.VerifyIndividual_GetVerificationResult.id
  http_method             = aws_api_gateway_method.VerifyIndividual_GetVerificationResult_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "VerifyIndividual_Verify_POST" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.VerifyIndividual_Verify.id
  http_method             = aws_api_gateway_method.VerifyIndividual_Verify_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_get_verification_result_individual" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.get_verification_result_individual.id
  http_method             = aws_api_gateway_method.get_verification_result_individual.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_verify_individual_verify" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.verify_individual_verify.id
  http_method             = aws_api_gateway_method.verify_individual_verify.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  depends_on = [
    aws_api_gateway_integration.IndividualResults_AddIndividualVerificationResults_POST,
    aws_api_gateway_integration.lambda_add_individual_verification_results,
    aws_api_gateway_integration.Ping_POST,
    aws_api_gateway_integration.lambda_ping_controller,
    aws_api_gateway_integration.v1_IndividualResults_AddIndividualVerificationResults_POST,
    aws_api_gateway_integration.v1_Ping_POST,
    aws_api_gateway_integration.v1_VerifyBusiness_GetVerificationResult_GET,
    aws_api_gateway_integration.v1_VerifyBusiness_Verify_POST,
    aws_api_gateway_integration.v1_VerifyIndividual_GetVerificationResult_GET,
    aws_api_gateway_integration.v1_VerifyIndividual_Verify_POST,
    aws_api_gateway_integration.VerifyBusiness_GetVerificationResult_GET,
    aws_api_gateway_integration.VerifyBusiness_Verify_POST,
    aws_api_gateway_integration.lambda_get_verification_result,
    aws_api_gateway_integration.lambda_verify_business_verify,
    aws_api_gateway_integration.VerifyIndividual_GetVerificationResult_GET,
    aws_api_gateway_integration.VerifyIndividual_Verify_POST,
    aws_api_gateway_integration.lambda_get_verification_result_individual,
    aws_api_gateway_integration.lambda_verify_individual_verify
  ]
  lifecycle {
    create_before_destroy = true
  }
   triggers = {
     redeployment = sha1(jsondecode(
       aws_api_gateway_rest_api.rest_api
     ))
   }
}


resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = var.stage_name
  tags = var.tags
  depends_on = [ aws_api_gateway_deployment.deployment ]
}

 resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.example.function_name
   principal     = "apigateway.amazonaws.com"
   source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*"
 }

