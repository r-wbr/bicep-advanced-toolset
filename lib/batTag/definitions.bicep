import { batDefinitions } from '../batShared/definitions.bicep'

@export()
type sharedParameters = {
  location: batDefinitions.regionName
  @maxLength(12)
  organization: string
  @maxLength(4)
  organizationAbbreviation: string
  creator: string
}

@export()
type genericTagSet = {
    ApplicationName: string
    BusinessCriticality: batDefinitions.businessCriticality
    CostCenter: string
    Creator: string
    DataClassification: batDefinitions.dataClassification
    DeploymentDate: string
    Environment: batDefinitions.environment
    Owner: string
  }

@export()
type virtualMachineTagSet = {
    ApplicationName: string
    BusinessCriticality: batDefinitions.businessCriticality
    CostCenter: string
    Creator: string
    DataClassification: batDefinitions.dataClassification
    DeploymentDate: string
    Environment: batDefinitions.environment
    Owner: string
    Backup: bool
    Monitoring: bool
  }
