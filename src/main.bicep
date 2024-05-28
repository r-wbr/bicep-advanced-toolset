metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

targetScope = 'subscription'

@description('Import library for resource archetypes.')
import { newResourceName as newResourceName } from '../lib/resources/shared.bicep'
import { newSpecialResourceName as newSpecialResourceName } from '../lib/resources/shared.bicep'
import { resourceName as setResourceName } from '../lib/resources/shared.bicep'
import { resourceTags as setResourceTags } from '../lib/resources/shared.bicep'

@description('Import library for deployment archetypes.')
import { deploymentParameters as deploymentParameterType } from '../lib/deployment/shared.bicep'

@description('Import library for authorization archetypes.')
import { newRoleAssignment as newRoleAssignment} from '../lib/authorization/shared.bicep'
import { newPolicyDefinitionName as newPolicyDefinitionName } from '../lib/authorization/shared.bicep'
import { newPolicyAssignmentName as newPolicyAssignmentName } from '../lib/authorization/shared.bicep'

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
  prefix: 'resourceGroup'
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

var groupPrincipalId = '98dfj29-d230j-d2d3f2'

output roleAssignment object = newRoleAssignment('Group', 'contributor', groupPrincipalId)
