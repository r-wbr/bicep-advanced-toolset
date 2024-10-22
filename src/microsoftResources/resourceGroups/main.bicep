metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

targetScope = 'subscription'

@description('Import data types for name generator.')
import { 
  inputResourceName 
} from '../../../lib/batName/definitions.bicep'

@description('Import functions for name generator.')
import {
  newResourceName
  newUniqueResourceName
  newSpecialResourceName
  newPolicyDefinitionName
  newPolicyAssignmentName 
} from '../../../lib/batName/shared.bicep'

@description('Import data types for tags.')
import {
  sharedParameters
  genericTagSet
} from '../../../lib/batTag/definitions.bicep'

@description('Define default parameters to import from parameters file.')
param deploymentParameters sharedParameters
param applicationName string

@description('Set values for module name object.')
param moduleResourceName inputResourceName = {
  name: substring(replace(replace(applicationName, '-',''), ' ',''),0,12)
  pattern: 'default1'
  prefix: 'Resource group'
  region: deploymentParameters.location
}

@description('Set values for module tag object.')
param moduleResourceTags genericTagSet = {
  ApplicationName: applicationName
  BusinessCriticality: 'Unsupported'
  CostCenter: '0000'
  Creator: deploymentParameters.creator
  DataClassification: 'Company' 
  DeploymentDate: utcNow('dd.MM.yyyy')
  Environment: 'Production'
  Owner: deploymentParameters.creator
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(moduleResourceName)
  location: deploymentParameters.location
  tags: moduleResourceTags
}

output moduleOutput object = {
  resourceGroupId: resourceGroup.id
  moduleResourceName: resourceGroup.name
}
