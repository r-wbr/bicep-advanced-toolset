using './main.bicep'

param deploymentParameters = {
  location: 'westeurope'
  creator: 'j.doe@bats.com'
  organization: 'BicepToolset'
  organizationAbbreviation: 'BAT'
}

param applicationName = 'Template Test Deployment'
