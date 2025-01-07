# Bicep Advanced Toolset (BAT)
![Static Badge](https://img.shields.io/badge/Version-0.2.0-green) ![Static Badge](https://img.shields.io/badge/Bicep-0.30.23-blue)

![logo](/img/logo256.png)

# Description

The Azure community provides a variety of documents and tools to streamline the creation of consistent templates, using scripts or web apps. Unfortunately, the existing tools cannot be integrated into the template creation process without much effort. To provide an easy-to-integrate solution to this problem, I designed the **Bicep Advanced Toolset (BAT)**. This toolset aims to provide a solution to simplify the creation of Bicep templates without external tools.

# Features

- Helper functions to extract resource name, resource group name and subscription from a resource id.
- Name generator with the possibility to generate basic names for resources, or special names for storage accounts.
- Integrated name patterns for different requirements, which can be extended with custom patterns.
- Fully written in 💪 Bicep.

# Usage

Instructions how to use the name generator and extend the name patterns can be found here:
- [Name generator](/docs/nameGenerator.md)
- [Name patterns](/docs/namePatterns.md)