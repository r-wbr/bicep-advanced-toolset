metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

@description('Imports library file for resource abbreviations.')
@export()
var resourceTypeAbbreviationList = loadYamlContent('../lib/resourceTypeAbbreviations.yaml')
@description('Imports library file for region abbreviations.')
@export()
var regionAbbreviationList = loadYamlContent('../lib/regionAbbreviations.yaml')
@description('Imports library file for environment abbreviations.')
@export()
var environmentAbbreviationList = loadYamlContent('../lib/environmentAbbreviations.yaml')

type environmentTypes = {
  @description('Defines the values used for name pattern selection.')
  namePattern: 'default1' | 'default2' | 'extended1' | 'extended2'
  @description('Defines the values used for environment selection')
  environment: 'Production' | 'Staging' | 'Test' | 'Development'
  @description('Defines the values used for business criticality selection.')
  businessCriticality: 'Unsupported' | 'Low' | 'Medium' | 'High' | 'Unit critical' | 'Mission critical'
  @description('Defines the values used for data classification selection.')
  dataClassification: 'Public' | 'Company' | 'Confidential' | 'Highly confidential'
}

@export()
type deploymentParameters = {
  @description('Primary location for deployment of resources.')
  location: string
  @description('Full name of the customer or organization.')
  @maxLength(12)
  organization: string
  @description(' Abbreviation of the organization or customer name.')
  @maxLength(4)
  customer: string
  creator: string
  @description('Name pattern for deployed resources.')
  naming: environmentTypes.namePattern
}

@export()
type resourceTags = {
  applicationName: string
  businessCriticality: environmentTypes.businessCriticality
  costCenter: string
  creator: string
  dataClassification: environmentTypes.dataClassification
  deploymentDate: string
  environment: environmentTypes.environment
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
func newResourceName(nameValue object, patternValue environmentTypes.namePattern) string => selectNamePattern(nameValue, patternValue)

@export()
func newSpecialResourceName(nameValue object, patternValue environmentTypes.namePattern) string => selectNamePatternSpecial(nameValue, patternValue)

func selectNamePattern(nameValue object, patternValue environmentTypes.namePattern) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2(nameValue)
        : contains(patternValue, 'extended1')
            ? setNamePatternExtended1(nameValue) 
            : setNamePatternExtended2(nameValue)

func selectNamePatternSpecial(nameValue object, patternValue environmentTypes.namePattern) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1Special(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2Special(nameValue)
        : contains(patternValue, 'extended1')
            ? setNamePatternExtended1Special(nameValue)
            : setNamePatternExtended2Special(nameValue)

func setNamePatternDefault1(nameValue object) string => newNameDefault1(nameValue).generic
func setNamePatternDefault1Special(nameValue object) string => newNameDefault1(nameValue).special

func setNamePatternDefault2(nameValue object) string => newNameDefault2(nameValue).generic
func setNamePatternDefault2Special(nameValue object) string =>
  newNameDefault2(nameValue).special

func setNamePatternExtended1(nameValue object) string => newNameExtended1(nameValue).generic
func setNamePatternExtended1Special(nameValue object) string => newNameExtended1(nameValue).special

func setNamePatternExtended2(nameValue object) string => newNameExtended2(nameValue).generic
func setNamePatternExtended2Special(nameValue object) string =>
  newNameExtended2(nameValue).special

func newNameDefault1(nameValue object) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
        )
        : format('{0}-{1}-{2}', 
        nameValue.prefix, 
        nameValue.name, 
        nameValue.region
        ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
      )
        : format('{0}{1}{2}', 
        nameValue.prefix, 
        nameValue.name, 
        nameValue.region
        ))
}

@export()
func newNameDefault2(nameValue object) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment,
        nameValue.suffix
      )
    : format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.environment
      ))
}

func newNameExtended1(nameValue object) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region,
        nameValue.suffix
      )
    : format(
        '{0}{1}{2}{3}',
        nameValue.customer,
        nameValue.prefix,
        nameValue.name,
        nameValue.region
      ))
}

func newNameExtended2(nameValue object) object => {
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
