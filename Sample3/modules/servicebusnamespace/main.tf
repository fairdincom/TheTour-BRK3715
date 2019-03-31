provider "azurerm" {
  version = "=1.23.0"
}

locals {
  name                  = "${var.name}"
  location              = "${var.location}"
  resource_group        = "${var.resource_group}"
  sku                   = "Standard"
  tags                  = "${merge( 
                          map(
                            "service", "demo",
                            "session", "BRK3715"
                          ),
                          "${var.tags}"
                        )}"
}


resource "azurerm_servicebus_namespace" "sservicebusnamespace" {
  name                  = "${local.name}"
  location              = "${local.location}"
  resource_group_name   = "${local.resource_group}"
  sku                   = "${local.sku}"

  tags                  = "${local.tags}"
}