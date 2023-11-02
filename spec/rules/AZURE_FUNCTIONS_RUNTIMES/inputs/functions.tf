provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_windows_function_app" "valid" {
  name                = "example-windows-function-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name        = azurerm_storage_account.valid.name
  storage_account_access_key  = azurerm_storage_account.valid.primary_access_key
  service_plan_id             = azurerm_service_plan.valid.id


  site_config {
    application_stack {
      powershell_core_version = "7"
    }
  }
}

resource "azurerm_linux_function_app" "valid1" {
  name                = "example-linux-function-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name          = azurerm_storage_account.example.name
  storage_account_access_key    = azurerm_storage_account.example.primary_access_key
  service_plan_id               = azurerm_service_plan.example.id

    site_config {
      application_stack {
        node_version = "14"
    }
  }
}

resource "azurerm_windows_function_app" "invalid1" {
  name                = "example-windows-function-app1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name        = azurerm_storage_account.example.name
  storage_account_access_key  = azurerm_storage_account.example.primary_access_key
  service_plan_id             = azurerm_service_plan.example.id
  
    site_config {
      application_stack {
        use_custom_runtime = "custom"
    }
  }
}

resource "azurerm_linux_function_app" "invalid" {
  name                = "example-linux-function-app1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name          = azurerm_storage_account.example.name
  storage_account_access_key    = azurerm_storage_account.example.primary_access_key
  service_plan_id               = azurerm_service_plan.example.id

    site_config {
      application_stack {
        python_version = "3.10"
    }
  }
}