# Bicep Advanced Toolset (BAT)
![Static Badge](https://img.shields.io/badge/Version-2.0.2-green) ![Static Badge](https://img.shields.io/badge/Bicep-0.29.47-blue)

![logo](/img/logo256.png)

The **Bicep Advanced Toolset (BAT)** provides a solution to simplify the creation and configuration of resources before a single template is written. The toolset consist of user defined functions, data types and library files, separated into archetypes. This helps implementing a consistent naming and tagging convention which can be fully integrated in every template.

> [!CAUTION]
> For the toolset to function, experimental features must be activated in the bicep config file!

# Features

- Name Generator: The name generator enables the creation of consistent resource names, for all occasions.
- Name Patterns: Four different pre-defined name patterns are included:
  - Default 1: Prefix-Name-Region-Suffix
  - Default 2: Prefix-Name-Region-Environment-Suffix
  - Extended 1: Prefix-Name-Region-Suffix
  - Extended 2: Prefix-Name-Region-Environment-Suffix
- Library Files: Centralized and shared storage of information and values.

## Archetypes

### Resources

The archetype **resources** include four different naming patterns for defining resource names, as well as the associated data types. Each pattern consists of functions to generate a generic, special or unique name, where in the special and unique name hyphens are excluded. The abbreviations for resource types are stored in the library file.

```bicep
@description('These object defines the values for the resource tags.')
param moduleResourceTags setResourceTags = {
  ApplicationName: 'Test application'
  BusinessCriticality: 'Medium'
  CostCenter: '0000'
  Creator: deploymentParameters.creator
  DataClassification: 'Public'
  DeploymentDate: utcNow('dd.MM.yyyy')
  Environment: 'Production'
  Owner: 'testuser@foo.bar'
}

@description('These object defines the values for the resource name.')
param moduleResourceName setResourceName = {
  organization: deploymentParameters.organization
  prefix: 'Resource group'
  name: 'testapp'
  region: 'westeurope'
  environment: 'Development'
  suffix: '001'
}

@description('The function creates a default name, based on the input objects.')
resource resourceGroupDefaultName 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(moduleResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
  tags: moduleResourceTags
}

@description('The function creates a special name, based on the input objects.')
resource resourceGroupSpecialName 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newSpecialResourceName(moduleResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
  tags: moduleResourceTags
}

@description('The function creates a unique name, without input objects. Resource type and name are set directly.')
resource resourceGroupUniquelName 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newUniqueResourceName('Resource group', 'testApplication')
  location: deploymentParameters.location
  tags: moduleResourceTags
}

output resourceDefaultName string = resourceGroupDefaultName.name

output resourceSpecialName string = resourceGroupSpecialName.name

output resourceUniqueName string = resourceGroupUniquelName.name

/* 
output resourceDefaultName = rg-testapp-euw
output resourceSpecialName = rgtestappeuw
output resourceUniqueName = rgmq7o6l5h33fmy
*/
```

### Locations

The archetype **locations** provides data types for consistent selection of Azure regions and a function to generate abbreviations, based on pre-defined values in the library file.

```bicep
@description('The function provides an abbreviation for regions available in the data type.')
output regionAbbreviation string = getRegionAbbreviation('westeurope')

/* 
output regionAbbreviation = euw

*/
```

### Deployment

The archetype **deployment** contains data types for a centralized object, containing all neede values for the deployment. The object can be inherited by child modules.

```bicep
@description('These object defines the environment values for the whole deployment.')
param deploymentParameters = {
  location: 'westeurope'
  creator: ''
  organizationAbbreviation: 'foo'
  organization: 'FooBar Inc'
  namePattern: 'default1'
}
```

### Authorization

The archetype **authorization** provides data types and a library file for role definitions


```bicep
@description('Defines the name and properties of the role assignment.')
var roleAssignmentValues = setRoleAssignment('User', 'Contributor', '62ec7157-226f-44fd-a324-d5e250007618')

@description('Creates the role assignment based on the value object.')
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentValues.name
  properties: roleAssignmentValues.properties
}

@description('Creates a new guid for policy definitions based on string input.')
output policyDefinitionName string = newPolicyDefinitionName('This is a random string.')

@description('Creates a new guid for policy assignments based on string input.')
output policyAssignmentName string = newPolicyAssignmentName('This is a random string.')

/* 
output policyDefinitionName = pd-1391f145-c112-58b3
output policyAssignmentName = pa-1391f145-c112-58b3
*/
```