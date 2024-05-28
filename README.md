# Description
![Static Badge](https://img.shields.io/badge/Bicep-0.27.1-blue) ![Static Badge](https://img.shields.io/badge/Status-working-green)  

This repository provides a set of user defined functions, data types and library files threw shared bicep files, which are used in main templates with the *import* function. These functions and data types are used to simplify the creation of resource names according to various schemes. It includes four different name patterns to generate resource names and patternless names for policy definitions and assignments. Each pattern consists of a generic and a special name, where in the special name hyphens are excluded.

The naming convention used for the name patterns is listed [here](./docs/resourceOrganization.md).

Examples for generated names from all patterns can be found [here](./docs/example.md).

Included functions for import:
```bicep
@description('Creates a new role assignment with automatically generated name.')
newRoleAssignment()

@description('Creates a new resource name based on choosen name pattern.')
newResourceName()

@description('Creates a new resource name without hyphens based on choosen name pattern.')
newSpecialResourceName()
```

# Usage
Input values for name and tag generation in 'testResourceName' are defined with custom data types. The properties 'testResourceName.prefix', 'testResourceName.region', 'testResourceName.environment', 'testResourceTags.businessCriticality', 'testResourceTags.dataClassification', 'testResourceTags.environment' are defined as custom types.

Deployment parameters defined in 'main.bicepparam'. These parameters define the environment values for the whole deployment and are inherited to child modules.
```bicep
param deploymentParameters = {
  location: 'westeurope'
  creator: 'user@foo.bar'
  organization: 'FooBar Inc'
  customer: 'foo'
  namePattern: 'default1'
}
```

Resource tag and name parameters defined in 'main.bicep'. These parameters are volatile and define the resources that are deployed in a module, whereby the resource tags could be inherited to child modules.
```bicep
param testResourceTags setResourceTags = {
  applicationName: 'Test application'
  businessCriticality: 'Medium'
  costCenter: '0000'
  creator: deploymentParameters.creator
  dataClassification: 'Public'
  deploymentDate: deploymentTimestamp
  environment: 'Production'
  owner: 'testuser@foo.bar'
}

param testResourceName setResourceName = {
  customer: deploymentParameters.customer
  prefix: 'resourceGroup'
  name: 'testapp'
  region: 'westeurope'
  environment: 'Development'
  suffix: '001'
}
```

Generation of new resource name in 'main.bicep' based on provided values.
```bicep
resource testResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(testResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
  tags: testResourceTags
}
```

The name generated with the provided values in this section is: rg-testapp-euw-001'.
