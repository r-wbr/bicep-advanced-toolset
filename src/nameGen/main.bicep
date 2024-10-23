metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

@description('Import data types for name generator.')
import { 
  inputResourceName 
} from '../../lib/batName/definitions.bicep'

@description('Import functions for name generator.')
import {
  newResourceName
  newUniqueResourceName
  newSpecialResourceName
  newPolicyDefinitionName
  newPolicyAssignmentName 
} from '../../lib/batName/shared.bicep'

param exampleNameDefault1 inputResourceName = {
  name: 'default1'
  pattern: 'default1'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameDefault2 inputResourceName = {
  name: 'default2'
  environment: 'Test'
  pattern: 'default2'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameExtended1 inputResourceName = {
  name: 'extended1'
  organization: 'bat'
  pattern: 'extended1'
  prefix: 'Resource group'
  region: 'westeurope'
}

param exampleNameExtended2 inputResourceName = {
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
