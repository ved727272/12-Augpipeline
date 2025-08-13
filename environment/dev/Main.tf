module "resource_group" {
    source = "../../modules/resource_group"
    resource_group = var.dev_resource_group
  
}

module "virtual_network" {
    source = "../../Modules/vnet"
    depends_on = [module.resource_group]
    virtual_network = var.dev_virtual_network
}

module "subnet" {
    source = "../../modules/subnet"
    depends_on = [module.virtual_network]
    infrasubnet = var.dev_subnet
}

module "public_ip" {
    source = "../../modules/public_ip"
    depends_on = [module.resource_group]
    public_ip = var.dev_public_ip
}

module "virtual_machine" {
    source = "../../modules/virtual_machine"
    depends_on = [module.subnet, module.public_ip ]
    vm_configs = var.dev_vm_configs
   
}


