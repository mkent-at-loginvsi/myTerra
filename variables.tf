variable "environment_tag" {
  type        = string
  description = "Environment tag value"
}
variable resource_group_name {
  description = "The name of the Resource Group where the VM is"
}
variable location {
  description = "The Azure Region in which the Resource Group exists"
}

# Active Directory & Domain Controller VM Size
variable vmsize_dc {
  description = "The Virtual Machine name that you wish to join to the domain"
}

# Active Directory & Domain Controller
variable vmname_dc {
  description = "The Virtual Machine name that you wish to join to the domain"
}

variable "vm_username" {
  description = "The username of an account with permissions to bind machines to the Active Directory Domain"
}

variable "vm_password" {
  description = "The username of an account with permissions to bind machines to the Active Directory Domain"
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `consoto.local`"
}

variable "active_directory_username" {
  description = "The username of an account with permissions to bind machines to the Active Directory Domain"
}

variable "active_directory_password" {
  description = "The password of the account with permissions to bind machines to the Active Directory Domain"
}
variable "client_secret" {
  type        = string
  description = "Azure App Registration Account Secret"
}
