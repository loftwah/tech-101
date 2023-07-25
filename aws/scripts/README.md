# AWS Scripts

Some scripts I use to make DevOps easier.

## Get AWS Resources

This script enumerates various AWS resources across multiple regions. It uses the AWS CLI and specific resource listing commands to gather information about your AWS resources.

The script checks for the following AWS resources: EC2 instances, S3 buckets, ECS clusters, ECR repositories, SNS topics, SQS queues, RDS instances, ElastiCache clusters, and SES identities.

### Get AWS Resources Usage

First, let's make sure your script is executable:

```bash
chmod +x get_aws_resources.sh
```

To run the script, you can use one of the following commands:

1. If you want to use the default AWS profile and output file:

```bash
./get_aws_resources.sh
```

2. If you want to specify a custom AWS profile but use the default output file:

```bash
./get_aws_resources.sh MyProfileName
```

3. If you want to specify both a custom AWS profile and output file:

```bash
./get_aws_resources.sh MyProfileName MyOutputFile.txt
```

Replace `MyProfileName` with the name of your AWS profile, and `MyOutputFile.txt` with the name of your desired output file.

Now, to check the profile you're currently signed into using AWS SSO, you can look at the AWS configuration file. The file is usually located in `~/.aws/config`. The entries in this file would look something like this:

```bash
[profile my-profile]
sso_start_url = https://my-sso-portal.awsapps.com/start
sso_region = ap-southeast-2
sso_account_id = 123456789012
sso_role_name = ReadOnly
region = ap-southeast-2
```

In this example, `my-profile` is the profile name. If you have multiple profiles, you'll see multiple entries like this.

Please note that this AWS SSO session will expire, and you'll need to refresh it. You can do so with the following command:

```bash
aws sso login --profile my-profile
```

Replace `my-profile` with your profile name.

Please remember that it's crucial to handle your AWS credentials securely and to ensure you have the necessary permissions for these operations. Also, be mindful of potential costs associated with making API requests to AWS services.
