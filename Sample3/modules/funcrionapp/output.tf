output "id" {
  value = "${azurerm_function_app.funcrionapp.id}"
}

output "name" {
  value = "${azurerm_function_app.funcrionapp.name}"
}

output "location" {
  value = "${azurerm_function_app.funcrionapp.location}"
}

output "default_hostname" {
  value = "${azurerm_function_app.funcrionapp.default_hostname}"
}

output "outbound_ip_addresses" {
  value = "${azurerm_function_app.funcrionapp.outbound_ip_addresses}"
}