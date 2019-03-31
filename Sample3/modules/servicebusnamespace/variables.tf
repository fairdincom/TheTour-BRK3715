variable "name" {
  type          = "string"
  description   = "service bus namespace name"
}

variable "resource_group" {
  type          = "string"
  description   = "Resource group name"
}
variable "location" {
  type          = "string"
  description   = "service bus location"
  default       = "koreacentral"
}

variable "tags" {
  type          = "map"
  description   = "Tags for service namespace topic"
}