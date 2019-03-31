provider "azurerm" {
  version = "=1.20.0"
}

resource "azurerm_resource_group" "sample" {
  name              = "ignite-seoul-sample"
  location          = "southeastasia"
  tags = {
    enviroment      = "development"
  }
}

resource "azurerm_storage_account" "sample" {
  name                     = "igniteseoulfunctionapps"
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
  name                = "ignite-seoul-functions-service-plan"
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
  name                      = "ignite-seoul-functions"
  location                  = "${azurerm_resource_group.sample.location}"
  resource_group_name       = "${azurerm_resource_group.sample.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.sample.id}"
  storage_connection_string = "${azurerm_storage_account.sample.primary_connection_string}"

  tags = {
    enviroment              = "development"
  }
}

resource "azurerm_servicebus_namespace" "sample" {
  name                = "ignite-seoul-sevicebus-namespace"
  location            = "${azurerm_resource_group.sample.location}"
  resource_group_name = "${azurerm_resource_group.sample.name}"
  sku                 = "Standard"

  tags = {
    enviroment        = "development"
  }
}

resource "azurerm_servicebus_topic" "sample" {
  name                = "ignite-sevicebus-topic"
  resource_group_name = "${azurerm_resource_group.sample.name}"
  namespace_name      = "${azurerm_servicebus_namespace.sample.name}"

  enable_partitioning = true
  
  tags = {
    enviroment        = "development"
  }
}