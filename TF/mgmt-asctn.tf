# Move Subscription to log mgmt Group
resource "azurerm_management_group_subscription_association" "subscription_to_log" {
 management_group_id = azurerm_management_group.Log.id
 subscription_id = var.Log_Subscription
 depends_on = [
   azurerm_management_group.Log
 ]
}

# Move Subscription to prod mgmt Group
resource "azurerm_management_group_subscription_association" "subscription_to_production" {
 management_group_id = azurerm_management_group.Production.id
 subscription_id = var.Prod_Subscription
 depends_on = [
   azurerm_management_group.Production
 ]
}

# Move Subscription to nsp Group
resource "azurerm_management_group_subscription_association" "subscription_to_nsp" {
 management_group_id = azurerm_management_group.NSP.id
 subscription_id = var.NSP_Subscription
 depends_on = [
   azurerm_management_group.NSP
 ]
}