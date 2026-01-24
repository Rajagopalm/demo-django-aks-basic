
module "network" {
  source   = "./modules/network"
  rg_name  = var.rg_name
  location = var.location
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  resource_group_name = module.network.name
  location            = module.network.location
}

module "aks" {
  source              = "./modules/aks"
  aks_name            = var.aks_name
  resource_group_name = module.network.name
  location            = module.network.location
  node_count          = var.node_count
  node_size           = var.node_size
  acr_id              = module.acr.id
}

module "rbac" {
  source           = "./modules/rbac"
  acr_id           = module.acr.id
  aks_identity     = module.aks.identity
  kubelet_identity = module.aks.kubelet_identity
}

# TODO: Move OIDC and federated identity resources to a separate module if needed

