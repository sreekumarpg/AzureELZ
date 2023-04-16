terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.8.7"
    }
  }
}

provider "azurerm" {
 features {}
}

provider "azurerm" {
  alias           = "Log"
  subscription_id = var.Log_Subscription_id
  features {}
}

provider "azurerm" {
  alias           = "Production"
  subscription_id = var.Prod_Subscription_id 
  features {}
}

provider "azurerm" {
  alias           = "NSP"
  subscription_id = var.NSP_Subscription_id
  features {}
}