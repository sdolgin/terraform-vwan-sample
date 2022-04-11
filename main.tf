# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # set the value in a tfvars file or pass into terraform during execution
  subscription_id = "${var.subscription_id}"
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-vwan-example"
  location = "West US"
}

resource "azurerm_virtual_wan" "example" {
  name                = "vwan-example"
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
}

resource "azurerm_virtual_hub" "example" {
  name                = "vhub-example"
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
  virtual_wan_id      = "${azurerm_virtual_wan.example.id}"
  address_prefix      = "10.0.0.0/23"
}