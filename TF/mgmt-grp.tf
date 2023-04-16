
data "azurerm_management_group" "Parent" {
 name = var.Top_level_Mgmt
}

resource "azurerm_management_group" "Platform" {
 name = "platform"
 display_name = "Platform"
 parent_management_group_id = data.azurerm_management_group.Parent.id
}

resource "azurerm_management_group" "Landingzone" {
 name = "landingzone"
 display_name = "LandingZone"
 parent_management_group_id = data.azurerm_management_group.Parent.id
}

resource "azurerm_management_group" "Log" {
 name = "Log"
 display_name = "Log"
 parent_management_group_id = azurerm_management_group.Platform.id
}

resource "azurerm_management_group" "Production" {
 name = "Production"
 display_name = "Production"
 parent_management_group_id = azurerm_management_group.Landingzone.id
}

resource "azurerm_management_group" "NSP" {
 name = "NSP"
 display_name = "NSP"
 parent_management_group_id = azurerm_management_group.Landingzone.id
}






# # Creating of Top level management is manual process becoz it is for creating azure policies
# # resource "azurerm_management_group" "Top_level_Mgmt" {
# #  name = var.Top_level_Mgmt
# #  display_name = var.Top_level_Mgmt
# #  parent_management_group_id = null
# # }

# resource "azurerm_management_group" "Platform" {
#  name = "Platform"
#  display_name = "Platform"
#  parent_management_group_id = var.Top_level_Mgmt
# }

# resource "azurerm_management_group" "LandingZone" {
#  name = "LandingZone"
#  display_name= "LandingZone"
#  parent_management_group_id = azurerm_management_group.Top_level_Mgmt.id
# }

# resource "azurerm_management_group" "Log" {
#  name = "Log"
#  display_name = "Log"
#  parent_management_group_id = azurerm_management_group.Platform.id
# }

# resource "azurerm_management_group" "Production" {
#  name = "Production"
#  display_name = "Production"
#  parent_management_group_id = azurerm_management_group.LandingZone.id
# }

# resource "azurerm_management_group" "NSP" {
#  name = "NSP"
#  display_name = "NSP"
#  parent_management_group_id = azurerm_management_group.LandingZone.id
# }
