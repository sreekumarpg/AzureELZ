# Azure Enterprise Scale Landing Zone

The Enterprise-Scale architecture provides prescriptive guidance coupled with Azure best practices, and it follows design principles across the critical design areas for organizations to define their Azure architecture.

# What will be deployed?

- A scalable Management Group hierarchy aligned to core platform capabilities, allowing you to operationalize at scale using centrally managed Azure RBAC and Azure Policy where platform and workloads have clear separation.
- Azure Policies that will enable autonomy for the platform and the landing zones.
- An Azure subscription dedicated for Management and Monitoring, which enables core platform capabilities at scale using Azure Policy such as:
   - A Log Analytics workspace and an Automation account
   - Diagnostics settings for Activity Logs, VMs, and PaaS resources sent to Log Analytics
- An Azure subscription dedicated for Identity in case your organization requires to have Active Directory Domain Controllers in a dedicated subscription
- Landing zone subscriptions for Production and  connected applications and resources, including a virtual network that will be connected to the hub via VNet peering
- Azure Policies for workload connected landing zones, which include:
   - Diagnostics settings for Activity Logs, VMs, and PaaS resources sent to Log Analytics
   - Enforce VM monitoring (Windows & Linux)
   - Enforce VMSS monitoring (Windows & Linux)
   - Enforce VM backup (Windows & Linux)
   - Enforce secure access (HTTPS) to storage accounts
   - Prevent IP forwarding
   - Prevent inbound RDP from internet
   - Ensure subnets are associated with NSG
   
   # Deployment Flow?

<img width="800" alt="image" src="https://user-images.githubusercontent.com/22677711/232288516-7ad12eec-942d-4a87-bd81-193fe64acd9d.png">


## Deployment Sequence


| Order  |  Module | Description  | Method |  |
| ------------ | ------------ | ------------ |------------ |------------ |
|1   | Parent  Management Groups  | Configures parent management group which allow global policies and Azure role assignments to be applied at the directory level.  |Manual |
|2   | Custom Policy Definitions   | Configures Custom Policy Definitions and Policy initiatives at the organization management group. |ARM Template | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https%3A%2F%2Fraw.githubusercontent.com%2Fsreekumarpg%2FAzureELZ%2Fmain%2FARM%2Fpolicies.json)|
|3   | Custom Role Definitions   | Configures Custom PRole Definitions at the organization management group. |ARM Template|[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https%3A%2F%2Fraw.githubusercontent.com%2Fsreekumarpg%2FAzureELZ%2Fmain%2FARM%2FcustomRoleDefinitions.json)|
|4   | Management Group Hierarchy  | Configures the management group hierarchy to support Azure Landing Zone reference implementation  |Terraform |<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|5   | Subscription Allocation  | Organize subscriptions into management groups to efficiently manage access, policies, and compliance for those subscriptions. |Terraform |<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|6   | Resource Group | Deploy Resource Group for holding related resources for an Azure solution.. |Terraform |<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|7   |  Logging | Configures a centrally managed Log Analytics Workspace and Automation Account in the Logging subscription.Link Automation account to Log Analytics Workspace  |Terraform|<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|8   |  Managed Identity | Configures a Managed Identity in the Logging subscription for Azure Policy and Assign contributor role |Terraform|<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|9   | Landing Zone  |Creates Virtual Network and Subnets for deploying the Landing zone Workloads  |Terraform |<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|10  | Workloads  |Build Windows Server in Landing zone infrastructure  |Terraform |<img width="50" alt="image" src="https://raw.githubusercontent.com/sreekumarpg/AzureELZ/main/ARM/Terraform.jpg"/>|
|11  | Azure Bastion  |Deploy Azure Bastion to connect to a virtual machine through Azure portal  |Manual |
