output "external_groups" {
  description = "All EMU external groups available in the organization."
  value       = data.github_external_groups.emu.external_groups
}

output "teams" {
  description = "Details for each team created by the module."
  value = {
    for key, team in github_team.this : key => {
      id      = team.id
      slug    = team.slug
      node_id = team.node_id
    }
  }
}

output "group_mappings" {
  description = "EMU group mappings keyed by team and group id."
  value = {
    for key, mapping in github_emu_group_mapping.this : key => {
      id        = mapping.id
      group_id  = mapping.group_id
      team_slug = mapping.team_slug
      etag      = mapping.etag
    }
  }
}
