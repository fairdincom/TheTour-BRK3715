output "name" {
  value = "${azurerm_resource_group.resourcegroup.name}"
}

output "location" {
  value = "${azurerm_resource_group.resourcegroup.location}"
}

output "tags" {
  value = "${azurerm_resource_group.resourcegroup.tags}"
}