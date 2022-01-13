#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 2.79.0"
    }
  }
}
provider "azurerm" {
  features {
  }
  subscription_id = "e1beab3c-0ead-4464-b7bd-99c24c7efaa1"
  client_id       = "9ef77a59-57b5-4306-84ac-efdb1f73dac3"
  client_secret   = var.client_secret
  tenant_id       = "b82b0b30-39f9-412f-9eea-b629252434ad"
}
