#=====================================================================================================#

#create nsg for each subnet
resource "azurerm_network_security_group" "Production_Sub_1_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-identity-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")


  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}


resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_1" {
  subnet_id                 = azurerm_subnet.Production_Subnet_1.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_1_SG.id
}

#=====================================================================================================#

resource "azurerm_network_security_group" "Production_Sub_2_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-shared-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")


  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_2" {
  subnet_id                 = azurerm_subnet.Production_Subnet_2.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_2_SG.id
}

#=====================================================================================================#

resource "azurerm_network_security_group" "Production_Sub_3_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-lb-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")


  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_3" {
  subnet_id                 = azurerm_subnet.Production_Subnet_3.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_3_SG.id
}

#=====================================================================================================#

resource "azurerm_network_security_group" "Production_Sub_4_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-web-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")

  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_4" {
  subnet_id                 = azurerm_subnet.Production_Subnet_4.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_4_SG.id
}

#=====================================================================================================#

resource "azurerm_network_security_group" "Production_Sub_5_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-app1-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")


  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_5" {
  subnet_id                 = azurerm_subnet.Production_Subnet_5.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_5_SG.id
}

#=====================================================================================================#

resource "azurerm_network_security_group" "Production_Sub_6_SG" {
  name                = lower("nsg-${lower(var.Top_level_Mgmt)}-prod-db-01")
  location            = var.location
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")


  tags = {
    "Subscription" = var.Subscriptions[1]
  }
    depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association_6" {
  subnet_id                 = azurerm_subnet.Production_Subnet_6.id   
  network_security_group_id = azurerm_network_security_group.Production_Sub_6_SG.id
}

#=====================================================================================================#