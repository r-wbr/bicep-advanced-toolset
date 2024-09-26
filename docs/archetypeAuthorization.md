# Authorization

The archetype **authorization** provides data types and a library file for role definitions

1. From the target template, import the archetypes.

```bicep
@description('Import library for authorization archetypes.')
import { setRoleAssignment, newPolicyDefinitionName, newPolicyAssignmentName } from '../lib/authorization/shared.bicep'
```

2. Create a consistent guid for policy definitions and assignments.

```bicep
@description('Creates a new guid for policy definitions based on string input.')
output policyDefinitionName string = newPolicyDefinitionName('This is a random string.')

@description('Creates a new guid for policy assignments based on string input.')
output policyAssignmentName string = newPolicyAssignmentName('This is a random string.')

/* 
output policyDefinitionName = pd-1391f145-c112-58b3
output policyAssignmentName = pa-1391f145-c112-58b3
*/
```

3. Define a variable to create the input object for the role assignment. By referring to user-defined data types in the corresponding objects, predefined values can be selected.

```bicep
@description('Defines the name and properties of the role assignment.')
var roleAssignmentValues = setRoleAssignment('User', 'Contributor', '<PrincipalID>')
```

4. Use the variable object as input for the role assignment.

```bicep
@description('Creates the role assignment based on the value object.')
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentValues.name
  properties: roleAssignmentValues.properties
}
```
