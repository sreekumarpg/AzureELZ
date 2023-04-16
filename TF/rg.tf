# Resource group for Log subscription
resource "azurerm_resource_group" "log" {
  provider = azurerm.Log
  name     = lower("rg-${lower(var.Top_level_Mgmt)}-log-01")
  location = var.location
  tags = {
    "Subscription" = var.Subscriptions[0]
  }
  depends_on = [
    azurerm_management_group_subscription_association.subscription_to_log
  ]
}

# Resource group for Production subscription
resource "azurerm_resource_group" "production" {
  provider = azurerm.Production
  name     = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01") 
  location = var.location
  tags = {
    "Subscription" = var.Subscriptions[1]
  }
  depends_on = [
    azurerm_management_group_subscription_association.subscription_to_production
  ]
}

# Resource group for NSP subscription
resource "azurerm_resource_group" "nsp" {
  provider = azurerm.NSP
  name     = lower("rg-${lower(var.Top_level_Mgmt)}-nsp-01")
  location = var.location
  tags = {
    "Subscription" = var.Subscriptions[2]
  }
  depends_on = [
    azurerm_management_group_subscription_association.subscription_to_nsp
  ]
}