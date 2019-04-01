terraform {
  backend "azurerm" {
    storage_account_name  = "storage_account_name"
    container_name        = "container_name"
    key                   = "brk3715.terraform.tfstate"
    access_key            = "access_key"
  }
}

provider "azurerm" {
  version = "=1.23.0"
}

module "resourcegroupsample" {
  source   = "./modules/resourcegroup"

  name     = "${local.name}"
  location = "${local.location}"
  tags     = "${local.tags}"
}

module "storageaccountsample" {
  source          = "./modules/storageaccount"

  name            = "${replace(local.resource_short_name, "{0}", "st")}"
  resource_group  = "${module.resourcegroupsample.name}"
  location        = "${local.location}"
  tags            = "${local.tags}"
}

module "consumptionplansample" {
  source          = "./modules/consumptionplan"

  name            = "${replace(local.resource_long_name, "{0}", "csplan")}"
  resource_group  = "${module.resourcegroupsample.name}"
  location        = "${local.location}"
  tags            = "${local.tags}"
}

module "functipnappsample" {
  source                    = "./modules/functionapp"

  name                      = "${replace(local.resource_long_name, "{0}", "fs")}"
  location                  = "${local.location}"
  resource_group            = "${module.resourcegroupsample.name}"
  app_service_plan_id       = "${module.consumptionplansample.id}"
  storage_connection_string = "${module.storageaccountsample.connection_string}"
  tags                      = "${local.tags}"
}

module "servicebusnamespacesample" {
  source              = "./modules/servicebusnamespace"

  name                = "${replace(local.resource_long_name, "{0}", "sbname")}"
  location            = "${local.location}"
  resource_group      = "${module.resourcegroupsample.name}"
  tags                = "${local.tags}"
}

module "servicebustopicsample" {
  source              = "./modules/servicebustopic"

  name                = "${replace(local.resource_long_name, "{0}", "sbtoipc")}"
  resource_group      = "${module.resourcegroupsample.name}"
  namespace_name      = "${module.servicebusnamespacesample.name}"
}