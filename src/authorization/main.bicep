@description('Set user-assignmened managed identity id.')
param managedIdentity object

@description('Check if provided managed identity is null.')
var userAssigned = (managedIdentity.Id != null)

@description('Define required roles for managed identity.')
var requiredRoles = [
  'Contributor'
]

@description('Load library file containing role definitions.')
var roleDefinitionList = loadYamlContent('../../lib/authorization/library.yaml')

resource exampleRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for i in requiredRoles: if (userAssigned) {
    name: guid(i)
    properties: {
      principalId: managedIdentity.PrincipalId
      principalType: 'ServicePrincipal'
      roleDefinitionId: resourceId(
        roleDefinitionList['Resource Provider'],
        roleDefinitionList[i]
      )
    }
  }
]

resource examplePolicyAssignment 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: substring(guid('examplePolicyAssignment'), 0, 23)
  properties: {}
  identity: (managedIdentity.Id != null)
    ? {
        type: 'UserAssigned'
        userAssignedIdentities: {
          '${managedIdentity.Id}': {}
        }
      }
    : {
        type: 'SystemAssigned'
      }
  location: 'westeurope'
}
