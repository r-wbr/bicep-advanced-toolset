metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

targetScope = 'subscription'

// Shared bicep should be imported as 'lib' namespace.
import * as lib from 'shared.bicep'

// Initiate import for main and child modules
@description('Define parameters to import from deployment.')
param deploymentTimestamp string = utcNow('dd.MM.yyyy')
param deploymentParameter lib.import

// Define object for resource deployment in main module
@description('Input for resource tags.')
param testResourceTags lib.resourceTag = {
  applicationName: 'Test application'
  businessCriticality: 'Low'
  costCenter: '0000'
  creator: deploymentParameter.creator
  dataClassification: 'Highly confidential'
  deploymentDate: deploymentTimestamp
  environment: 'Development'
  owner: 'testuser@foo.bar'
}

@description('Input for resource name.')
param testResourceName lib.resourceName = {
  customerAbbreviation: deploymentParameter.customerAbbreviation
  nameAbbreviation: 'testapp'
  resourceType: lib.resourceTypeAbbreviationList.resourceGroup
  locationAbbreviation: lib.regionAbbreviationList[deploymentParameter.location]
  environmentAbbreviation: lib.environmentAbbreviationList[testResourceTags.environment]
  sequenceNumber: '001'
}

output names object = {
  default1: {
    generic: lib.newResourceName(testResourceName, 'default1')
    special: lib.newSpecialResourceName(testResourceName, 'default1')
  }
  default2: {
    generic: lib.newResourceName(testResourceName, 'default2')
    special: lib.newSpecialResourceName(testResourceName, 'default2')
  }
  extended1: {
    generic: lib.newResourceName(testResourceName, 'extended1')
    special: lib.newSpecialResourceName(testResourceName, 'extended1')
  }
  extended2: {
    generic: lib.newResourceName(testResourceName, 'extended2')
    special: lib.newSpecialResourceName(testResourceName, 'extended2')
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
