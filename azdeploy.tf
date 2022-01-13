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
resource "azurerm_virtual_network" "myTerra-vnet" {
  name                = "myTerra-vnet"
  depends_on          = [azurerm_resource_group.name]
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.10.1.0/16"]
  dns_servers         = ["10.10.1.4", "168.63.129.16", "8.8.8.8"]
  tags = {
    Environment = var.environment_tag
    Function    = "bab-network"
  }
}
resource "azurerm_subnet" "myTerra-vnet-snet1" {
  name                 = "myTerra-vnet-snet1"
  depends_on          = [azurerm_resource_group.name]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.myTerra-vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}
#Public IP
resource "azurerm_public_ip" "myTerraDC-pip" {
  name                = "myTerraDC-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
    Function    = "lab-activedirectory"
  }
}
#Create NIC and associate the Public IP
resource "azurerm_network_interface" "myTerraDC-nic" {
  name                = "myTerraDC-nic"
  depends_on          = [azurerm_resource_group.name]
  location            = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = "myTerraDC-ipconfig"
    subnet_id                     = azurerm_subnet.myTerra-vnet-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myTerraDC-pip.id
  }

  tags = {
    Environment = var.environment_tag
    Function    = "baselabv1-activedirectory"
  }
}
#Create data disk for NTDS storage
resource "azurerm_managed_disk" "myTerraDC-data" {
  name                 = "myTerraDC-data"
  depends_on          = [azurerm_resource_group.name]
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"
  max_shares           = "2"

  tags = {
    Environment = var.environment_tag
    Function    = "lab-activedirectory"
  }
}

resource "azurerm_windows_virtual_machine" "myTerraDC" {
  name                = "myTerraDC"
  depends_on          = [var.active_directory_domain]
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vmsize_dc
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.myTerraDC-nic.id,
  ]

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
