variable "teams" {
  description = "Map of teams to create and their EMU IdP group names to link."
  type = map(object({
    name            = string
    description     = optional(string, "")
    privacy         = optional(string, "closed")
    parent_team_id  = optional(string)
    idp_group_names = list(string)
  }))

  validation {
    condition = alltrue([
      for team in values(var.teams) : contains(["closed", "secret"], try(team.privacy, "closed"))
    ])
    error_message = "privacy must be either 'closed' or 'secret'."
  }

  validation {
    condition = alltrue([
      for team in values(var.teams) : length(team.idp_group_names) > 0
    ])
    error_message = "Each team must have at least one EMU IdP group name."
  }
}
