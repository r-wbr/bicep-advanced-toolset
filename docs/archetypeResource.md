# Resource

The archetype **resource** includes four different naming patterns for defining resource names, as well as the associated data types. Each pattern consists of functions to generate a generic, special or unique name, where in the special and unique name hyphens are excluded. The abbreviations for resource types are stored in the library file.

1. From the target template, import the archetypes.

> [!NOTE]
> The preferred name pattern can be set directly in the function `newResourceName(moduleResourceName, 'default1')`, or referred from the deployment parameters `newResourceName(moduleResourceName, 'deploymentParameters.namePattern')`.

```bicep
@description('Import library for resource archetypes.')
import { newResourceName, newUniqueResourceName, newSpecialResourceName, resourceName, resourceTags } from '../lib/resource/shared.bicep'
```

2. Use the user-defined data types for resource tags and resource names to define the input. By referring to user-defined data types in the corresponding objects, predefined values can be selected.

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
```

3. Provide the input to the functions directly in the resource object.

```bicep
@description('The function creates a default name, based on the input objects.')
resource resourceGroupDefaultName 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(moduleResourceName, 'default1')
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
resource resourceGroupUniqueName 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newUniqueResourceName('Resource group', 'testApplication')
  location: deploymentParameters.location
  tags: moduleResourceTags
}

output resourceDefaultName string = resourceGroupDefaultName.name

output resourceSpecialName string = resourceGroupSpecialName.name

output resourceUniqueName string = resourceGroupUniqueName.name

/* 
output resourceDefaultName = rg-testapp-euw
output resourceSpecialName = rgtestappeuw
output resourceUniqueName = rgmq7o6l5h33fmy
*/
```