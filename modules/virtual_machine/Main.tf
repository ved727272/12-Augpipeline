resource "azurerm_network_interface" "nic" {
    for_each = var.vm_configs
    name = each.value.nic_name
    location = each.value.location
    resource_group_name = each.value.resource_group_name

ip_configuration {  
name = "internal"
subnet_id = data.azurerm_subnet.subnet[each.key].id
public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
private_ip_address_allocation = "Dynamic"

}
}

resource "azurerm_linux_virtual_machine" "VM" {
for_each = var.vm_configs
name = each.value.vm_name
resource_group_name = each.value.resource_group_name
location = each.value.location 
size = each.value.size
admin_username = each.value.admin_username
admin_password = each.value.admin_password
disable_password_authentication = false
network_interface_ids = [azurerm_network_interface.nic[each.key].id,]

custom_data = filebase64("${path.module}/install_nginx_docker.sh")

 os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = each.value.publisher
    offer = each.value.offer
    sku = each.value.sku
    version = each.value.version
  }
}

