terraform {
  backend "azurerm" {
    storage_account_name  = "igniteseoultstate"
    container_name        = "tstate"
    key                   = "brk3715.terraform.tfstate"
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

  name            = "${replace(local.resource_short_name, "{0}", st)}"
  resource_name   = "${module.resourcegroupsample.name}"
  location        = "${local.location}"
  tags            = "${local.tags}"
}

module "consumptionplansample" {
  source          = "./modules/consumptionplan"

  name            = "${replace(local.resource_long_name, "{0}", csplan)}"
  resource_name   = "${module.resourcegroupsample.name}"
  location        = "${local.location}"
  tags            = "${local.tags}"
}

module "functipnappsample" {
  source                    = "./modules/functionapp"

  name                      = "${replace(local.resource_long_name, "{0}", fs)}"
  location                  = "${local.location}"
  resource_group_name       = "${module.resourcegroupsample.name}"
  app_service_plan_id       = "${module.consumptionplansample.id}"
  storage_connection_string = "${module.storageaccountsample.connection_string}"
}

module "servicebusnamespacesample" {
  source              = "./modules/servicebusnamespace"

  name                = "${replace(local.resource_long_name, "{0}", sbname)}"
  location            = "${local.location}"
  resource_group_name = "${module.resourcegroupsample.name}"
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

module "servicebustopicsample" {
  source              = "./modules/servicebustopic"

  name                = "${replace(local.resource_long_name, "{0}", sbtoipc)}"
  resource_group_name = "${module.resourcegroupsample.name}"
  namespace_name      = "${module.servicebusnamespacesample.name}"
  tags                = "${local.tags}"
}