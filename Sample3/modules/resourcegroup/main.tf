provider "azurerm" {
  version       = "=1.23.0"
}

locals {
  name          = "${var.name}"
  location      = "${var.location}"
  tags          = "${merge( 
                    map(
                      "service", "demo",
                      "session", "BRK3715"
                    ),
                    "${var.tags}"
                  )}"
}

resource "azurerm_resource_group" "resourcegroup" {
  name          = "${local.name}"
  location      = "${local.location}"
  tags          = "${local.tags}"
}