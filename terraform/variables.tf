variable "resource_group_name" {
  default = "rg-azure-api-demo"
}

variable "location" {
  default = "eastus"
}

variable "function_app_name" {
  default = "func-azure-api-demo"
}

variable "storage_account_name" {
  default = "stazureapidemoxyz"  # Must be globally unique and 3-24 lowercase letters/numbers only
}

variable "aks_cluster_name" {
  default = "aks-azure-api-demo"
}

variable "acr_name" {
  default = "acrazureapidemoxyz"  # Must be globally unique, lowercase, 5-50 characters
}
