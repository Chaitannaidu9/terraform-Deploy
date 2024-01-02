variable "azurerm_resource_group" {
    description = "value for azure resource group"
    default = "New-Rg"
}
variable "azurerm_virtual_network" {
    description = "value for virtual network"
    default = "demo-Vnet"
  
}
variable "azurerm_network_security_group" {
    description = "value for network security group"
    default = "demonsg"
}
variable "azurerm_subnet" {
    description = "value for subnet1"
    default = "Subnet-1"
}

variable "location" {
    description = "value for location"
    default = "East US2"
}
variable "azurerm_network_interface" {
    description = "value for network interface"
    default = "MyNic"
}
variable "azurerm_virtual_machine" {
    description = "value for virtual machine"
    default = "Test-VM"
}