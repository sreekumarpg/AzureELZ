# Create a virtual network within the resource group
resource "azurerm_virtual_network" "Production_Vnet" {
  name                = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  resource_group_name = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  location            = var.location
  address_space       = var.Prod_Vnet_cidr
  depends_on = [
    azurerm_resource_group.production
  ]
}

# Create a public subnets within the vnet and rg
resource "azurerm_subnet" "Production_Subnet_1" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-identity-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet1_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet
  ]
}

resource "azurerm_subnet" "Production_Subnet_2" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-shared-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet2_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet,
    azurerm_subnet.Production_Subnet_1
  ]
}

resource "azurerm_subnet" "Production_Subnet_3" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-lb-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet3_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet,
    azurerm_subnet.Production_Subnet_2
  ]
}

resource "azurerm_subnet" "Production_Subnet_4" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-web-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet4_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet,
    azurerm_subnet.Production_Subnet_3
  ]
}

resource "azurerm_subnet" "Production_Subnet_5" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-app1-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet5_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet,
    azurerm_subnet.Production_Subnet_4
  ]
}

resource "azurerm_subnet" "Production_Subnet_6" {
  name                 = lower("snet-${lower(var.Top_level_Mgmt)}-prod-db-01")
  resource_group_name  = lower("rg-${lower(var.Top_level_Mgmt)}-prod-01")
  virtual_network_name = lower("vnet-${lower(var.Top_level_Mgmt)}-prod-01")
  address_prefixes     = var.Prod_Subnet6_cidr
  depends_on = [
    azurerm_virtual_network.Production_Vnet,
    azurerm_subnet.Production_Subnet_5
  ]
}

















# # Virtual Network Creation
# resource "azurerm_virtual_network" "production" {
#   name                = var.production_vnet
#   address_space       = [var.production_address_prefix]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.production.name

# #Subnets Creation

#  subnet {
#     name           = var.production_subnet1
#     address_prefix = var.production_subnet1_prefix
#     security_group = azurerm_network_security_group.production_subnet1.id
#   }

#   subnet {
#     name           = var.production_subnet2
#     address_prefix = var.production_subnet2_prefix
#     security_group = azurerm_network_security_group.production_subnet2.id
#   }

#   subnet {
#     name           = var.production_subnet3
#     address_prefix = var.production_subnet3_prefix
#     security_group = azurerm_network_security_group.production_subnet3.id
#   }

#   subnet {
#     name           = var.production_subnet4
#     address_prefix = var.production_subnet4_prefix
#     security_group = azurerm_network_security_group.production_subnet4.id
#   }

#   subnet {
#     name           = var.production_subnet5
#     address_prefix = var.production_subnet5_prefix
#     security_group = azurerm_network_security_group.production_subnet5.id
#   }

#   subnet {
#     name           = var.production_subnet6
#     address_prefix = var.production_subnet6_prefix
#     security_group = azurerm_network_security_group.production_subnet6.id
#   }
# }

# # Network Security Group Creation
# resource "azurerm_network_security_group" "production_subnet1" {
#   name                = var.production_subnet1_nsg
#   location            = var.location
#   resource_group_name = azurerm_resource_group.production.name

#   security_rule {
#     name                       = "Inbound_Any_Temp"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_address_prefix      = "*"
#     source_port_range          = "*"
#     destination_address_prefix = "*"
#     destination_port_range     = "*"
#   }
# }

# resource "azurerm_network_security_group" "production_subnet2" {
#   name                = var.production_subnet2_nsg
#   location            = var.location
#   resource_group_name = azurerm_resource_group.production.name

#   security_rule {
#     name                       = "Inbound_Any_Temp
