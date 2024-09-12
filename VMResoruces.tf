resource "azurerm_virtual_machine" "vm1indhu" {
  name                  = "testvmindhu"
  resource_group_name   = "TerraformRG"
  location              = "East US"
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_DS1_v2"
  storage_os_disk {
    name = "indhudisk1"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option = "FromImage"
  }
  delete_os_disk_on_termination = true
  
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04-LTS"
    version = "latest"
  }
  os_profile {
    computer_name  = "trainingsystem"
    admin_username = "trainingadmin"
    admin_password = "Accenture123$$"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    "environment" = "dev"
    "tier"        = "frontend"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "indhu12test12"
  address_space       = ["10.10.0.0/16"]
  location            = "East US"
  resource_group_name = "TerraformRG"
}


resource "azurerm_subnet" "subnet1" {
  name                 = "indhuhrmante"
  resource_group_name  = "TerraformRG"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_network_interface" "nic1" {
  name                = "indhunic111"
  location            = "East US"
  resource_group_name = "TerraformRG"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =azurerm_public_ip.in12public12.id
  }
}

resource "azurerm_public_ip" "in12public12" {
  name = "in12public12"
  resource_group_name = "TerraformRG"
  location = "East US"
  allocation_method = "Static"

  tags = {
    "environment" = "TEST"
  }
}
