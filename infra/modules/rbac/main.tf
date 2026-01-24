variable "acr_id" {}
variable "aks_identity" {}
variable "kubelet_identity" {}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_identity.principal_id
}

resource "azurerm_role_assignment" "acr_pull_kubelet" {
  principal_id         = var.kubelet_identity.object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
