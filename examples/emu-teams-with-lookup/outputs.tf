output "team_details" {
  description = "Created teams with identifiers."
  value       = module.emu_teams.teams
}

output "group_mappings" {
  description = "EMU IdP group mappings."
  value       = module.emu_teams.group_mappings
}
