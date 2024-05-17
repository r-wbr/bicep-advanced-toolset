# Examples
Output generation in 'main.bicep'.
```bicep
output names object = {
  default1: {
    generic: lib.newResourceName(testResourceName, 'default1')
    special: lib.newSpecialResourceName(testResourceName, 'default1')
  }
  default2: {
    generic: lib.newResourceName(testResourceName, 'default2')
    special: lib.newSpecialResourceName(testResourceName, 'default2')
  }
  extended1: {
    generic: lib.newResourceName(testResourceName, 'extended1')
    special: lib.newSpecialResourceName(testResourceName, 'extended1')
  }
  extended2: {
    generic: lib.newResourceName(testResourceName, 'extended2')
    special: lib.newSpecialResourceName(testResourceName, 'extended2')
  }
  policy1: {
    policyDefinition: lib.newPolicyDefinitionName('AzurePolicyDisplayName1')
    policyAssignment: lib.newPolicyAssignmentName('AzurePolicyDisplayName1')
  }
  policy2: {
    policyDefinition: lib.newPolicyDefinitionName('AzurePolicyDisplayName2')
    policyAssignment: lib.newPolicyAssignmentName('AzurePolicyDisplayName2')
  }
}
```
***
Output values after deployment.
```json
{
    "default1": {
        "generic": "rg-bcptls-euw-001",
        "special": "rgbcptlseuw001"
    },
    "default2": {
        "generic": "rg-bcptls-euw-dev-001",
        "special": "rgbcptlseuwdev001"
    },
    "extended1": {
        "generic": "foo-rg-bcptls-euw-001",
        "special": "foorgbcptlseuw001"
    },
    "extended2": {
        "generic": "foo-rg-bcptls-euw-dev-001",
        "special": "foorgbcptlseuwdev001"
    },
    "policy1": {
        "policyDefinition": "pd-7238a963-b977-535c",
        "policyAssignment": "pa-7238a963-b977-535c"
    },
    "policy2": {
        "policyDefinition": "pd-dd30698c-56cf-54a2",
        "policyAssignment": "pa-dd30698c-56cf-54a2"
    }
}
```
***