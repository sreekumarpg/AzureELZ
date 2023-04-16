
# data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
#   name                = lower("law-${lower(var.Top_level_Mgmt)}-log-01")
#   resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
# }

data "azurerm_user_assigned_identity" "managed_identity" {
  provider            = azurerm.Log
  name                = "uami-azpolicy-log-01"
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
  depends_on = [
    azurerm_resource_group.log,
    azurerm_user_assigned_identity.managed_identity
  ]
}

#====================================================================================================================#
#====================================================================================================================#

resource "azurerm_management_group_policy_assignment" "DeployDiagnosticsLogAnalytics" { 
  name                 = "Diag to LogAnalytics"
  location             = var.location
  policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
  management_group_id  = data.azurerm_management_group.Parent.id
  parameters = jsonencode({
    "logAnalytics" = {
      "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
    }
  })
  identity {
    type         = "UserAssigned"
    identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
  }
  depends_on = [
    azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
    azurerm_log_analytics_workspace.log_law
  ]
}

#====================================================================================================================#
#====================================================================================================================#

resource "azurerm_management_group_policy_assignment" "azsecuritybenchmark" { 
  name                 = "Azure Security Benchmark"
  location             = var.location
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "effectScope" = {
#       "ManagementGroup" = data.azurerm_management_group.Parent
#     }
#   })
  identity {
    type = "UserAssigned"
    identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
  }
  depends_on = [
    azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
    azurerm_log_analytics_workspace.log_law
  ]
}

#====================================================================================================================#
#====================================================================================================================#

resource "azurerm_management_group_policy_assignment" "AzmonitorforVms" { 
  name                 = "Azure Monitor for Vms"
  location             = var.location
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/9dffaf29-5905-4145-883c-957eb442c226"  #"/providers/Microsoft.Authorization/policySetDefinitions/1f9b0c83-b4fa-4585-a686-72b74aeabcfd"
  management_group_id  = data.azurerm_management_group.Parent.id
  parameters = jsonencode({
  "logAnalyticsWorkspace" = {
    "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
  },
  "bringYourOwnUserAssignedManagedIdentity" = {
    "value" = false
  }
  # "userAssignedManagedIdentityName" = {
  #     "value" = "uami-azpolicy-log-01"
  #   },
  #   "userAssignedManagedIdentityResourceGroup" = {
  #     "value" = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
})
  identity {
    type         = "UserAssigned"
    identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
  }
  depends_on = [
    azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
    azurerm_log_analytics_workspace.log_law
  ]
  
}



# resource "azurerm_management_group_policy_assignment" "AzmonitorforVms" { 
#   name                 = "Azure Monitor for Vms"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/9dffaf29-5905-4145-883c-957eb442c226"  #"/providers/Microsoft.Authorization/policySetDefinitions/1f9b0c83-b4fa-4585-a686-72b74aeabcfd"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalyticsWorkspace" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     },
#     "dataCollectionRuleName" = {
#       "value" = "ama-vmi-default"
#     },
#     "enableProcessesAndDependencies" = {
#       "value" = false
#     },
#     "bringYourOwnUserAssignedManagedIdentity" = {
#       "value" = false
#     },
#     "userAssignedManagedIdentityName" = {
#       "value" = ""
#     },
#     "userAssignedManagedIdentityResourceGroup" = {
#       "value" = ""
#     },
#     "effect" = {
#       "value" = "DeployIfNotExists"
#     },
#     "supportedWindowsOsVmImages" = {
#       "value" = []
#     },
#     "supportedLinuxOsVmImages" = {
#       "value" = []
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }

# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }
# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }
# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }
# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }
# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }
# #====================================================================================================================#
# #====================================================================================================================#

# resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" { 
#   name                 = "DepDiagnoLogAnalytics"
#   location             = var.location
#   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
#   management_group_id  = data.azurerm_management_group.Parent.id
#   parameters = jsonencode({
#     "logAnalytics" = {
#       "value" = "/subscriptions/64bbfe02-e37c-41e9-8cff-f2bb7ca6ccbf/resourceGroups/${lower("rg-${lower(var.Top_level_Mgmt)}-log-01")}/providers/Microsoft.OperationalInsights/workspaces/law-${lower(var.Top_level_Mgmt)}-log-01"
#     }
#   })
#   identity {
#     type         = "UserAssigned"
#     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
#   }
#   depends_on = [
#     azurerm_role_assignment.Contributor_on_toplevelmgmntgrp,
#     azurerm_log_analytics_workspace.log_law
#   ]
# }


# # variable "policy_definitions" {
# #   type = map(object({
# #     policy_set_definition_id = string
# #     parameters               = map(string)
# #   }))
# #   default = {
# #     "policy1" = {
# #       policy_set_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Policy1"
# #       parameters               = {
# #         "param1" = "value1"
# #         "param2" = "value2"
# #       }
# #     },
# #     "policy2" = {
# #       policy_set_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Policy2"
# #       parameters               = {
# #         "param1" = "value1"
# #         "param2" = "value2"
# #       }
# #     },
# #     # add more policies here as needed
# #   }
# # }

# # resource "azurerm_management_group_policy_assignment" "mgmt_group_policy_assignment" {
# #   for_each = var.policy_definitions

# #   name                 = "DepDiagnoLogAnalytics-${each.key}"
# #   location             = var.location
# #   policy_definition_id = each.value.policy_set_definition_id
# #   management_group_id  = data.azurerm_management_group.Parent.id
# #   parameters           = jsonencode(each.value.parameters)
# #   identity {
# #     type         = "UserAssigned"
# #     identity_ids = ["${data.azurerm_user_assigned_identity.managed_identity.id}"]
# #   }
# # }




# # # Assign the policy initiative to the management group
# # resource "azurerm_policy_assignment" "diagnostics_settings" {
# #   name                 = "diagnostics-settings"
# #   display_name         = "Configure diagnostics settings for virtual machines"
# #   description          = "This policy sets diagnostic settings for virtual machines to send logs to a specified Log Analytics workspace."
# #   policy_definition_id = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}/providers/Microsoft.Authorization/policySetDefinitions/Deploy-Diagnostics-LogAnalytics"
# #   scope                = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}"
# #   parameters = jsonencode({
# #     "logAnalyticsWorkspaceId" = {
# #       value = "${data.azurerm_log_analytics_workspace.log_analytics_workspace.id}"
# #     }
# #   })
# #   identity {
# #     type = "UserAssigned"
# #     identity_ids = [
# #       "${data.azurerm_user_assigned_identity.managed_identity.id}"
# #     ]
# #   }
# #   depends_on = [
# #     data.azurerm_log_analytics_workspace.log_analytics_workspace,
# #     data.azurerm_user_assigned_identity.managed_identity
# #   ]
# # }


