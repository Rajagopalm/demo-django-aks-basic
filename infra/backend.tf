terraform {
  backend "azurerm" {
    # Configure these values in your environment or via variables
    resource_group_name  = "tfstate-rg"            # Change as needed
    storage_account_name = "tfstateaccountrajag01" # Change as needed
    container_name       = "tfstate-aks"               # Change as needed
    key                  = "terraform.tfstate"
  }  
}

# Replace <your-resource-group> and <yourstorageaccount> with your actual values.
# The storage account and container must exist before running 'terraform init'.
