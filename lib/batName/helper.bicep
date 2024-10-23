metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

import { sharedDefinitions } from '../batShared/definitions.bicep'

@description('Calls the helper function to select abbreviation for resource types.')
@export()
func setResourceTypeAbbreviation(resourceType string) string => getResourceTypeAbbreviation()[resourceType]

@description('Selects the appropriate abbreviation for resource types from library file.')
func getResourceTypeAbbreviation() object => loadYamlContent('../resourceTypeAbbreviations.yaml')

@description('Calls the helper function to select abbreviation for locations.')
@export()
func setRegionAbbreviation(region string) string => getRegionAbbreviation()[region]

@description('Selects the appropriate abbreviation for locations from library file.')
func getRegionAbbreviation() object => loadYamlContent('../regionAbbreviations.yaml')

@description('Calls the helper function to select abbreviation for environments.')
@export()
func setEnvironmentAbbreviation(environment string) string => getEnvironmentAbbreviation()[environment]

@description('Selects the appropriate abbreviation for environments from library file.')
func getEnvironmentAbbreviation() object => loadYamlContent('../environmentAbbreviations.yaml')

@description('Selects the approbiate name pattern for default name generation.')
@export()
func setResourceName(input object) object => {
  default1: toLower(contains(input, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        input.suffix
      )
    : format('{0}-{1}-{2}', 
        setResourceTypeAbbreviation(input.prefix), 
        input.name, 
        setRegionAbbreviation(input.region)
      ))
  default2: toLower(contains(input, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test'),
        input.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test')
      ))
  extended1: toLower(contains(input, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.?region ?? 'global'),
        input.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region ?? 'global')
      ))
  extended2: toLower(contains(input, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        #disable-next-line BCP321
        setEnvironmentAbbreviation(input.?environment ?? 'Test'),
        input.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        #disable-next-line BCP321
        setEnvironmentAbbreviation(input.?environment ?? 'Test')
      ))
}

@description('Selects the approbiate name pattern for special name generation.')
@export()
func setSpecialResourceName(input object) object => {
  default1: toLower(contains(input, 'suffix')
    ? format(
        '{0}{1}{2}{3}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        input.suffix
      )
    : format(
      '{0}{1}{2}',
      setResourceTypeAbbreviation(input.prefix),
      input.name, setRegionAbbreviation(input.region)
    ))
  default2: toLower(contains(input, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test'),
        input.suffix
      )
    : format(
        '{0}{1}{2}{3}',
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test')
      ))
  extended1: toLower(contains(input, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.?region ?? 'global'),
        input.suffix
      )
    : format(
        '{0}{1}{2}{3}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region ?? 'global')
      ))
  extended2: toLower(contains(input, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}{5}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test'),
        input.suffix
      )
    : format(
        '{0}{1}{2}{3}{4}',
        input.?organization,
        setResourceTypeAbbreviation(input.prefix),
        input.name,
        setRegionAbbreviation(input.region),
        setEnvironmentAbbreviation(input.?environment ?? 'Test')
      ))
}
