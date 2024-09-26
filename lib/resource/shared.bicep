metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

@description('Import library for deployment archetypes.')
@export()
import { setEnvironment, deploymentParameters } from '../deployment/shared.bicep'
import { namePattern as namePatternType } from '../deployment/shared.bicep'
import { environment as environmentType } from '../deployment/shared.bicep'
import { businessCriticality as businessCriticalityType } from '../deployment/shared.bicep'
import { dataClassification as dataClassificationType } from '../deployment/shared.bicep'

@description('Import library for location archetypes.')
import { getRegionAbbreviation, regionName } from '../location/shared.bicep'

@export()
type resourceTags = {
  ApplicationName: string
  BusinessCriticality: businessCriticalityType
  CostCenter: string
  Creator: string
  DataClassification: dataClassificationType
  DeploymentDate: string
  Environment: environmentType
  Owner: string
}

type default1ResourceName = {
  prefix: resourceType
  @maxLength(12)
  name: string
  region: regionName
  suffix: string?
}

type default2ResourceName = {
  prefix: resourceType
  @maxLength(12)
  name: string
  region: regionName
  environment: environmentType
  suffix: string?
}

@export()
type resourceName = {
  organization: string?
  prefix: resourceType
  @maxLength(12)
  name: string
  region: regionName
  environment: environmentType?
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

@description('Creates a new unique resource name without hyphens regardless of the selected name pattern.')
@export()
func newUniqueResourceName(resourceTypeValue resourceType, nameValue string) string => 
  format(
    '{0}{1}', 
    setResourceType(resourceTypeValue), 
    uniqueString(nameValue),0,14)

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
        getRegionAbbreviation(nameValue.region), 
        nameValue.suffix)
    : format(
        '{0}-{1}-{2}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        getRegionAbbreviation(nameValue.region)))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        getRegionAbbreviation(nameValue.region), 
        nameValue.suffix)
    : format(
        '{0}{1}{2}', 
        setResourceType(nameValue.prefix),
        nameValue.name, 
        getRegionAbbreviation(nameValue.region)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameDefault2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}', 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321 
        setEnvironment(nameValue.environment)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}', 
        setResourceType(nameValue.prefix),
        nameValue.name, 
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321 
        setEnvironment(nameValue.environment)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameExtended1(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        nameValue.suffix
      )
    : format('{0}-{1}-{2}-{3}', 
        nameValue.organization, 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        getRegionAbbreviation(nameValue.region)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        nameValue.suffix
      )
    : format('{0}{1}{2}{3}', 
        nameValue.organization, 
        setResourceType(nameValue.prefix), 
        nameValue.name, 
        getRegionAbbreviation(nameValue.region)
      ))
}

