#Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Environment = var.environment_tag
    Function    = "lab-resourcegroups"
  }
}
#Create Domain Controller VM
resource "azurerm_windows_virtual_machine" "myTerraDC" {
  name                = "myTerraDC"
  depends_on          = var.active_directory_domain
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  size                = var.vmsize
  vm_username      = var.vm_username
  vm_password      = var.vm_password

  tags = {
    Environment = var.environment_tag
    Function    = "lab-activedirectory"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
