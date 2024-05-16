metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

@export()
var resourceTypeAbbreviationList = loadYamlContent('../lib/resourceTypeAbbreviations.yaml')
@export()
var regionAbbreviationList = loadYamlContent('../lib/regionAbbreviations.yaml')
@export()
var environmentAbbreviationList = loadYamlContent('../lib/environmentAbbreviations.yaml')

@export()
type pattern = 'default1' | 'default2' | 'extended1' | 'extended2'

@export()
type import = {
  location: string
  @maxLength(12)
  customerOrganization: string
  @maxLength(4)
  customerAbbreviation: string
  creator: string
  namePattern: pattern
}

@export()
type resourceTag = {
  applicationName: string
  businessCriticality: 'Unsupported' | 'Low' | 'Medium' | 'High' | 'Unit critical' | 'Mission critical'
  costCenter: string
  creator: string
  dataClassification: 'Public' | 'Company' | 'Confidential' | 'Highly confidential'
  deploymentDate: string
  environment: 'Production' | 'Staging' | 'Test' | 'Development'
  owner: string
}

@export()
type resourceName = {
  customerAbbreviation: string?
  resourceType: string
  nameAbbreviation: string
  locationAbbreviation: string
  environmentAbbreviation: string?
  sequenceNumber: string?
}

@export()
func newPolicyDefinitionName(guidValue string) string => 'pd-${substring(guid(guidValue), 0, 18)}'

@export()
func newPolicyAssignmentName(guidValue string) string => 'pa-${substring(guid(guidValue), 0, 18)}'

@export()
func newResourceName(nameValue object, patternValue pattern) string => selectNamePattern(nameValue, patternValue)

@export()
func newSpecialResourceName(nameValue object, patternValue pattern) string => selectNamePatternSpecial(nameValue, patternValue)

func selectNamePattern(nameValue object, patternValue pattern) string =>
  contains(patternValue, 'default1')
    ? setNamePatternDefault1(nameValue)
    : contains(patternValue, 'default2')
        ? setNamePatternDefault2(nameValue)
        : contains(patternValue, 'extended1')
            ? setNamePatternExtended1(nameValue) 
            : setNamePatternExtended2(nameValue)

func selectNamePatternSpecial(nameValue object, patternValue pattern) string =>
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
  generic: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}-{1}-{2}-{3}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.sequenceNumber
        )
        : format('{0}-{1}-{2}', 
        nameValue.resourceType, 
        nameValue.nameAbbreviation, 
        nameValue.locationAbbreviation
        ))
  special: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}{1}{2}{3}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.sequenceNumber
      )
        : format('{0}{1}{2}', 
        nameValue.resourceType, 
        nameValue.nameAbbreviation, 
        nameValue.locationAbbreviation
        ))
}

@export()
func newNameDefault2(nameValue object) object => {
  generic: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation
      ))
  special: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation
      ))
}

func newNameExtended1(nameValue object) object => {
  generic: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}-{1}-{2}-{3}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation
      ))
  special: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}{1}{2}{3}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation
      ))
}

func newNameExtended2(nameValue object) object => {
  generic: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation
      ))
  special: toLower(contains(nameValue, 'sequenceNumber')
    ? format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation,
        nameValue.sequenceNumber
      )
    : format(
        '{0}{1}{2}{3}{4}',
        nameValue.customerAbbreviation,
        nameValue.resourceType,
        nameValue.nameAbbreviation,
        nameValue.locationAbbreviation,
        nameValue.environmentAbbreviation
      ))
}
