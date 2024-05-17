# Guidelines for resource organization
The naming of all objects follows the guidelines defined in this section. Each directory object, resource container, and resource object is identified by a predefined prefix. The prefix is followed by several sections divided by a hyphen. The naming is always done in English and in lowercase.

## Resource container
Resource containers are subscriptions or resource groups. Resource containers of type resource group use the prefix 'rg'. Subscription resource containers use the 'sub' prefix.

> [!NOTE]  
> The creation of a new resource group should only be allowed if all enforced tags exist on the resource group during deployment!

## Resource groups
Resource containers of type resource group use the {Prefix} 'rg'.
1. The name of a resource group is composed of the affixes {CustomerId}?, {Prefix}, {Name}, {Region}, {Environment}?, {Suffix}? in this order. Name sections are divided by hyphens.
2. Resource groups always need a unambiguous, unique name.
3. The uniqueness of the name is represented by the section {Suffix}, or {Name}.
4. The name can be exntended with the {CustomerId} affix, which includes a appreviation of the customer name. These extension is optional.
5. The environment in which the resources are located can be included in the name with the affix {Environment}. These affix is optional.
6. The {Suffix} affix can add additional information if this resource group relates to specific services, like Azure Kubernetes Service or Azure Backup.
7. If the deployment of multiple iterations is needed, the {Suffix} is used to define iterations. A sequential number is used to determine the individual iterations, starting with '001'.

📌 *The resource group 'rg-cloudcat-euw-001' in the corp landing zone is located in the region 'westeurope' and the first iteration of the 'cloudcat' application resource group.*

📌 *The resource group 'rg-cloudcat-euw-dev' in the corp landing zone is located in the region 'westeurope' and no iterations are needed. This name contains the environment to which this resource group is assigned.*

📌 *The resource group 'foo-rg-cloudcat-euw-001' in the corp landing zone is located in the region 'westeurope' and the first iteration of the 'cloudcat' application resource group. These name includes a appreviation of the customer 'FooBar Inc.' in the {Prefix} affix.*

> [!CAUTION]  
> The {Suffix} is needed as an exception identifier for automatically created resource groups! Not including these values in the {Suffix} could provoke issues when enforcing tags on resource groups. The values of must be included in the Azure policy enforcing the existence of tags!

When deploying Azure Kubernetes Service use the following values on the {Suffix} affix:  
- Cluster resource group: 'akscluster' 
- Node resource group: 'aksnode'

When deploying Azure Backup use the following values on the {Suffix} affix:  
- Backup resource group: 'azbackup'

## Subscriptions
Resource containers of type subscription use the {Prefix} 'sub'.
1. The name of a subscription is composed of the affixes {CustomerId}?, {Prefix}, {Name}, {Suffix}? in this order. Name sections are divided by hyphens.
2. Subscriptions always require a unambiguous, unique name.
3. The uniqueness of the name is represented by the section {Name}.
4. Subscriptions can have the {Suffix} section, regardless of the destination zone in which they are located.
5. The section {Suffix} consists of three digits and can be used as a simple sequential number or decimal classification system.
6. In order to facilitate automated provisioning, the section may be replaced by a unique, automatically generated ID.
7. The {Zone} affix of a subscription must be changed if it is moved to a different landing zone. This does not apply to inactive subscriptions that are moved to the Decommissioned Subscriptions management group.
8. The {Zone} descripes the subscription environment. Allowed values are 'Online', 'Corp', 'Connectivity', 'management' or 'Identity'.

## Resources
For resources, an abbreviated prefix is formed based on their resource type. These prefixes are listed in a separate file. The formation of the name for a resource must be carried out according to the following guidelines:
1. The name of a resource is composed of the sections {Prefix}, {Name}, {Zone}, {Region}, {Suffix} in this order.
2. Resources always need a unambiguous, unique name.
3. The uniqueness of the name is represented by the section {Name}, or {Suffix}.
4. If a sequential number is used in {Suffix} it consists of three digits and always begins with 001.
5. The {Name} and {Suffix} sections may be replaced by a reference to a parent resource, whereby sections are replaced with those of the parent resource.
6. The {Name} section of a resource can be omitted if the resource performs a shared function in a landing zone and the naming of the resource type is consistent.

📌 *The network security group 'nsg-adfs-euw' refers to the virtual machines 'vm-adfs-001' and 'vm-adfs-002' like the application security group 'asg-adfs-westeurope'.*

📌 *The names of the virtual network in the 'cloudcat' subscription continues with 'vnet-cloudcat-euw-001', 'vnet-cloudcat-euw-002' and 'vnet-cloudcat-eun-001'. However, the virtual network 'vnet-adfs-euw' can be recognized as the network of a specific application.*

