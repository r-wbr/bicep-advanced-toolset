metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

import { sharedDefinitions } from '../batShared/definitions.bicep'

@description('Defined available values for name patterns.')
type patternDefinitions = {
  default1: {
    pattern: 'default1'
    prefix: sharedDefinitions.resourceType    
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionName
    suffix: string?
  }
  default2: {
    pattern: 'default2'
    prefix: sharedDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionName
    environment: sharedDefinitions.environment
    suffix: string?
  }
  extended1: {
    pattern: 'extended1'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionName
    suffix: string?
  }
  extended2: {
    pattern: 'extended2'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionName
    environment: sharedDefinitions.environment
    suffix: string?
  }
}

@description('Defined available values for resource name input object.')
@export()
@discriminator('pattern')
type inputResourceName =
  | patternDefinitions.default1
  | patternDefinitions.default2
  | patternDefinitions.extended1
  | patternDefinitions.extended2
