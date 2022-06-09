terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.28"
    }
  }
}

variable "api_key" {
   type = string
   description = "value for API key"
}

variable "secret_key" {
   type = string
   description = "value for secret key"
}

variable "organization" {
   type = string
   description = "value for organization"
}

variable "organization" {
   type = string
   description = "Name for the policy"
}

provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secret_key
  endpoint = "https://intersight.com"
}

resource "intersight_ntp_policy" "ntp" {
  name        = var.name
  description = "Demo Policy"
  enabled     = true
  ntp_servers = [
    "ntp.esl.cisco.com"
  ]
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}
