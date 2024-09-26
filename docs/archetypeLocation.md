# Location

The archetype **location** provides data types for consistent selection of Azure regions and a function to generate abbreviations, based on pre-defined values in the library file.

1. From the target template, import the archetypes.

> [!TIP]
> The data type `regionName` can be edited to provide only a preset of regions.

```bicep
@description('Import library for location archetypes.')
import { getRegionAbbreviation, regionName } from '../location/shared.bicep'
```

2. The function then selects the appropriate abbreviation from the library file.

```bicep
@description('The function provides an abbreviation for regions available in the data type.')
output regionAbbreviation string = getRegionAbbreviation('westeurope')

/* 
output regionAbbreviation = euw
*/
```