metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

@description('Import library for location archetypes.')
import { regionName } from '../locations/shared.bicep'

@description('Selects the appropriate abbreviation for environments.')
@export()
func setEnvironment(environmentValue string) string => getEnvironment()[environmentValue]

@description('Imports and provides the library for environments.')
func getEnvironment() object => loadYamlContent('../deployment/library.yaml')

@description('Defines available values for name pattern.')
@export()
type namePattern = 'default1' | 'default2' | 'extended1' | 'extended2'

@description('Defines available values for environment.')
@export()
type environment = 'Production' | 'Staging' | 'Test' | 'Development'

@description('Defines available values for business criticality.')
@export()
type businessCriticality = 'Unsupported' | 'Low' | 'Medium' | 'High' | 'Unit critical' | 'Mission critical'

@description('Defines available values for data classification.')
@export()
type dataClassification = 'Public' | 'Company' | 'Confidential' | 'Highly confidential'

@description('Defines available values for deployment parameters.')
@export()
type deploymentParameters = {
  @description('Primary location for deployment of resources.')
  location: regionName
  @description('Full name of the customer or organization.')
  @maxLength(12)
  organization: string
  @description('Abbreviation of the organization or customer name.')
  @maxLength(4)
  organizationAbbreviation: string
  creator: string
  @description('Name pattern for deployed resources.')
  namePattern: namePattern
}
