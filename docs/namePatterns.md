# Name Patterns

Name patterns define the logic how the structure of a name is build, and which affixes are included in the name.

The following default name patterns are included:
  - Default 1: Prefix-Name-Region-Suffix
  - Default 2: Prefix-Name-Region-Environment-Suffix
The following extended name patterns are included, providing the possibility to include a custom prefix:
  - Extended 1: Custom-Prefix-Name-Region-Suffix
  - Extended 2: Custom-Prefix-Name-Region-Environment-Suffix

# Usage

Each name pattern need specific input, based on the pattern logic. If a function is fed with the wrong input, likely a missing object property, the deployment will fail. All name patterns should be included in the `patternDefinitions` data type.

> [!NOTE]
> The suffix in the name pattern is optional. If not defined in the input object, no suffix is created by the function.

```bicep
@description('Defined available values for name patterns.')
type patternDefinitions = {
  default1: {
    pattern: 'default1'
    prefix: sharedDefinitions.resourceTypes    
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    suffix: string?
  }
  default2: {
    pattern: 'default2'
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    environment: sharedDefinitions.environment
    suffix: string?
  }
  extended1: {
    pattern: 'extended1'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    suffix: string?
  }
  extended2: {
    pattern: 'extended2'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    environment: sharedDefinitions.environment
    suffix: string?
  }
}
```

The available name patterns must be included in the input object for the resource name. The tagged union data type `pattern` is used to include the pattern name, which is needed for the helper functions `setResourceName()` and `setSpecialResourceName()` to identify the pattern.

```bicep
@description('Defined available values for resource name input object.')
@export()
@discriminator('pattern')
type inputResourceName =
  | patternDefinitions.default1
  | patternDefinitions.default2
  | patternDefinitions.extended1
  | patternDefinitions.extended2
```
