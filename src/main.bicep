metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

targetScope = 'subscription'

@description('Import library for resource archetypes.')
import { newResourceName as newResourceName } from '../lib/resources/shared.bicep'
import { newUniqueResourceName as newUniqueResourceName } from '../lib/resources/shared.bicep'
import { newSpecialResourceName as newSpecialResourceName } from '../lib/resources/shared.bicep'
import { resourceName as setResourceName } from '../lib/resources/shared.bicep'
import { resourceTags as setResourceTags } from '../lib/resources/shared.bicep'

@description('Import library for deployment archetypes.')
import { deploymentParameters as deploymentParameterType } from '../lib/deployment/shared.bicep'

@description('Import library for authorization archetypes.')
import { newRoleAssignment as newRoleAssignment } from '../lib/authorization/shared.bicep'

param deploymentParameters deploymentParameterType

param testResourceTags setResourceTags = {
  applicationName: 'Test application'
  businessCriticality: 'Medium'
  costCenter: '0000'
  creator: deploymentParameters.creator
  dataClassification: 'Public'
  deploymentDate: utcNow('dd.MM.yyyy')
  environment: 'Production'
  owner: 'testuser@foo.bar'
}

param testResourceName setResourceName = {
  customer: deploymentParameters.customer
  prefix: 'Resource group'
  name: 'testapp'
  region: 'westeurope'
  environment: 'Development'
  suffix: '001'
}

resource testResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(testResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
  tags: testResourceTags
}

output resourceName string = testResourceGroup.name

var roleAssignmentVar = newRoleAssignment('ServicePrincipal', 'Advisor Reviews Reader', 'b95e50e1-02c9-4382-a538-9a120f87bbf7')

resource contributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentVar.name
  properties: roleAssignmentVar.properties
}
