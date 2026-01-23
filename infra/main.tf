resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_container_registry.acr]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

# Azure AD Application for GitHub OIDC
resource "azuread_application" "github_oidc" {
  display_name = "github-oidc-${var.aks_name}"
}

# Federated Credential for GitHub Actions (main branch)


resource "azuread_application_federated_identity_credential" "github_oidc_cred" {
  application_id = azuread_application.github_oidc.id
  display_name   = "github-main-branch"
  description    = "Federated credential for GitHub Actions main branch"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_repo}:ref:refs/heads/main"
}

# Service Principal for the Azure AD Application


resource "azuread_service_principal" "github_oidc_sp" {
  client_id = azuread_application.github_oidc.id
}

# Assign AcrPull to federated identity
resource "azurerm_role_assignment" "github_oidc_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.github_oidc_sp.object_id
}


