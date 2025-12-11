# emu-teams-with-lookup

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.8.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_emu_teams"></a> [emu\_teams](#module\_emu\_teams) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | Base URL for the GitHub Enterprise instance. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | GitHub organization owner configured for the EMU enterprise. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_mappings"></a> [group\_mappings](#output\_group\_mappings) | EMU IdP group mappings. |
| <a name="output_team_details"></a> [team\_details](#output\_team\_details) | Created teams with identifiers. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