In certain cases, this directive may be derogated from if:
1. Azure's internal name restriction doesn't allow a compliant name.
2. These are resource types that are children of a resource.
3. These resources were automatically created by a platform service.
4. The resource has a predefined name.
5. The renaming cannot be implemented without considerable effort due to possible failures.

📌 *The virtual machine that provides the AD FS service e cannot be mapped with the name 'vm-adfs-euw-prod-001' because there is a 15-character limit for Windows VMs. Accordingly, the name should be abbreviated to the most necessary information, resulting in the name 'vm-adfs-001'. For the sake of consistency, this abbreviation should also apply to Linux VMs, although they have a 64-character limit.*

📌 *The private DNS zone 'privatelink.file.core.windows.net' cannot have a different name because the name of the resource is the same as the DNS name of the zone.*

> [!TIP]
> Deviation from the resource naming policy should be consistent across the environment!.

## Directory objects
Directory objects include management groups, security groups, and accounts. The prefix for all management groups is 'mg', prefixes for security groups are derived from the intended use. The use of security groups under this concept includes role-based access control (rbac), management tasks (mgnt), control (ctrl), and license distribution. The prefix of a user account is derived from the function of the principal; where the prefix 'adm' is appended to a user principal with administrative tasks. User principals, which correspond to a physical user with non-privileged access permissions, are only represented by the name or user ID. Service principals begin with the prefix 'svc'.

### Management groups
1. The name of an administrative group consists of the sections {Prefix} and {Name}, {Suffix}.
2. The {Name} section basically refers to the parent area, such as Organization, Platform Landing Zones, Application Landing Zones, or Feature Zones (Sandbox, Inactive).
3. In order to improve readability, the display names of management groups may be displayed with spaces and upper and lower case letters.

📌 *The ID of the Platform Landing Zone management group is mg-platform, but the Name attribute contains the 'Platform Services' value.*

### Security groups
1. The name of a security group is composed of the sections {Region} (Optional), {Prefix}, {Function}, {Target}, in this order.
2. The {Region} section consists of a two-digit country code and only needs to be set if a distinction by region is necessary.
3. To improve readability, the display names of security groups may be displayed with upper and lower case letters.

📌 *The mail nickname attribute of the security group is 'rbac-azuread-globalreader' but the display name is 'RBAC-AzureAD-GlobalReader'.*

### Accounts
1. The name of an account is the same as the spelling of a user principal name and is {Prefix}, {Name}, {Domain}.
2. By default, the {Name} section is mapped with the first name and last name, divided by a dot.
3. The {Prefix} section is separated from the {Name} section with an underscore.
4. In the case of a Service account, the {Name} section is replaced by a shorthand identifier of the Service.
5. The {Name} section may be replaced by a unique, pseudonymized ID.

📌 *The user principal name of John Doe's Everyday Tasks account at Contoso is 'john.doe@contoso.com'. The user principal name of his admin account is 'adm_john.doe@contoso.com'.*

📌 *The user principal name of a user account that is used as the service principal is prefixed with 'svc'. The full name is 'svc_example@contoso.com'.*

## Tags
Metadata from resource containers or resources is mapped via tags. The setting of tags is necessary because they are used for automated processes.
The following guidelines apply to tagging:
1. Tags at the resource container level are set during creation and the content of the key value is enforced.
2. Setting tags on resources is done by inheriting the tags of the parent resource container.
3. There is a general exception for resources that do not support tags.

### Resource group tags
By default, the following tags are set at the resource group level:
| Tag | Description | Enforced |
| - | - | - |
| ApplicationName | Name of the application, service or workload to which the resource is associated. | Yes |
| Environment | Lifecycle or environment of this application, workload or service. | Yes |
| Owner | Name of the person or department who is responsible for the application, workload or service. | Yes |
| Creator | User principal name of the person performing the deployment. | Yes |
| BusinessCriticality | Business criticality of this application, workload or service. (Disaster recovery)  | Yes |
| DataClassification | Classification of the data processed in the application, workload or service. | Yes |
| ServiceClass | Agreement on the service level of that application, workload, or service. | No |
| Project | Name of the project to which the application belongs. | No |
| DeploymentDate | Date on which this resource or resource group was deployed. | Yes |

> [!TIP]
> Values can be empty at deployment, but should be filled if known. Creation of additional, department- or service-related tags are allowed..

### Subscription tags
By default, the following tags are set at the subscription level:
| Tag | Description | Enforced |
| - | - | - |
| BusinessOwner | Head of the department to which the subscription belongs. | No |
| BusinessUnit | Department to which the subscription belongs. | No |
| CostCenter | Accounting cost center associated with this subscription. | No |

### Resource tags
Policies will inherit tags to resources from the resource group. For policies that inherit tags or force the exixstence of tags when creating resources, 'Indexed' instead of 'All' mode is used. An indexed policy is applied only from resources that support regions and tags. This avoids problems caused by enforcement.