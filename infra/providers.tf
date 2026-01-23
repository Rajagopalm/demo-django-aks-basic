terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.113"
    }
  }
  backend "azurerm" {
    # Configure these values in your environment or via variables
    resource_group_name  = "tfstate-rg"            # Change as needed
    storage_account_name = "tfstateaccountrajag01" # Change as needed
    container_name       = "tfstate"               # Change as needed
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
