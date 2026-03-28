terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "ranatfstate123"
    container_name       = "tfstate"
    key                  = "project4.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "project4-${terraform.workspace}-rg"
  location = var.location
}

module "network" {
  source   = "./modules/network"
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
}

module "compute" {
  source         = "./modules/compute"
  location       = var.location
  rg_name        = azurerm_resource_group.rg.name
  subnet_id      = module.network.subnet_id
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
}