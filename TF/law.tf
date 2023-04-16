resource "azurerm_log_analytics_workspace" "log_law" {
  provider            = azurerm.Log
  name                = lower("law-${lower(var.Top_level_Mgmt)}-log-01")    
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
  sku                 = "PerGB2018"
  retention_in_days   = 120
  depends_on = [
    azurerm_resource_group.log
  ]
  tags = {
    "Subscription" = var.Subscriptions[0]
  }
}