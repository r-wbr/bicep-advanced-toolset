metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

@description('Import library for location archetypes.')
import { location as location } from '../locations/shared.bicep'

@export()
func setEnvironment(environmentValue string) string => getEnvironment()[environmentValue]

func getEnvironment() object => loadYamlContent('../deployment/library.yaml')

@export()
type namePattern = 'default1' | 'default2' | 'extended1' | 'extended2'

@export()
type environment = 'Production' | 'Staging' | 'Test' | 'Development'

@export()
type businessCriticality = 'Unsupported' | 'Low' | 'Medium' | 'High' | 'Unit critical' | 'Mission critical'

@export()
type dataClassification = 'Public' | 'Company' | 'Confidential' | 'Highly confidential'

@export()
type deploymentParameters = {
  @description('Primary location for deployment of resources.')
  location: location
  @description('Full name of the customer or organization.')
  @maxLength(12)
  organization: string
  @description(' Abbreviation of the organization or customer name.')
  @maxLength(4)
  customer: string
  creator: string
  @description('Name pattern for deployed resources.')
  namePattern: namePattern
}

