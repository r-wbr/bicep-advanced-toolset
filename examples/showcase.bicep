metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

targetScope = 'subscription'

// Shared bicep should be imported as 'lib' namespace.

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
import { newPolicyDefinitionName as newPolicyDefinitionName } from '../lib/authorization/shared.bicep'
import { newPolicyAssignmentName as newPolicyAssignmentName } from '../lib/authorization/shared.bicep'

// Initiate import for main and child modules
@description('Define parameters to import from deployment.')
param deploymentTimestamp string = utcNow('dd.MM.yyyy')
param deploymentParameters deploymentParameterType

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
  prefix: 'Resource group'
  name: 'testapp'
  region: 'West Europe'
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
    policyDefinition: newPolicyDefinitionName('AzurePolicyDisplayName1')
    policyAssignment: newPolicyAssignmentName('AzurePolicyDisplayName1')
  }
  policy2: {
    policyDefinition: newPolicyDefinitionName('AzurePolicyDisplayName2')
    policyAssignment: newPolicyAssignmentName('AzurePolicyDisplayName2')
  }
}

