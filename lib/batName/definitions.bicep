metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

import { batDefinitions } from '../batShared/definitions.bicep'

@description('Defined available values for name patterns.')
type patternDefinitions = {
  default1: {
    pattern: 'default1'
    prefix: batDefinitions.resourceType    
    @maxLength(12)
    name: string
    region: batDefinitions.regionName
    suffix: string?
  }
  default2: {
    pattern: 'default2'
    prefix: batDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: batDefinitions.regionName
    environment: batDefinitions.environment
    suffix: string?
  }
  extended1: {
    pattern: 'extended1'
    @maxLength(4)
    organization: string
    prefix: batDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: batDefinitions.regionName
    suffix: string?
  }
  extended2: {
    pattern: 'extended2'
    @maxLength(4)
    organization: string
    prefix: batDefinitions.resourceType      
    @maxLength(12)
    name: string
    region: batDefinitions.regionName
    environment: batDefinitions.environment
    suffix: string?
  }
}

@description('Defined available values for resource name input object.')
@export()
@discriminator('pattern')
type batResourceName =
  | patternDefinitions.default1
  | patternDefinitions.default2
  | patternDefinitions.extended1
  | patternDefinitions.extended2
