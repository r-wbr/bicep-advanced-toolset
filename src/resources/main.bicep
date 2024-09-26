@description('Import archetypes from library.')
import { newResourceName, newUniqueResourceName, newSpecialResourceName, resourceName, resourceTags } from '../../lib/resource/shared.bicep'
import { setRoleAssignment, newPolicyDefinitionName, newPolicyAssignmentName } from '../../lib/authorization/shared.bicep'


param exampleResourceName resourceName = {
  organization: 'foo'
  name: 'example'
  prefix: 'Resource group'
  region: 'westeurope'
  environment: 'Test'
}

param exampleResourceNameWithSuffix resourceName = {
  organization: 'foo'
  name: 'example'
  prefix: 'Resource group'
  region: 'westeurope'
  environment: 'Test'
  suffix: '001'
}

output exampleNames object = {
  default1: {
    generic: newResourceName(exampleResourceName, 'default1')
    special: newSpecialResourceName(exampleResourceName, 'default1')
    withSuffix: newResourceName(exampleResourceNameWithSuffix, 'default1')
  }
  default2: {
    generic: newResourceName(exampleResourceName, 'default2')
    special: newSpecialResourceName(exampleResourceName, 'default2')
  }
  extended1: {
    generic: newResourceName(exampleResourceName, 'extended1')
    special: newSpecialResourceName(exampleResourceName, 'extended1')
    withSuffix: newResourceName(exampleResourceNameWithSuffix, 'extended1')
  }
  extended2: {
    generic: newResourceName(exampleResourceName, 'extended2')
    special: newSpecialResourceName(exampleResourceName, 'extended2')
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
