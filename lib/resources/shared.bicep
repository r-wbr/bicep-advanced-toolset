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

@description('Creates a new unique resource name without hyphens regardless of the selected name pattern.')
@export()
func newUniqueResourceName(resourceTypeValue resourceType, nameValue string) string => 
  format(
    '{0}{1}', 
    setResourceType(resourceTypeValue), 
    substring(uniqueString(nameValue),0,18))

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
| 'AI Search'
| 'Azure AI services multi-service account'
| 'Azure AI Video Indexer'
| 'Azure Machine Learning workspace'
| 'Azure OpenAI Service'
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
| 'Azure Analysis Services server'
| 'Azure Databricks workspace'
| 'Azure Data Explorer cluster'
| 'Azure Data Explorer cluster database'
| 'Azure Data Factory'
| 'Azure Digital Twin instance'
| 'Azure Stream Analytics'
| 'Azure Synapse Analytics private link hub'
| 'Azure Synapse Analytics SQL Dedicated Pool'
| 'Azure Synapse Analytics Spark Pool'
| 'Azure Synapse Analytics workspaces'
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
| 'Azure Load Testing instance'
| 'Availability set'
| 'Azure Arc enabled server'
| 'Azure Arc enabled Kubernetes cluster'
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
| 'Azure Cosmos DB database'
| 'Azure Cosmos DB for Apache Cassandra account'
| 'Azure Cosmos DB for MongoDB account'
| 'Azure Cosmos DB for NoSQL account'
| 'Azure Cosmos DB for Table account'
| 'Azure Cosmos DB for Apache Gremlin account'
| 'Azure Cosmos DB PostgreSQL cluster'
| 'Azure Cache for Redis instance'
| 'Azure SQL Database server'
| 'Azure SQL database'
| 'Azure SQL Elastic Job agent'
| 'Azure SQL Elastic Pool'
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
| 'Azure Managed Grafana'
| 'API management service instance'
| 'Integration account'
| 'Logic app'
| 'Service Bus namespace'
| 'Service Bus queue'
| 'Service Bus topic'
| 'Service Bus topic subscription'
| 'Automation account'
| 'Application Insights'
| 'Azure Monitor action group'
| 'Azure Monitor data collection rule'
| 'Azure Monitor alert processing rule'
| 'Blueprint (planned for deprecation)'
| 'Blueprint assignment (planned for deprecation)'
| 'Data collection endpoint'
| 'Log Analytics workspace'
| 'Log Analytics query packs'
| 'Management group'
| 'Microsoft Purview instance'
| 'Resource group'
| 'Template specs name'
| 'Azure Migrate project'
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
| 'Azure Bastion'
| 'Key vault'
| 'Key Vault Managed HSM'
| 'Managed identity'
| 'SSH key'
| 'VPN Gateway'
| 'VPN connection'
| 'VPN site'
| 'Web Application Firewall (WAF) policy'
| 'Web Application Firewall (WAF) policy rule group'
| 'Azure StorSimple'
| 'Backup Vault name'
| 'Backup Vault policy'
| 'File share'
| 'Storage account'
| 'Storage Sync Service name'
| 'Azure Lab Services lab plan'
| 'Virtual desktop host pool'
| 'Virtual desktop application group'
| 'Virtual desktop workspace'
| 'Virtual desktop scaling plan'
| 'Subscription'
