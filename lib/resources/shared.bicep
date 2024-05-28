metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

@description('Import library for deployment archetypes.')
@export()
import { setEnvironment as setEnvironment } from '../deployment/shared.bicep'
import { deploymentParameters as deploymentParameters } from '../deployment/shared.bicep'
import { namePattern as namePatternType } from '../deployment/shared.bicep'
import { environment as environmentType } from '../deployment/shared.bicep'
import { businessCriticality as businessCriticalityType } from '../deployment/shared.bicep'
import { dataClassification as dataClassificationType } from '../deployment/shared.bicep'

@description('Import library for location archetypes.')
import { setLocation as setLocation } from '../locations/shared.bicep'
import { location as locationType } from '../locations/shared.bicep'

@export()
type resourceTags = {
  applicationName: string
  businessCriticality: businessCriticalityType
  costCenter: string
  creator: string
  dataClassification: dataClassificationType
  deploymentDate: string
  environment: environmentType
  owner: string
}

@export()
type resourceName = {
  @description('Corresponds to the affix {customer}?. Reference the deployment parameters with \'deploymentParameter.customer\'.')
  customer: string?
  @description('Corresponds to the affix {Prefix}.')
  prefix: resourceType
  @description('Corresponds to the affix {Name}. Abbreviation of the application name, likewise used in \'resourceTags.applicationName\'.')
  @maxLength(8)
  name: string
  @description('Corresponds to the affix {Region}.')
  region: locationType
  @description('Corresponds to the affix {Environment}?.')
  environment: environmentType?
  @description('Corresponds to the affix {Region}. Use a squential number or one these values: \'akscluster\', \'aksnode\', \'azbackup\'.')
  suffix: string?
}

@description('Creates a new resource name based on choosen name pattern.')
@export()
func newResourceName(nameValue resourceName, patternValue namePatternType) string =>
  selectNamePattern(nameValue, patternValue)

@description('Creates a new resource name without hyphens based on choosen name pattern.')
@export()
func newSpecialResourceName(nameValue resourceName, patternValue namePatternType) string =>
  selectNamePatternSpecial(nameValue, patternValue)

@description('Selects the corresponding function for the choosen name pattern.')
func selectNamePattern(nameValue resourceName, patternValue namePatternType) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2(nameValue)
        : contains(patternValue, 'extended1') ? setNamePatternExtended1(nameValue) : setNamePatternExtended2(nameValue)

@description('Selects the corresponding function for the choosen name pattern.')
func selectNamePatternSpecial(nameValue resourceName, patternValue namePatternType) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1Special(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2Special(nameValue)
        : contains(patternValue, 'extended1')
            ? setNamePatternExtended1Special(nameValue)
            : setNamePatternExtended2Special(nameValue)

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternDefault1(nameValue resourceName) string => newNameDefault1(nameValue).generic

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternDefault1Special(nameValue resourceName) string => newNameDefault1(nameValue).special

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternDefault2(nameValue resourceName) string => newNameDefault2(nameValue).generic

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternDefault2Special(nameValue resourceName) string => newNameDefault2(nameValue).special

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternExtended1(nameValue resourceName) string => newNameExtended1(nameValue).generic

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternExtended1Special(nameValue resourceName) string => newNameExtended1(nameValue).special

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternExtended2(nameValue resourceName) string => newNameExtended2(nameValue).generic

@description('Calls the name building function for the choosen name pattern.')
func setNamePatternExtended2Special(nameValue resourceName) string => newNameExtended2(nameValue).special

@description('Builds the resource name based on the provided values.')
func newNameDefault1(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region), 
        nameValue.suffix)
    : format(
        '{0}-{1}-{2}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region)))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region), 
        nameValue.suffix)
    : format(
        '{0}{1}{2}', 
        setResourceType(nameValue.prefix),
        nameValue.name, 
        setLocation(nameValue.region)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameDefault2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}-{4}-{5}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region),
        #disable-next-line BCP321 
        setEnvironment(nameValue.environment)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}{4}{5}', 
        setResourceType(nameValue.prefix),
        nameValue.name, 
        setLocation(nameValue.region),
        #disable-next-line BCP321 
        setEnvironment(nameValue.environment)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameExtended1(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}', 
        nameValue.customer, 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}', 
        nameValue.customer, 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        setLocation(nameValue.region)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameExtended2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format(
        '{0}{1}{2}{3}{4}',
        nameValue.customer,
        setResourceType(nameValue.prefix),
        nameValue.name,
        setLocation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment)
      ))
}

@description('Selects the appropriate abbreviation for resource types.')
func setResourceType(resourceTypeValue string) string => getResourceType()[resourceTypeValue]

@description('Imports and provides the library for resource types.')
func getResourceType() object => loadYamlContent('library.yaml')

@description('Defines available values for resource type.')
type resourceType =
  | 'subscription'
  | 'resourceGroup'
  | 'virtualMachine'
  | 'virtualMaschineScaleSet'
  | 'availabilitySet'
  | 'proximityPlacementGroup'
  | 'diskEncryptionSet'
  | 'osDisk'
  | 'dataDisk'
  | 'gallerie'
  | 'gallerieApplication'
  | 'gallerieImage'
  | 'capacityReservationGroup'
  | 'capacityReservation'
  | 'sshPublicKey'
  | 'networkInterface'
  | 'bastionHost'
  | 'applicationSecurityGroup'
  | 'networkSecurityGroup'
  | 'azureFirewall'
  | 'azureFirewallPolicies'
  | 'azureFirewallPoliciesRuleCollection'
  | 'ipGroup'
  | 'ddosProtectionPlan'
  | 'virtualNetwork'
  | 'virtualNetworkGateway'
  | 'virtualWan'
  | 'virtualWanHub'
  | 'natGateway'
  | 'routeTable'
  | 'applicationGateway'
  | 'internalLoadBalancer'
  | 'publicLoadBalancer'
  | 'gatewayLoadBalancer'
  | 'localNetworkGateway'
  | 'expressRouteCircuit'
  | 'expressRouteGateway'
  | 'customIp'
  | 'publicIp'
  | 'privateEndpoint'
  | 'networkWatcher'
  | 'storageAccount'
  | 'sqlServer'
  | 'sqlServerDatabase'
  | 'elasticPool'
  | 'azureVirtualDesktop'
  | 'managedIdentity'
  | 'appService'
  | 'function'
  | 'migrateProject'
  | 'keyVault'
  | 'managedHsm'
  | 'recoveryServicesVault'
  | 'backupVault'
  | 'automationAccount'
  | 'logAnalyticsWorkspace'
  | 'dataCollectionRule'
  | 'dataCollectionEndpoint'
  | 'privateLinkScope'

