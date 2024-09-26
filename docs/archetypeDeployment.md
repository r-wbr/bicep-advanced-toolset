# Deployment

The archetype **deployment** contains data types for a centralized object, containing all needed values for the deployment. The object can be inherited by child modules.

1. From the target template, import the archetypes.

```bicep
@description('Import library for deployment archetypes.')
import { deploymentParameters as deploymentParameterType } from '../lib/deployment/shared.bicep'
```

2. Use the data type to create a consistent deployment parameters object.

> [!TIP]
> The data type can also be used in parameters files, if imported in the main template.

```bicep
using 'main.bicep'

@description('These object defines the environment values for the whole deployment.')
param deploymentParameters = {
  location: 'westeurope'
  creator: ''
  organizationAbbreviation: 'foo'
  organization: 'FooBar Inc'
  namePattern: 'default1'
}
```