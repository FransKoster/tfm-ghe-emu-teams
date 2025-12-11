terraform {
  required_version = ">= 1.6.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.8.3"
    }
  }
}

# Fetch all EMU external groups from the organization
data "github_external_groups" "emu" {}

resource "github_team" "this" {
  for_each = var.teams

  name                      = each.value.name
  description               = coalesce(each.value.description, "")
  privacy                   = try(each.value.privacy, "closed")
  parent_team_id            = try(each.value.parent_team_id, null)
  create_default_maintainer = false
}

locals {
  # Map group names to their IDs for easy lookup
  emu_groups_by_name = {
    for group in data.github_external_groups.emu.external_groups :
    lower(group.group_name) => group.group_id
  }

  # Collect any requested group names that do not exist in the EMU external groups
  missing_group_names = distinct(flatten([
    for _, team_value in var.teams : [
      for group_name in team_value.idp_group_names : group_name
      if !contains(keys(local.emu_groups_by_name), lower(group_name))
    ]
  ]))

  # Flatten team/group relationships, resolving group names to IDs
  group_mappings = {
    for mapping in flatten([
      for team_key, team_value in var.teams : [
        for group_name in team_value.idp_group_names : {
          key      = "${team_key}-${lower(group_name)}"
          team_key = team_key
          group_id = local.emu_groups_by_name[lower(group_name)]
        }
      ]
    ]) : mapping.key => mapping
  }
}

resource "terraform_data" "validate_group_names" {
  lifecycle {
    precondition {
      condition     = length(local.missing_group_names) == 0
      error_message = "EMU group names not found: ${join(", ", local.missing_group_names)}"
    }
  }
}

resource "github_emu_group_mapping" "this" {
  for_each = local.group_mappings

  depends_on = [terraform_data.validate_group_names]

  group_id  = each.value.group_id
  team_slug = github_team.this[each.value.team_key].slug
}
