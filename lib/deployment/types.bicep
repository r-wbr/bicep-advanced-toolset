@export()
type namePattern = 'default1' | 'default2' | 'extended1' | 'extended2'

@export()
type environment = 'Production' | 'Staging' | 'Test' | 'Development'

@export()
type businessCriticality = 'Unsupported' | 'Low' | 'Medium' | 'High' | 'Unit critical' | 'Mission critical'

@export()
type dataClassification = 'Public' | 'Company' | 'Confidential' | 'Highly confidential'
