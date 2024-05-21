metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-tools'

@description('Import library for deployment archetypes.')
@export()
var environmentAbbreviationList = loadYamlContent('../lib/deployment/abbreviations.yaml')
import { namePattern as namePatternType } from '../lib/deployment/types.bicep'
import { environment as environmentType } from '../lib/deployment/types.bicep'
import { businessCriticality as businessCriticalityType } from '../lib/deployment/types.bicep'
import { dataClassification as dataClassificationType } from '../lib/deployment/types.bicep'

@description('Import library for authorization archetypes.')
@export()
var roleDefinitionsList = loadYamlContent('../lib/authorization/archetypes.yaml')
import { roleDefinition as roleDefinitionType } from '../lib/authorization/types.bicep'

@description('Import library for resource archetypes.')
@export()
var resourceTypeAbbreviations = loadYamlContent('../lib/resources/abbreviations.yaml')
import { resourceType as resourceType } from '../lib/resources/types.bicep'

@description('Import library for location archetypes.')
@export()
var locationAbbreviations = loadYamlContent('../lib/locations/abbreviations.yaml')
import { location as locationType } from '../lib/locations/types.bicep'

@export()
type deploymentParameters = {
  @description('Primary location for deployment of resources.')
  location: locationType
  @description('Full name of the customer or organization.')
  @maxLength(12)
  organization: string
  @description(' Abbreviation of the organization or customer name.')
  @maxLength(4)
  customer: string
  creator: string
  @description('Name pattern for deployed resources.')
  namePattern: namePatternType
}

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
  @description('Corresponds to the affix {Prefix}. Reference the library files with \'lib.prefixAbbreviationList.prefixName\'.')
  prefix: string
  @description('Corresponds to the affix {Name}. Abbreviation of the application name, likewise used in \'resourceTags.applicationName\'.')
  @maxLength(8)
  name: string
  @description('Corresponds to the affix {Region}. Reference the library files from the deployment parameters \'lib.regionAbbreviationList[deploymentParameter.location]\'.')
  region: string
  @description('Corresponds to the affix {Environment}?. Reference the library files with from the resource tags object \'lib.environmentList[testResourceTags.environment]\'.')
  environment: string?
  @description('Corresponds to the affix {Region}. Use a squential number or one these values \'akscluster\', \'aksnode\', \'azbackup\'.')
  suffix: string?
}

@export()
func newPolicyDefinitionName(guidValue string) string => 'pd-${substring(guid(guidValue), 0, 18)}'

@export()
func newPolicyAssignmentName(guidValue string) string => 'pa-${substring(guid(guidValue), 0, 18)}'

@export()
func newResourceName(nameValue resourceName, patternValue namePatternType) string =>
  selectNamePattern(nameValue, patternValue)

@export()
func newSpecialResourceName(nameValue resourceName, patternValue namePatternType) string =>
  selectNamePatternSpecial(nameValue, patternValue)

func selectNamePattern(nameValue resourceName, patternValue namePatternType) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2(nameValue)
        : contains(patternValue, 'extended1') ? setNamePatternExtended1(nameValue) : setNamePatternExtended2(nameValue)

func selectNamePatternSpecial(nameValue resourceName, patternValue namePatternType) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1Special(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2Special(nameValue)
        : contains(patternValue, 'extended1')
            ? setNamePatternExtended1Special(nameValue)
            : setNamePatternExtended2Special(nameValue)

func setNamePatternDefault1(nameValue resourceName) string => newNameDefault1(nameValue).generic
func setNamePatternDefault1Special(nameValue resourceName) string => newNameDefault1(nameValue).special

func setNamePatternDefault2(nameValue resourceName) string => newNameDefault2(nameValue).generic
func setNamePatternDefault2Special(nameValue resourceName) string => newNameDefault2(nameValue).special

func setNamePatternExtended1(nameValue resourceName) string => newNameExtended1(nameValue).generic
func setNamePatternExtended1Special(nameValue resourceName) string => newNameExtended1(nameValue).special

func setNamePatternExtended2(nameValue resourceName) string => newNameExtended2(nameValue).generic
func setNamePatternExtended2Special(nameValue resourceName) string => newNameExtended2(nameValue).special

func newNameDefault1(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format('{0}-{1}-{2}-{3}', nameValue.prefix, nameValue.name, nameValue.region, nameValue.suffix)
    : format('{0}-{1}-{2}', nameValue.prefix, nameValue.name, nameValue.region))
  special: toLower(contains(nameValue, 'suffix')
    ? format('{0}{1}{2}{3}', nameValue.prefix, nameValue.name, nameValue.region, nameValue.suffix)
    : format('{0}{1}{2}', nameValue.prefix, nameValue.name, nameValue.region))
}

@export()
func newNameDefault2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}-{4}-{5}', nameValue.prefix, nameValue.name, nameValue.region, nameValue.environment))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}{4}{5}', nameValue.prefix, nameValue.name, nameValue.region, nameValue.environment))
}

func newNameExtended1(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}', nameValue.customer, nameValue.prefix, nameValue.name, nameValue.region))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}', nameValue.customer, nameValue.prefix, nameValue.name, nameValue.region))
}

func newNameExtended2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format(
        '{0}{1}{2}{3}{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment
      ))
}
