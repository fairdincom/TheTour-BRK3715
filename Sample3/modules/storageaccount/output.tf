output "id" {
  value = "${azurerm_storage_account.storageaccount.id}"
}

output "name" {
  value = "${azurerm_storage_account.storageaccount.name}"
}

output "location" {
  value = "${azurerm_storage_account.storageaccount.primary_location}"
}

output "connection_string" {
  value = "${azurerm_storage_account.storageaccount.primary_connection_string}"
}