metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

targetScope = 'subscription'

// Shared bicep should be imported as 'lib' namespace.
import * as lib from '../src/shared.bicep'
import { newResourceName as newResourceName } from '../src/shared.bicep'
import { newSpecialResourceName as newSpecialResourceName } from '../src/shared.bicep'
import { resourceName as setResourceName } from '../src/shared.bicep'
import { resourceTags as setResourceTags } from '../src/shared.bicep'

// Initiate import for main and child modules
@description('Define parameters to import from deployment.')
param deploymentTimestamp string = utcNow('dd.MM.yyyy')
param deploymentParameters lib.deploymentParameters

// Define object for resource deployment in main module
@description('Input for resource tags.')
param testResourceTags setResourceTags = {
  applicationName: 'Test application'
  businessCriticality: 'Low'
  costCenter: '0000'
  creator: deploymentParameters.creator
  dataClassification: 'Highly confidential'
  deploymentDate: deploymentTimestamp
  environment: 'Development'
  owner: 'testuser@foo.bar'
}

@description('Input for resource name.')
param testResourceName setResourceName = {
  customer: deploymentParameters.customer
  prefix: 'resourceGroup'
  name: 'testapp'
  region: 'westeurope'
  environment: 'Development'
  suffix: '001'
}

output names object = {
  default1: {
    generic: newResourceName(testResourceName, 'default1')
    special: newSpecialResourceName(testResourceName, 'default1')
  }
  default2: {
    generic: newResourceName(testResourceName, 'default2')
    special: newSpecialResourceName(testResourceName, 'default2')
  }
  extended1: {
    generic: newResourceName(testResourceName, 'extended1')
    special: newSpecialResourceName(testResourceName, 'extended1')
  }
  extended2: {
    generic: newResourceName(testResourceName, 'extended2')
    special: newSpecialResourceName(testResourceName, 'extended2')
  }
  policy1: {
    policyDefinition: lib.newPolicyDefinitionName('AzurePolicyDisplayName1')
    policyAssignment: lib.newPolicyAssignmentName('AzurePolicyDisplayName1')
  }
  policy2: {
    policyDefinition: lib.newPolicyDefinitionName('AzurePolicyDisplayName2')
    policyAssignment: lib.newPolicyAssignmentName('AzurePolicyDisplayName2')
  }
}

