variable "aks_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "node_count" {}
variable "node_size" {}
variable "acr_id" {}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [var.acr_id]
}

output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "identity" {
  value = azurerm_kubernetes_cluster.aks.identity[0]
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0]
}
