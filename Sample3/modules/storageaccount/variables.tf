variable "name" {
  type          = "string"
  description   = "Storage account name"
}

variable "resource_group" {
  type          = "string"
  description   = "Resource group name"
}
variable "location" {
  type          = "string"
  description   = "Storage account location"
  default       = "koreacentral"
}

variable "tags" {
  type          = "map"
  description   = "Tags for Storage account"
}