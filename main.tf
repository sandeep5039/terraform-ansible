terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.91.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

//resource group creation
resource "azurerm_resource_group" "myrg" {
  name     = "pawan"
  location = "eastus"

}

resource "azurerm_virtual_network" "v-net" {
  name                = "pawan-vnet"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "pawan-bastion-subnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "web" {
  name                 = "pawan-web-subnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = ["10.0.12.0/24"]
}

resource "azurerm_subnet" "app" {
  name                 = "pawan-app-subnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = ["10.0.13.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "pawan-db-subnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = ["10.0.14.0/24"]
}