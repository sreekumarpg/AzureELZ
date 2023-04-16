resource "azurerm_user_assigned_identity" "managed_identity" {
  provider            = azurerm.Log  
  name                = "uami-azpolicy-log-01"
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
  depends_on = [
    azurerm_resource_group.log
  ]
  tags = {
    "Subscription" = var.Subscriptions[0]
  }
}

resource "azurerm_role_assignment" "Contributor_on_toplevelmgmntgrp" {
  provider            = azurerm.Log  
  scope              = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}"
  role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c" # Contributor role ID
  principal_id       = azurerm_user_assigned_identity.managed_identity.principal_id
  depends_on = [
    azurerm_resource_group.log,
    azurerm_user_assigned_identity.managed_identity
  ]
}

resource "azurerm_role_assignment" "Contributor_and_UAA_on_toplevelmgmntgrp" {
  provider            = azurerm.Log  
  scope              = "/providers/Microsoft.Management/managementGroups/${var.Top_level_Mgmt}"
  role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9" # Contributor and User Access Administrator role IDs
  principal_id       = azurerm_user_assigned_identity.managed_identity.principal_id
  depends_on = [
    azurerm_resource_group.log,
    azurerm_user_assigned_identity.managed_identity
  ]
}
