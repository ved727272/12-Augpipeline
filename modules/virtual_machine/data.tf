
data "azurerm_subnet" "subnet" {
   for_each = var.vm_configs
   name = each.value.subnet_name
   virtual_network_name = each.value.virtual_network_name
   resource_group_name = each.value.resource_group_name
}

data "azurerm_public_ip" "pip"{
for_each = var.vm_configs
name = each.value.public_ip_name
resource_group_name = each.value.resource_group_name
}

