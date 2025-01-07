@export()
func splitResourceId(resourceId string) array => split(resourceId,'/')

@export()
func getResourceIdValues(resourceId string) object => {
  subscriptionId: splitResourceId(resourceId)[2]
  resourceGroupName: splitResourceId(resourceId)[4]
  resourceName: splitResourceId(resourceId)[8]
}
