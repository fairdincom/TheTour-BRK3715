variable "name" {
  type          = "string"
  description   = "App service plan name"
}

variable "resource_group" {
  type          = "string"
  description   = "Resource group name"
}
variable "location" {
  type          = "string"
  description   = "App service plan location"
  default       = "koreacentral"
}

variable "tags" {
  type          = "map"
  description   = "Tags for App service plan"
}