locals {
# Start here for changes to lambda, API GW resources, methods and integration.
    api_resources_map = {
    root_resource = {
      functions = {
        function_d = {
          function_name   = "function_d"
          end_point_name  = "root_get_d"
          method          = "GET"
        }
      }
      path            = "delta" 
    }
    resource_one = {
    # One method type per resource. For example, an API-GW resource cannot have two GET.
      functions = {
        function_a = {
          function_name   = "function_a"
          end_point_name  = "get_a"
          method          = "GET"
        },
        function_b = {
          function_name   = "function_b"
          end_point_name  = "post_b"
          method          = "POST"
        }
      }
      path            = "alpha"

    },
    
    resource_two = {
      functions = {
        function_d = {
          function_name   = "function_d"
          end_point_name  = "get_d"
          method          = "GET"
        }
      }
      path            = "delta" 
    }
  }
  
  api_resources ={
    # Exclude the root resource because it already exists by default, although it requires methods, lambda and integration.
    for res, res_val in local.api_resources_map: res => res_val
    if res != "root_resource"
  }

  functions = merge([
    for resource_key, resource_val in local.api_resources_map : {
      for func_key, func_val in resource_val.functions :
      # Add api resource and path attribute to the functions. The path is needed by aws_lambda_permission.
      func_key => merge({"path"=resource_val.path}, {"resource"=resource_key}, func_val)
    }
  ]...)

  methods = merge([
    for resource_key, resource_val in local.api_resources_map : {
      for func_key, func_val in resource_val.functions :
      # Add api resource attribute to the method.
      func_val.end_point_name => merge({"resource"=resource_key}, func_val)
    }
  ]...)

}