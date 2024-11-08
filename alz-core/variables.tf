## ------------------------------------
##  COMMON VARIABLES
## ------------------------------------

variable "location" {
  type        = string
  default     = "eastus"
  description = "all resource location"
}

variable "tags" {
  type        = map(string)
  description = "tags value for common resources"
}

## ------------------------------------
##  CORE ALZ VARIABLES
## ------------------------------------

variable "root_id" {
  type    = string
}

variable "root_name" {
  type    = string
}

## ------------------------------------
##  MANAGEMENT RESOURCE VARIABLES
## ------------------------------------

variable "deploy_management_resources" {
  type    = bool
  default = false
}

variable "log_retention_in_days" {
  type    = number
  default = 50
}

variable "security_alerts_email_address" {
  type    = string
  default = "my_valid_security_contact@replace_me" # Replace this value with your own email address.
}

variable "management_resources_location" {
  type    = string
  default = "eastus"
}

variable "management_resources_tags" {
  type = map(string)
  default = {
    environment = "Plaform Management"
    costcenter  = "IT"
  }
}

## ------------------------------------
##  CONNECTIVITY RESOURCE VARIABLES
## ------------------------------------

variable "deploy_connectivity_resources" {
  type    = bool
  default = false
}

variable "connectivity_resources_location" {
  type    = string
  default = "eastus"
}

variable "connectivity_resources_tags" {
  type = map(string)
  default = {
    environment = "Plaform Connectivity"
    costcenter  = "IT"
  }
}