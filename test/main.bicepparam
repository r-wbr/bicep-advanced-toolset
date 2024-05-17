using './main.bicep'

param deploymentParameters = {
  location: 'westeurope'
  creator: ''
  organization: 'FooBar Inc'
  customer: 'foo'
  namePattern: 'default1'
}
