provider "azurerm" {
  version = "=1.23.0"
}

locals {
  name                  = "${var.name}"
  location              = "${var.location}"
  resource_group        = "${var.resource_group}"
  tier                  = "Dynamic"
  size                  = "Y1"
  tags                  = "${merge( 
                            map(
                              "service", "demo",
                              "session", "BRK3715"
                            ),
                            "${var.tags}"
                          )}"
}


resource "azurerm_app_service_plan" "csplan" {
  name                  = "${local.name}"
  location              = "${local.location}"
  resource_group_name   = "${local.resource_group}"

  sku {
    tier                = "${local.tier}"
    size                = "${local.size}"
  }

  tags                  = "${local.tags}"
}