// wip - create functions for role definition & assignment resources

@export()
func newPolicyDefinitionName(guidValue string) string => 'pd-${substring(guid(guidValue), 0, 18)}'

@export()
func newPolicyAssignmentName(guidValue string) string => 'pa-${substring(guid(guidValue), 0, 18)}'

@export()
func newPolicyDefinition(policyDefinitionValue object) object => {
  name: 'pd-${substring(guid(policyDefinitionValue.displayName), 0, 18)}'
  properties: setPolicyDefinitionProperties(policyDefinitionValue)
}

func setPolicyDefinitionProperties(policyDefinitionValue object) policyDefinitionProperties => {
  displayName: policyDefinitionValue.displayName
  description: policyDefinitionValue.description
  mode: policyDefinitionValue.mode
  parameters: policyDefinitionValue.parameters
  policyRule: policyDefinitionValue.policyRule
  policyType: policyDefinitionValue.policyType
  metadata: any(policyDefinitionValue.metadata)
}

@export()
func newPolicyAssignment(policyDefinitionValue object, identityValue string, locationValue locationType) object => {
  name: 'pd-${substring(guid(policyDefinitionValue.displayName), 0, 18)}'
  properties: setPolicyAssignmentProperties(policyDefinitionValue, [])
  identity:{
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityValue}': {}
    }
  }
  location: locationValue
}

func setPolicyAssignmentProperties(policyDefinitionValue object, notScopesValue array?) policyAssignmentProperties => {
  displayName: policyDefinitionValue.displayName
  description: policyDefinitionValue.description
  parameters: policyDefinitionValue.parameters
  policyDefinitionId: policyDefinitionValue.policyDefinitionId
  notScopes: notScopesValue
}

type policyDefinitionProperties = resource<'Microsoft.Authorization/policyDefinitions@2023-04-01'>.properties

type policyAssignmentProperties = resource<'Microsoft.Authorization/policyAssignments@2024-04-01'>.properties

type policyAssignmentIdentity = 'None' | 'SystemAssigned' | 'UserAssigned'


var policyDefinitionVar = newPolicyDefinition(importLibraryPolicyDefinitions.allowedLocationsForResources)

var policyAssignmentVar = newPolicyAssignment(importLibraryPolicyDefinitions.allowedLocationsForResources, '', 'westeurope')

resource allowedLocationsForResourcesPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: policyDefinitionVar.name
  properties: policyDefinitionVar.properties
}

resource allowedLocationsForResourcesPolicyAssignment 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: policyAssignmentVar.name
  properties: policyAssignmentVar.properties
  identity: policyAssignmentVar.identity
  location: policyAssignmentVar.location
}
import { newPolicyDefinition as newPolicyDefinition } from '../lib/authorization/shared.bicep'
import { newPolicyAssignment as newPolicyAssignment } from '../lib/authorization/shared.bicep'
