variable "name" {
  type          = "string"
  description   = "function app name"
}

variable "resource_group" {
  type          = "string"
  description   = "Resource group name"
}

variable "location" {
  type          = "string"
  description   = "funcripn app location"
  default       = "koreacentral"
}

variable "app_service_plan_id" {
  type          = "string"
  description   = "app service plan id"
}

variable "storage_connection_string" {
  type          = "string"
  description   = "storage connection string"
}

variable "tags" {
  type          = "map"
  description   = "Tags for function app"
}