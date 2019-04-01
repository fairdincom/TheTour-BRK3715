provider "azurerm" {
  version = "=1.23.0"
}

variable "resource_name" {
  type          = "string"
  description   = "resource group name"
}

variable "resource_location" {
  type          = "string"
  description   = "resource location"
  default       = "southeastasia"  
}


locals {
  location                = "${var.resource_location}"
  resource_long_name      = "${var.resource_name}-tfstate"
  resource_short_name     = "${replace(local.resource_long_name, "-", "")}"

}

resource "azurerm_resource_group" "tstate" {
  name     = "${local.resource_long_name}"
  location = "${local.location}"
}

resource "azurerm_storage_account" "tstate" {
  name                     = "${local.resource_short_name}"
  resource_group_name      = "${local.resource_long_name}"
  location                 = "${local.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_blob_encryption   = true

  tags = {
    environment = "tstate"
  }
}

resource "azurerm_storage_container" "tstate" {
  name                  = "tstate"
  resource_group_name   = "${local.resource_long_name}"
  storage_account_name  = "${azurerm_storage_account.tstate.name}"
  container_access_type = "private"
}

resource "azurerm_management_lock" "resource-group-level" {
  name        = "resource-group-level"
  scope       = "${azurerm_resource_group.tstate.id}"
  lock_level  = "CanNotDelete"
  notes       = "Locked because the .tfstate file is important."
}