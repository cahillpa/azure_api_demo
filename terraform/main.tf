provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azure_api_demo_rg" {
  name     = "azure-api-demo-rg"
  location = "East US 2"
}

resource "azurerm_storage_account" "azure_api_demo_storage" {
  name                     = "azureapidemostorage"
  resource_group_name      = azurerm_resource_group.azure_api_demo_rg.name
  location                 = azurerm_resource_group.azure_api_demo_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "azure_api_demo_plan" {
  name                = "azure-api-demo-plan"
  resource_group_name = azurerm_resource_group.azure_api_demo_rg.name
  location            = azurerm_resource_group.azure_api_demo_rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "azure_api_demo_function" {
  name                = "azure-api-demo-function"
  location            = azurerm_resource_group.azure_api_demo_rg.location
  resource_group_name = azurerm_resource_group.azure_api_demo_rg.name
  service_plan_id     = azurerm_service_plan.azure_api_demo_plan.id
  storage_account_name       = azurerm_storage_account.azure_api_demo_storage.name
  storage_account_access_key = azurerm_storage_account.azure_api_demo_storage.primary_access_key

  site_config {
    application_stack {
      java_version = "17"
    }

    always_on     = true
    http2_enabled = true
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"      = "java"
    "FUNCTIONS_EXTENSION_VERSION"   = "~4"
    "JAVA_VERSION"                  = "17"
    "WEBSITE_RUN_FROM_PACKAGE"      = "1"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }

  https_only = true
}

