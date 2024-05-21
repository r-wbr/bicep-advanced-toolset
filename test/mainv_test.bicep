metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-namegen'

targetScope = 'subscription'

import * as lib from '../src/sharedv3.1.bicep'
import { newResourceName as newResourceName } from '../src/sharedv3.1.bicep'
//import { newSpecialResourceName as newSpecialResourceName } from '../src/sharedv3.1.bicep'
import { resourceName as setResourceName } from '../src/sharedv3.1.bicep'
import { resourceTags as setResourceTags } from '../src/sharedv3.1.bicep'

var foo = newResourceName('test', 'bastionHost', 'canadacentral', 'Development', 'default2')
