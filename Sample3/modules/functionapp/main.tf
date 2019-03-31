provider "azurerm" {
  version = "=1.23.0"
}

locals {
  name                              = "${var.name}"
  location                          = "${var.location}"
  resource_group                    = "${var.resource_group}"
  app_service_plan_id               = "${var.app_service_plan_id}"
  storage_connection_string         = "${var.storage_connection_string}"
  tags                              = "${merge( 
                                        map(
                                          "service", "demo",
                                          "session", "BRK3715"
                                        ),
                                        "${var.tags}"
                                      )}"
}

resource "azurerm_function_app" "funcrionapp" {
  name                              = "${local.name}"
  location                          = "${local.location}"
  resource_group_name               = "${local.resource_group}"

  app_service_plan_id               = "${local.app_service_plan_id}"
  storage_connection_string         = "${local.storage_connection_string}"
  https_only                        = true
  version                           = "~2"

  site_config {
      use_32_bit_worker_process     = false
  }

  app_settings {
      AzureWebJobsSecretStorageType = "Blob"
      FUNCTIONS_APP_EDIR_MODE       = "ReadOnly"
      DUNCTIONS_WORKER_RUNTIME      = "dotnet"
  }

  tags                              = "${local.tags}"
}