# Setup

## (OPTIONAL) VSCode

- [Download VSCode](https://code.visualstudio.com/download)

## Install and configure AWS CLI

- [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Configure credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)Setup

### Select the profile to be used

- Windows: `setx AWS_PROFILE <profilename>`
- Mac:  `export AWS_PROFILE=<profileName>`
- Verify we are using the correct AWS profile
`aws sts get-caller-identity`


## Install Terraform 

- [Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Mac:
```
brew update
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
- Windows:
    - download the Terraform version for your architecture: https://developer.hashicorp.com/terraform/downloads
    - extract the `terraform.exe` executable into a directory of your choosing
    - add the executable to your global path
        - `My Computer > Properties > Advanced system settings > Environment Variables > System variables -> Path`

- Test installation:
    `terraform version`