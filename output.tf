output "azurerm_resource_group" {
  value = azurerm_resource_group.RG
}
output "azurerm_network_security_group" {
  value = azurerm_network_security_group.nsg
}
output "azurerm_virtual_network" {
  value = azurerm_virtual_network.Vnet
}
output "azurerm_windows_virtual_machine" {
  value = azurerm_windows_virtual_machine.VM.public_ip_address
}