import { sharedDefinitions } from '../batShared/definitions.bicep'

@export()
type sharedParameters = {
  location: sharedDefinitions.regionName
  @maxLength(12)
  organization: string
  @maxLength(4)
  organizationAbbreviation: string
  creator: string
}

@export()
type genericTagSet = {
    ApplicationName: string
    BusinessCriticality: sharedDefinitions.businessCriticality
    CostCenter: string
    Creator: string
    DataClassification: sharedDefinitions.dataClassification
    DeploymentDate: string
    Environment: sharedDefinitions.environment
    Owner: string
  }

@export()
type virtualMachineTagSet = {
    ApplicationName: string
    BusinessCriticality: sharedDefinitions.businessCriticality
    CostCenter: string
    Creator: string
    DataClassification: sharedDefinitions.dataClassification
    DeploymentDate: string
    Environment: sharedDefinitions.environment
    Owner: string
    Backup: bool
    Monitoring: bool
  }

