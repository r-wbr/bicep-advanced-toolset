metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

import { 
  sharedDefinitions
  inputResourceName
 } from 'definitions.bicep'
import {
  setResourceName
  setSpecialResourceName
  setResourceTypeAbbreviation
  setRegionAbbreviation
  setEnvironmentAbbreviation
} from 'helper.bicep'

@description('Calls the helper function to generate a new default resource name based on input.')
@export()
func newResourceName(input inputResourceName) string => setResourceName(input)[(string(input.pattern))]

@description('Calls the helper function to generate a new special resource name based on input.')
@export()
func newSpecialResourceName(input inputResourceName) string => setSpecialResourceName(input)[(string(input.pattern))]

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
