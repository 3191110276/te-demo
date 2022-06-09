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

variable "org_name" {
   type = string
   description = "value for organization"
   default = "default"
}

variable "policy_name" {
   type = string
   description = "Name for the policy"
}

provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secret_key
  endpoint = "https://intersight.com"
}

data "intersight_organization_organization" "myorg" {
  name = var.org_name
}

resource "intersight_ntp_policy" "ntp" {
  name        = var.policy_name
  description = "Demo Policy"
  enabled     = true
  ntp_servers = [
    "ntp.esl.cisco.com"
  ]
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.myorg.results.0.moid
  }
}
