provider "azurerm" {
  version = "=1.23.0"
}

locals {
  name                = "${var.name}"
  resource_group      = "${var.resource_group}"
  namespace_name      = "${var.namespace_name}"
}

resource "azurerm_servicebus_topic" "servicebustopic" {
  name                = "${local.name}"
  resource_group_name = "${local.resource_group}"
  namespace_name      = "${local.namespace_name}"

  enable_partitioning = true
}