output "acr_login_server" {
  value = module.acr.name
}

output "aks_rg" {
  value = module.network.name
}

output "aks_name" {
  value = module.aks.id
}
