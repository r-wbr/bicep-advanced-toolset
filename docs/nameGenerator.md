# Name Generator

The name generator includes four different naming patterns for defining resource names from a object, as well as the associated input objects. Each pattern consists of functions to generate a generic, special or unique name, where in the special and unique name hyphens are excluded. The abbreviations for resource types, regions and environments are stored in library files.

# Usage

Functions to generate a default or special name need a specific `batResourceName` object, which defines the available values for the specific name pattern.

```bicep
@description('Calls the helper function to generate a new default resource name based on input.')
@export()
func newResourceName(input batResourceName) string => setResourceName(input)[(string(input.pattern))]

@description('Calls the helper function to generate a new special resource name based on input.')
@export()
func newSpecialResourceName(input batResourceName) string => setSpecialResourceName(input)[(string(input.pattern))]
```

Functions to generate a unique name, or names for policy definitions and assignments dont need an input object.

```bicep
@description('Generate a new unique resource name based on input.')
@export()
func newUniqueResourceName(resourceType sharedDefinitions.resourceTypes, resourceName string) string =>
  format('{0}{1}', setResourceTypeAbbreviation(resourceType), uniqueString(resourceName), 0, 14)

@description('Creates a new guid for policy definitions based on string input with fixed prefix.')
@export()
func newPolicyDefinitionName(guidValue string) string => 'pd-${substring(guid(guidValue), 0, 18)}'

@description('Creates a new guid for policy assignments based on string input with fixed prefix.')
@export()
func newPolicyAssignmentName(guidValue string) string => 'pa-${substring(guid(guidValue), 0, 18)}'
```

# Examples

1. Import the functions and data types from `shared.bicep` and `definition.bicep`.

```bicep
@description('Import data types for name generator.')
import { 
  sharedDefinitions
  batResourceName 
} from '../../lib/nameGen/definitions.bicep'

@description('Import functions for name generator.')
import {
  newResourceName
  newUniqueResourceName
  newSpecialResourceName
  newPolicyDefinitionName
  newPolicyAssignmentName 
} from '../../lib/nameGen/shared.bicep'
```

2. Define the input objects

```bicep
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
```

3. Generate the names feeding the input object to the approbiate function.

> [!NOTE]
> The `suffix` property in theinput object is not required. If not defined, no suffix is created. In the following example, the suffix has been added via the union function.

```bicep
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
```

4. Enjoy your consistent generated names.

```json
{
    "default1": {
        "generic": "rg-default1-euw",
        "special": "rgdefault1euw",
        "withSuffix": "rg-default1-euw-001"
    },
    "default2": {
        "generic": "rg-default2-euw-test",
        "special": "rgdefault2euwtest"
    },
    "extended1": {
        "generic": "bat-rg-extended1-euw",
        "special": "batrgextended1euw",
        "withSuffix": "bat-rg-extended1-euw-001"
    },
    "extended2": {
        "generic": "bat-rg-extended2-euw-test",
        "special": "batrgextended2euwtest"
    },
    "policy1": {
        "policyDefinition": "pd-57748e4a-5e71-5cdd",
        "policyAssignment": "pa-57748e4a-5e71-5cdd"
    },
    "policy2": {
        "policyDefinition": "pd-489ae212-2b5e-52c7",
        "policyAssignment": "pa-489ae212-2b5e-52c7"
    }
}
```