provider "azurerm" {
  version = "=1.20.0"
}

resource "azurerm_resource_group" "tstate" {
  name     = "ignite-seoul-tstate"
  location = "southeastasia"
}

resource "azurerm_storage_account" "tstate" {
  name                     = "igniteseoultstate"
  resource_group_name      = "${azurerm_resource_group.tstate.name}"
  location                 = "southeastasia"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_blob_encryption   = true

  tags = {
    environment = "tstate"
  }
}

resource "azurerm_storage_container" "tstate" {
  name                  = "tstate"
  resource_group_name   = "${azurerm_resource_group.tstate.name}"
  storage_account_name  = "${azurerm_storage_account.tstate.name}"
  container_access_type = "private"
}

resource "azurerm_management_lock" "resource-group-level" {
  name        = "resource-group-level"
  scope       = "${azurerm_resource_group.tstate.id}"
  lock_level  = "CanNotDelete"
  notes       = "Locked because the .tfstate file is important."
}