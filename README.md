# Description
![Static Badge](https://img.shields.io/badge/Bicep-0.27.1-blue) ![Static Badge](https://img.shields.io/badge/Status-working-green)  

To conform to the 'Shared variable file pattern' development model, 'bicep-tools' provides a set of user defined functions, data types and library files threw a shared bicep file, which are used in main templates with the *import* function. These functions and data types are used to simplify the creation of resource names according to various schemes. It includes four different name patterns to generate resource names and patternless names for policy definitions and assignments. Each pattern consists of a generic and a special name, where in the special name hyphens are excluded.

The naming convention used for the name patterns is listed [here](./docs/resourceOrganization.md).

Examples for generated names from all patterns can be found [here](./docs/example.md).

# Usage
Input values for name generation in 'testResourceName' are defined with the type for resource names. The properties 'testResourceName.prefix', 'testResourceName.region' and 'testResourceName.environment' are generated with help of the library files.
- The value for 'testResourceName.prefix' uses the 'lib.resourceTypeAbbreviationList.resourceGroup' property, whereby 'lib.resourceTypeAbbreviationList.*resourceGroup*' needs user input to decide which resource type appeviation is used.
- The value for 'testResourceName.region' uses properties of deployment parameters, provided by the parameter file 'main.bicepparam'. Value is then compared with the values in the library files to choose the right abbreviation.
- The value for 'testResourceName.environmentAbbreviation' is derived from 'testResourceTags', but can also be set manual as string. Value is then compared with the values in the library files to choose the right abbreviation.
- If the value for 'testResourceName.suffix' is empty it will be excluded from the name.

Deployment parameters defined in 'main.bicepparam'.
```bicep
param deploymentParameters = {
  location: 'westeurope'
  creator: 'user@foo.bar'
  organization: 'FooBar Inc'
  customer: 'foo'
  namePattern: 'default1'
}
```

Resource tag and name parameters defined in 'main.bicep'.
```bicep
param testResourceTags lib.resourceTags = {
  applicationName: 'Bicep Tools'
  businessCriticality: 'Low'
  costCenter: '0000'
  creator: deploymentParameters.creator
  dataClassification: 'Public'
  deploymentDate: deploymentTimestamp
  environment: 'Development'
  owner: 'user@foo.bar'
}

param testResourceName lib.resourceName = {
  customer: deploymentParameters.customer
  prefix: lib.resourceTypeAbbreviationList.resourceGroup
  name: 'bctls'
  region: lib.regionAbbreviationList[deploymentParameters.location]
  environment: lib.environmentAbbreviationList[testResourceTags.environment]
  suffix: '001'
}
```

Generation of new resource name in 'main.bicep' based on provided values.
```bicep
resource testResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: lib.newResourceName(testResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
}
```

The name generated with the provided values in this section is :rg-testapp-euw-001'.
