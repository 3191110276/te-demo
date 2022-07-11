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
   default = "UNDEFINED"
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

resource "intersight_workflow_workflow_info" "workflow_workflow_info1" {
  name         = "workflow_workflow_info1"
  pause_reason = null
  action       = "Create"
  success_workflow_cleanup_duration = 2160
  wait_reason                       = null
  workflow_meta_type                = "SystemDefined"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.myorg.results.0.moid
  }
  workflow_definition {
    object_type = "workflow.WorkflowDefinition"
    moid        = "62cb72a7696f6e2d314fa137"
  }
}

resource "intersight_workflow_workflow_info" "workflow_workflow_info1" {
  name         = "workflow_workflow_info2"
  pause_reason = null
  action       = "Start"
  success_workflow_cleanup_duration = 2160
  wait_reason                       = null
  workflow_meta_type                = "SystemDefined"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.myorg.results.0.moid
  }
  workflow_definition {
    object_type = "workflow.WorkflowDefinition"
    moid        = "62cb72a7696f6e2d314fa137"
  }
}

