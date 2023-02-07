# A quick stretch before we begin the drills

## Some common things we'll use frequently

### We won't actually change anything. We'll just use Terraform's resources to generate

- a random GUIDs
- a random string
- a random password

### We also use the Terraform's `output` to display the items generated

### `cd` into this directory and let's kick it off by running the Terraform commands

```
terraform init
terraform plan
terraform apply
```

### We should see something in this *format*, but the values will be random

```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

guid = {
  "id" = "998ee3fa-862f-76eb-85be-12f09f7509de"
  "keepers" = tomap(null) /* of string */
  "result" = "998ee3fa-862f-76eb-85be-12f09f7509de"
}
password = <sensitive>
random_string = {
  "id" = "ldMKbtB2opbKdbVl"
  "keepers" = tomap(null) /* of string */
  "length" = 16
  "lower" = true
  "min_lower" = 0
  "min_numeric" = 0
  "min_special" = 0
  "min_upper" = 0
  "number" = true
  "numeric" = true
  "override_special" = "/@£$"
  "result" = "ldMKbtB2opbKdbVl"
  "special" = true
  "upper" = true
}
```

#### Quick note

Notice that the `password` output is `<sensitive>`. This prevents it from being
written to logs, etc. You can find the `password` in the `terraform.tfstate` file
in this directory. Go ahead and check it out, it's in the `output` block towards the top.

### Clean-up

Run `terraform destroy` now to clean-up. In this case, it will just remove most of the
content from the `terraform.tfstate` file.