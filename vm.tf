resource "azurerm_public_ip" "bastion" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "dynamic"

  tags = {
    environment = "testing"
  }
}
resource "azurerm_network_interface" "bastion" {
  name                = "bastion-nic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "bastion-vm"
  location              = azurerm_resource_group.myrg.location
  resource_group_name   = azurerm_resource_group.myrg.name
  network_interface_ids = [azurerm_network_interface.bastion.id]
  vm_size               = "Standard_DS1_v2"

    storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}