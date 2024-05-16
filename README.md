# Description
![Static Badge](https://img.shields.io/badge/Language-Bicep-blue) ![Static Badge](https://img.shields.io/badge/Status-working-green)  ![Static Badge](https://img.shields.io/badge/Scope-subscription-peru) 

The bicep name generator provides four different name patterns to generate resource names. Each pattern consists of a generic and a special name, where in the special name hyphens are excluded. 

Each module in which the functions are to be used, must first import them from the 'shared.bicep' file.
```bicep
import * as lib from 'shared.bicep'
```
In 'shared.bicep' the library files are imported as variables and need to be used in the modules for name generation.
```bicep
@export()
var resourceTypeAbbreviationList = loadYamlContent('../lib/resourceTypeAbbreviations.yaml')
@export()
var regionAbbreviationList = loadYamlContent('../lib/regionAbbreviations.yaml')
@export()
var environmentAbbreviationList = loadYamlContent('../lib/environmentAbbreviations.yaml')
```
The custom type 'resourceName' defines the values which are needed for name generation of a resource. If the property 'sequenceNumber' is not *null*, the value will be used for name generation.
```bicep
@export()
type resourceName = {
  customerAbbreviation: string?
  resourceType: string
  nameAbbreviation: string
  locationAbbreviation: string
  environmentAbbreviation: string?
  sequenceNumber: string?
}
```
# Example
Input values for name generation in 'testResourceName' are defined with the type for resource names. The properties 'testResourceName.resourceType', 'testResourceName.locationAbbreviation' and 'testResourceName.environmentAbbreviation' are accessing the library files threw shared varibles. 
- The value for 'testResourceName.resourceType' uses the 'lib.resourceTypeAbbreviationList.resourceGroup' property, whereby 'lib.resourceTypeAbbreviationList.*resourceGroup*' needs user input to decide which resource type appeviation is used.
- The value for 'testResourceName.locationAbbreviation' uses properties of environmental parameters, provided by the parameter file 'main.bicepparam'. Value is then compared with the values in the library files to choose the right abbreviation.
- The value for 'testResourceName.environmentAbbreviation' is derived from 'testResourceTags', but can also be set manual as string. Value is then compared with the values in the library files to choose the right abbreviation.
```bicep
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
```
***
Output generation in 'main.bicep'.
```bicep
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
```
***
Output values after deployment.
```json
{
    "default1": {
        "generic": "rg-testapp-euw-001",
        "special": "rg-testapp-euw-001"
    },
    "default2": {
        "generic": "rg-testapp-euw-dev-001",
        "special": "rgtestappeuwdev001"
    },
    "extended1": {
        "generic": "gate-rg-testapp-euw-001",
        "special": "gatergtestappeuw001"
    },
    "extended2": {
        "generic": "gate-rg-testapp-euw-dev-001",
        "special": "gatergtestappeuwdev001"
    },
    "policy1": {
        "policyDefinition": "pd-7238a963-b977-535c",
        "policyAssignment": "pa-7238a963-b977-535c"
    },
    "policy2": {
        "policyDefinition": "pd-dd30698c-56cf-54a2",
        "policyAssignment": "pa-dd30698c-56cf-54a2"
    }
}
```
***