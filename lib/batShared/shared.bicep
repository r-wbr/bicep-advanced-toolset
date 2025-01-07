import {
  getResourceIdValues
} from 'helper.bicep'

@export()
func getSubscriptionId(resourceId string) string => getResourceIdValues(resourceId).subscriptionId

@export()
func getResourceGroupName(resourceId string) string => getResourceIdValues(resourceId).resourceGroupName

@export()
func getResourceName(resourceId string) string => getResourceIdValues(resourceId).resourceName