@description('Builds the resource name based on the provided values.')
func newNameExtended2(nameValue resourceName) object => {
  generic: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}-{1}-{2}-{3}-{4}-{5}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format(
        '{0}-{1}-{2}-{3}-{4}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment)
      ))
  special: toLower(contains(nameValue, 'suffix')
    ? format(
        '{0}{1}{2}{3}{4}{5}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
        #disable-next-line BCP321
        setEnvironment(nameValue.environment),
        nameValue.suffix
      )
    : format(
        '{0}{1}{2}{3}{4}',
        nameValue.organization,
        setResourceType(nameValue.prefix),
        nameValue.name,
        getRegionAbbreviation(nameValue.region),
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
| 'AI Search'
| 'AI services multi-service account'
| 'AI Video Indexer'
| 'Machine Learning workspace'
| 'OpenAI Service'
| 'Bot service'
| 'Computer vision'
| 'Content moderator'
| 'Content safety'
| 'Custom vision (prediction)'
| 'Custom vision (training)'
| 'Document intelligence'
| 'Face API'
| 'Health Insights'
| 'Immersive reader'
| 'Language service'
| 'Speech service'
| 'Translator'
| 'Analysis Services server'
| 'Databricks workspace'
| 'Data Explorer cluster'
| 'Data Explorer cluster database'
| 'Data Factory'
| 'Digital Twin instance'
| 'Stream Analytics'
| 'Synapse Analytics private link hub'
| 'Synapse Analytics SQL Dedicated Pool'
| 'Synapse Analytics Spark Pool'
| 'Synapse Analytics workspaces'
| 'Data Lake Store account'
| 'Data Lake Analytics account'
| 'Event Hubs namespace'
| 'Event hub'
| 'Event Grid domain'
| 'Event Grid subscriptions'
| 'Event Grid topic'
| 'Event Grid system topic'
| 'HDInsight - Hadoop cluster'
| 'HDInsight - HBase cluster'
| 'HDInsight - Kafka cluster'
| 'HDInsight - Spark cluster'
| 'HDInsight - Storm cluster'
| 'HDInsight - ML Services cluster'
| 'IoT hub'
| 'Provisioning services'
| 'Provisioning services certificate'
| 'Power BI Embedded'
| 'Time Series Insights environment'
| 'App Service environment'
| 'App Service plan'
| 'Load Testing instance'
| 'Availability set'
| 'Arc enabled server'
| 'Arc enabled Kubernetes cluster'
| 'Batch accounts'
| 'Cloud service'
| 'Communication Services'
| 'Disk encryption set'
| 'Function app'
| 'Gallery'
| 'Hosting environment'
| 'Image template'
| 'Managed disk (OS)'
| 'Managed disk (data)'
| 'Notification Hubs'
| 'Notification Hubs namespace'
| 'Proximity placement group'
| 'Restore point collection'
| 'Snapshot'
| 'Static web app'
| 'Virtual machine'
| 'Virtual machine scale set'
| 'Virtual machine maintenance configuration'
| 'VM storage account'
| 'Web app'
| 'AKS cluster'
| 'AKS system node pool'
| 'AKS user node pool'
| 'Container apps'
| 'Container apps environment'
| 'Container registry'
| 'Container instance'
| 'Service Fabric cluster'
| 'Service Fabric managed cluster'
| 'Cosmos DB database'
| 'Cosmos DB for Apache Cassandra account'
| 'Cosmos DB for MongoDB account'
| 'Cosmos DB for NoSQL account'
| 'Cosmos DB for Table account'
| 'Cosmos DB for Apache Gremlin account'
| 'Cosmos DB PostgreSQL cluster'
| 'Cache for Redis instance'
| 'SQL Database server'
| 'SQL database'
| 'SQL Elastic Job agent'
| 'SQL Elastic Pool'
| 'MariaDB server'
| 'MariaDB database'
| 'MySQL database'
| 'PostgreSQL database'
| 'SQL Server Stretch Database'
| 'SQL Managed Instance'
| 'App Configuration store'
| 'Maps account'
| 'SignalR'
| 'WebPubSub'
| 'Managed Grafana'
| 'API management service instance'
| 'Integration account'
| 'Logic app'
| 'Service Bus namespace'
| 'Service Bus queue'
| 'Service Bus topic'
| 'Service Bus topic subscription'
| 'Automation account'
| 'Application Insights'
| 'Action group'
| 'Alert processing rule'
| 'Data collection rule'
| 'Data collection endpoint'
| 'Blueprint (planned for deprecation)'
| 'Blueprint assignment (planned for deprecation)'
| 'Log Analytics workspace'
| 'Log Analytics query packs'
| 'Management group'
| 'Microsoft Purview instance'
| 'Resource group'
| 'Template specs name'
| 'Migrate project'
| 'Database Migration Service instance'
| 'Recovery Services vault'
| 'Application gateway'
| 'Application security group (ASG)'
| 'CDN profile'
| 'CDN endpoint'
| 'Connections'
| 'DNS forwarding ruleset'
| 'DNS private resolver'
| 'DNS private resolver inbound endpoint'
| 'DNS private resolver outbound endpoint'
| 'Firewall'
| 'Firewall policy'
| 'ExpressRoute circuit'
| 'ExpressRoute gateway'
| 'Front Door (Standard/Premium) profile'
| 'Front Door (Standard/Premium) endpoint'
| 'Front Door firewall policy'
| 'Front Door (classic)'
| 'IP group'
| 'Load balancer (internal)'
| 'Load balancer (external)'
| 'Load balancer rule'
| 'Local network gateway'
| 'NAT gateway'
| 'Network interface (NIC)'
| 'Network security group (NSG)'
| 'Network security group (NSG) security rules'
| 'Network Watcher'
| 'Private Link'
| 'Private endpoint'
| 'Public IP address'
| 'Public IP address prefix'
| 'Route filter'
| 'Route server'
| 'Route table'
| 'Service endpoint policy'
| 'Traffic Manager profile'
| 'User defined route (UDR)'
| 'Virtual network'
| 'Virtual network gateway'
| 'Virtual network manager'
| 'Virtual network peering'
| 'Virtual network subnet'
| 'Virtual WAN'
| 'Virtual WAN Hub'
| 'Bastion'
| 'Key vault'
| 'Key Vault Managed HSM'
| 'Managed identity'
| 'SSH key'
| 'VPN Gateway'
| 'VPN connection'
| 'VPN site'
| 'Web Application Firewall (WAF) policy'
| 'Web Application Firewall (WAF) policy rule group'
| 'StorSimple'
| 'Backup Vault name'
| 'Backup Vault policy'
| 'File share'
| 'Storage account'
| 'Storage Sync Service name'
| 'Lab Services lab plan'
| 'Virtual desktop host pool'
| 'Virtual desktop application group'
| 'Virtual desktop workspace'
| 'Virtual desktop scaling plan'
| 'Subscription'
