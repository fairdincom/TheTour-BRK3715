provider "azurerm" {
  version = "=1.23.0"
}

resource "azurerm_resource_group" "sample" {
  name              = "thetour-brk3715"
  location          = "koreacentral"
  tags = {
    enviroment      = "development"
  }
}

resource "azurerm_storage_account" "sample" {
  name                     = "thetourbrk3715st"
  resource_group_name      = "${azurerm_resource_group.sample.name}"
  location                 = "${azurerm_resource_group.sample.location}"
  
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"

  enable_blob_encryption    = true
  enable_file_encryption    = true
  enable_https_traffic_only = true

  tags = {
    enviroment              = "development"
  }
}

resource "azurerm_app_service_plan" "sample" {
  name                = "thetour-brk3715-cosplan"
  location            = "${azurerm_resource_group.sample.location}"
  resource_group_name = "${azurerm_resource_group.sample.name}"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = {
    enviroment        = "development"
  }
}

resource "azurerm_function_app" "sample" {
  name                      = "thetour-brk3715-fncapp"
  location                  = "${azurerm_resource_group.sample.location}"
  resource_group_name       = "${azurerm_resource_group.sample.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.sample.id}"
  storage_connection_string = "${azurerm_storage_account.sample.primary_connection_string}"

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

  tags = {
    enviroment              = "development"
  }
}

resource "azurerm_servicebus_namespace" "sample" {
  name                = "thetour-brk3715-svcbus"
  location            = "${azurerm_resource_group.sample.location}"
  resource_group_name = "${azurerm_resource_group.sample.name}"
  sku                 = "Standard"

  tags = {
    enviroment        = "development"
  }
}

resource "azurerm_servicebus_topic" "sample" {
  name                = "thetour-brk3715-svcbus-topic"
  resource_group_name = "${azurerm_resource_group.sample.name}"
  namespace_name      = "${azurerm_servicebus_namespace.sample.name}"

  enable_partitioning = true
}
