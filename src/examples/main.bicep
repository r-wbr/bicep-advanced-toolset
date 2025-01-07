metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

@description('Import data types for name generator.')
import { 
  batResourceName 
} from '../../lib/batName/definitions.bicep'

@description('Import functions for name generator.')
import {
  newResourceName
  newUniqueResourceName
  newSpecialResourceName
  newPolicyDefinitionName
  newPolicyAssignmentName 
} from '../../lib/batName/shared.bicep'

param exampleNameDefault1 batResourceName = {
  name: 'default1'
  pattern: 'default1'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameDefault2 batResourceName = {
  name: 'default2'
  environment: 'Test'
  pattern: 'default2'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameExtended1 batResourceName = {
  name: 'extended1'
  organization: 'bat'
  pattern: 'extended1'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameExtended2 batResourceName = {
  name: 'extended2'
  environment: 'Test'
  organization: 'bat'
  pattern: 'extended2'
  prefix: 'Resource group'
  region: 'westeurope'
}

output exampleNames object = {
  default1: {
    generic: newResourceName(exampleNameDefault1)
    special: newSpecialResourceName(exampleNameDefault1)
    withSuffix: newResourceName(union(exampleNameDefault1, {
      suffix: '001'
      }))
  }
  default2: {
    generic: newResourceName(exampleNameDefault2)
    special: newSpecialResourceName(exampleNameDefault2)
  }
  extended1: {
    generic: newResourceName(exampleNameExtended1)
    special: newSpecialResourceName(exampleNameExtended1)
    withSuffix: newResourceName(union(exampleNameExtended1, {
      suffix: '001'
      }))
  }
  extended2: {
    generic: newResourceName(exampleNameExtended2)
    special: newSpecialResourceName(exampleNameExtended2)
  }
  policy1: {
    policyDefinition: newPolicyDefinitionName('example1')
    policyAssignment: newPolicyAssignmentName('example1')
  }
  policy2: {
    policyDefinition: newPolicyDefinitionName('example2')
    policyAssignment: newPolicyAssignmentName('example2')
  }
}

@description('Import helper functions.')
import {
  getResourceIdValues
} from '../../lib/batResources/helper.bicep'

@export()
func getSubscriptionId(resourceId string) string => getResourceIdValues(resourceId).subscriptionId

@export()
func getResourceGroupName(resourceId string) string => getResourceIdValues(resourceId).resourceGroupName

@export()
func getResourceName(resourceId string) string => getResourceIdValues(resourceId).resourceName

param exampleResourceId string = '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/exampleResourceGroup/providers/Microsoft.Compute/virtualMachines/exampleVirtualMachine'

output exampleResourceIds object = {
  subscriptionId: getSubscriptionId(exampleResourceId)
  resourceGroupName: getResourceGroupName(exampleResourceId)
  resourceName: getResourceName(exampleResourceId)
}
