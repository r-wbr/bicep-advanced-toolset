# Bicep Advanced Toolset (BAT)
![Static Badge](https://img.shields.io/badge/Version-2.1.3-green) ![Static Badge](https://img.shields.io/badge/Bicep-0.30.23-blue)

![logo](/img/logo256.png)

# Description

The **Bicep Advanced Toolset (BAT)** provides a solution to simplify the creation and configuration of resources before a single template is written. The toolset consist of user defined functions, data types and library files, separated into archetypes. This helps implementing a consistent naming and tagging convention which can be fully integrated in every template.

> [!CAUTION]
> For the toolset to function, experimental features must be activated in the bicep config file!

# Features

- Name generation for resources with the possibility to generate default, special and unique names.
- Integrated name patterns for different requirements:
  - Default 1: Prefix-Name-Region-Suffix
  - Default 2: Prefix-Name-Region-Environment-Suffix
  - Extended 1: Prefix-Name-Region-Suffix
  - Extended 2: Prefix-Name-Region-Environment-Suffix
- Automatic selection of role definitions ids, region and resource type abbreviations.
- Includes a set of tutorials, examples and more!

# How it works

The appropriate functions and data types must first be imported into the template. Functions for direct usage in the template start with `new` or `get`, whereby helper functions start with `set` or `select` and dont need to be imported.

Instructions how to use each archetype are listed separately:

- [Resource](/docs/archetypeResource.md)
- [Location](/docs/archetypeLocation.md)
- [Deployment](/docs/archetypeDeployment.md)
- [Authorization](/docs/archetypeAuthorization.md)

# Miscellaneous

Create role and policy assignments with automated identity selection: [💪 Template](/src/authorization/main.bicep)