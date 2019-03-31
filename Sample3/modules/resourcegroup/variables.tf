variable "name" {
  type          = "string"
  description   = "Resource group name"
}

variable "location" {
  type          = "string"
  description   = "Resource group location"
  default       = "koreacentral"
}

variable "tags" {
  type          = "map"
  description   = "Tags for resource group"
}