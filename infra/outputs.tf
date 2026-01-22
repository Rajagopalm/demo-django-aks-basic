output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks_rg" {
  value = azurerm_resource_group.rg.name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}
