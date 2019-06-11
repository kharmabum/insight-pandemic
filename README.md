# insight-pandemic
- [Project Proposal](https://docs.google.com/presentation/d/1vkE3Ajv-h3oT1M7pjeYCO7HaXr5QjviyjIslqmHGm5I/edit?usp=sharing)

## Requirements

- Terraform `0.12.x`
- AWS Account (key + secret), stored in `secrets.auto.tfvars`
- A premade AWS keypair, see `terraform.tfvars: keypair_name`

## Provisioning Infrastructure

- WARNING: Provisioning these resources is beyond the scope of AWS Free Tier.
- From within `insight-pandemic` run:

```
terraform apply
```
