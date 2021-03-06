variable "resource_name" {
  type              = "string"
  description       = "The name of the Azure resource group consul will be deployed into. This RG should already exist"
}

variable "resource_location" {
  type              = "string"
  description       = ""
  default           = "koreacentral"
}

variable "resource_location_code" {
  type              = "string"
  description       = "Resource location code"
  default           = "koc"
}

variable "resource_environment" {
  type              = "string"
  description       = "Resource Enviornment"
  default           = "development"
}

variable "resource_environment_code" {
  type              = "string"
  description       = "Resource Enviornment code"
  default           = "dev"
}

variable "resource_tags" {
  type              = "map"
  description       = ""
  default = {
    enviroment      = "development"
  }
}

locals {
  name                    = "${var.resource_name}"
  location                = "${var.resource_location}"
  resource_long_name      = "{0}-${var.resource_name}-${var.resource_environment_code}-${var.resource_location_code}"
  resource_short_name     = "${replace(local.resource_long_name, "-", "")}"
  tags = {
    enviroment            = "${var.resource_environment}"
  }
}