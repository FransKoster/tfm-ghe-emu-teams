module "emu_teams" {
  source = "../../"

  teams = {
    platform = {
      name        = "Platform"
      description = "Shared platform engineering team"
      privacy     = "closed"
      idp_group_names = [
        "g-ug-aad-SRE-engineers",
      ]
    }

    data = {
      name        = "Data"
      description = "Data engineering team"
      privacy     = "closed"
      idp_group_names = [
        "ghe-cloudregie-admins"
      ]
    }
  }
}
