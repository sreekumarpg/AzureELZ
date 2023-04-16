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


| Order  |  Module | Description  | Link |
| ------------ | ------------ | ------------ |------------ |
|1   | Management Groups  | Configures the management group hierarchy to support Azure Landing Zone reference implementation 
|2   |Custom Policy Definitions   | Configures Custom Policy Definitions at the organization management group. 
| 3  |  Logging & Sentinel | Configures a centrally managed Log Analytics Workspace, Automation Account and Sentinel in the Logging subscription. 
|4   | Landing Zone  |Creates Hub networking infrastructure with Azure Firewall to support Hub & Spoke network topology in the Connectivity subscription.Creates Spoke networking infrastructure with Virtual Network Peering to support Hub & Spoke network topology. Spoke subscriptions are used for deploying construction sets and workloads.  
