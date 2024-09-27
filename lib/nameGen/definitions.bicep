metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'

@description('Defined available values for data types.')
@export()
type sharedDefinitions = {
  namePattern:
    | 'default1' 
    | 'default2' 
    | 'extended1' 
    | 'extended2'
  environment:
    | 'Production' 
    | 'Staging' 
    | 'Test' 
    | 'Development'
  businessCriticality:
    | 'Unsupported' 
    | 'Low' 
    | 'Medium' 
    | 'High' 
    | 'Unit critical' 
    | 'Mission critical'
  dataClassification:
    | 'Public' 
    | 'Company' 
    | 'Confidential' 
    | 'Highly confidential'
  resourceTypes:
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
  regionNames:
    | 'global'
    | 'eastus'
    | 'eastus2'
    | 'southcentralus'
    | 'westus2'
    | 'westus3'
    | 'australiaeast'
    | 'southeastasia'
    | 'northeurope'
    | 'swedencentral'
    | 'uksouth'
    | 'westeurope'
    | 'centralus'
    | 'southafricanorth'
    | 'centralindia'
    | 'eastasia'
    | 'japaneast'
    | 'koreacentral'
    | 'canadacentral'
    | 'francecentral'
    | 'germanywestcentral'
    | 'italynorth'
    | 'norwayeast'
    | 'polandcentral'
    | 'spaincentral'
    | 'switzerlandnorth'
    | 'mexicocentral'
    | 'uaenorth'
    | 'brazilsouth'
    | 'israelcentral'
    | 'qatarcentral'
    | 'northcentralus'
    | 'westus'
    | 'japanwest'
    | 'centraluseuap'
    | 'eastus2euap'
    | 'westcentralus'
    | 'southafricawest'
    | 'australiacentral'
    | 'australiacentral2'
    | 'australiasoutheast'
    | 'koreasouth'
    | 'southindia'
    | 'westindia'
    | 'canadaeast'
    | 'francesouth'
    | 'germanynorth'
    | 'norwaywest'
    | 'switzerlandwest'
    | 'ukwest'
    | 'uaecentral'
    | 'brazilsoutheast'
}

@description('Defined available values for resource tags input object.')
@export()
type inputResourceTag = {
  ApplicationName: string
  BusinessCriticality: sharedDefinitions.businessCriticality
  CostCenter: string
  Creator: string
  DataClassification: sharedDefinitions.dataClassification
  DeploymentDate: string
  Environment: sharedDefinitions.environment
  Owner: string
}

@description('Defined available values for name patterns.')
type patternDefinitions = {
  default1: {
    pattern: 'default1'
    prefix: sharedDefinitions.resourceTypes    
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    suffix: string?
  }
  default2: {
    pattern: 'default2'
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    environment: sharedDefinitions.environment
    suffix: string?
  }
  extended1: {
    pattern: 'extended1'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    suffix: string?
  }
  extended2: {
    pattern: 'extended2'
    @maxLength(4)
    organization: string
    prefix: sharedDefinitions.resourceTypes      
    @maxLength(12)
    name: string
    region: sharedDefinitions.regionNames
    environment: sharedDefinitions.environment
    suffix: string?
  }
}

@description('Defined available values for resource name input object.')
@export()
@discriminator('pattern')
type inputResourceName =
  | patternDefinitions.default1
  | patternDefinitions.default2
  | patternDefinitions.extended1
  | patternDefinitions.extended2

@export()
type sharedParameters = {
  @description('Primary location for deployment of resources.')
  location: sharedDefinitions.regionNames
  @description('Full name of the customer or organization.')
  @maxLength(12)
  organization: string
  @description('Abbreviation of the organization or customer name.')
  @maxLength(4)
  organizationAbbreviation: string
  creator: string
}
