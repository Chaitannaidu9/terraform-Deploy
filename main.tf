provider "azurerm" {
  features {
    
  }
}
terraform {
  backend "azurerm" {
    resource_group_name = "RG-STG"
    storage_account_name = "chtudemostorageus2001"
    container_name = "demo-2"
    key = "terraform.tfstate"
  }
}
resource "azurerm_resource_group" "RG" {
  name = var.azurerm_resource_group
  location = var.location
}

resource "azurerm_network_security_group" "nsg" {
    resource_group_name = azurerm_resource_group.RG.name
    location = azurerm_resource_group.RG.location
    name = var.azurerm_network_security_group
  
}
resource "azurerm_virtual_network" "Vnet" {
    resource_group_name = azurerm_resource_group.RG.name
    name = var.azurerm_virtual_network
    location = azurerm_resource_group.RG.location
    address_space = ["10.0.0.0/16"]
    dns_servers = ["10.0.0.6", "10.0.0.7"]
  
}

resource "azurerm_subnet" "Subnet1" {
    name = var.azurerm_subnet
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes = [ "10.0.1.0/24" ]
    resource_group_name = azurerm_resource_group.RG.name
}
resource "azurerm_public_ip" "publicip" {
    name = "publicIP"
    location = azurerm_resource_group.RG.location
    resource_group_name = azurerm_resource_group.RG.name
    allocation_method = "Dynamic"
}
resource "azurerm_network_interface" "Nic" {
    name = var.azurerm_network_interface
    resource_group_name = azurerm_resource_group.RG.name
    location = azurerm_resource_group.RG.location
    ip_configuration {
      name = "myNicConfiguration"
      private_ip_address_allocation = "Dynamic"
      subnet_id = azurerm_subnet.Subnet1.id
      public_ip_address_id = azurerm_public_ip.publicip.id
    }
    
}



resource "azurerm_windows_virtual_machine" "VM" {
  name                = var.azurerm_virtual_machine
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Admin1234"
  network_interface_ids = [
    azurerm_network_interface.Nic.id,
  ]

  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
