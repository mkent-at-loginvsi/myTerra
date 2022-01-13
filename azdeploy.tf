#Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.azure-rg
  location = var.loc
  tags = {
    Environment = var.environment_tag
    Function    = "lab-resourcegroups"
  }
}
