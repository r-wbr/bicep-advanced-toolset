metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

targetScope = 'subscription'

import * as lib from '../src/shared.bicep'
import { newResourceName as newResourceName } from '../src/shared.bicep'
import { newSpecialResourceName as newSpecialResourceName } from '../src/shared.bicep'
import { resourceName as setResourceName } from '../src/shared.bicep'
import { resourceTags as setResourceTags } from '../src/shared.bicep'

param deploymentTimestamp string = utcNow('dd.MM.yyyy')
param deploymentParameters lib.deploymentParameters

param testResourceTags setResourceTags = {
  applicationName: 'Test application'
  businessCriticality: 'Medium'
  costCenter: '0000'
  creator: deploymentParameters.creator
  dataClassification: 'Public'
  deploymentDate: deploymentTimestamp
  environment: 'Production'
  owner: 'testuser@foo.bar'
}

param testResourceName setResourceName = {
  customer: deploymentParameters.customer
  prefix: 'resourceGroup'
  name: 'testapp'
  region: 'westeurope'
  environment: 'Development'
  suffix: '001'
}

resource testResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: newResourceName(testResourceName, deploymentParameters.namePattern)
  location: deploymentParameters.location
  tags: testResourceTags
}

output resourceName string = testResourceGroup.name
