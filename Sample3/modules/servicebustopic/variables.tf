variable "name" {
  type          = "string"
  description   = "service bus topic name"
}

variable "resource_group" {
  type          = "string"
  description   = "Resource group name"
}
variable "namespace_name" {
  type          = "string"
  description   = "service bus namespace name"
}

variable "tags" {
  type          = "map"
  description   = "Tags for service bus topic"
}