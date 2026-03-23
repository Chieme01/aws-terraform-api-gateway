# Under Construction - aws-terraform-api-gateway

# Notes
- You need to create a deployment for changes in the API Gateway to be in effect.
- Changes are deployed to stages.
- Lambda resource permissions are per methods.


# Steps for updates
1. Ensure functions source code exists in modules/python.
2. Ensure functions source code are named the same as function name.
3. Modify local.api_resources

 

# Potential improvements
To access Stage Variables ${stageVariables.variableName}.