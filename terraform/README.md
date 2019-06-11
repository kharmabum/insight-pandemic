## Requirements

- Terraform `0.12.x`
- AWS Account and IAM user with associated key and secret stored in `secrets.auto.tfvars`
- A premade AWS keypair, see `keypair_name` in `terraform/terraform.tfvars`

## Deploy Instructions

- **WARNING**: Provisioning these resources is beyond the scope of AWS Free Tier.
- Run `terraform apply` and approve changes.
- To destroy all created resources, run `terraform destroy`
