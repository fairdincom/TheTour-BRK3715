provider "azurerm" {
  version = "=1.23.0"
}

locals {
  name                      = "${var.name}"
  resource_group            = "${var.resource_group}"
  location                  = "${var.location}"
  kind                      = "StorageV2"
  tier                      = "Standard"
  replication_type          = "LRS"
  blob_encrypt              = "true"
  file_encrypt              = "true"
  https_only                = "true"
  tags                      = "${merge( 
                                map(
                                "service", "demo",
                                "session", "BRK3715"
                                ),
                                "${var.tags}"
                              )}"
}


resource "azurerm_storage_account" "storageaccount" {
  name                      = "${local.name}"
  resource_group_name       = "${local.resource_group}"
  location                  = "${local.location}"

  account_kind              = "${local.kind}"
  account_tier              = "${local.tier}"
  account_replication_type  = "${local.replication_type}"

  enable_blob_encryption    = "${local.blob_encrypt}"
  enable_file_encryption    = "${local.file_encrypt}"
  enable_https_traffic_only = "${local.https_only}"

  tags                     = "${local.tags}"
}