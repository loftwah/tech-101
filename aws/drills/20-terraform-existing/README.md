# Create Terraform code from existing AWS resources

This is a guide to using the AWS CLI to generate Terraform code for all resources under an AWS account:

## Prerequisites

Install AWS CLI on your local machine and configure it with your AWS credentials.
Install Terraform on your local machine.

## Steps

- Create a new directory where you will store your Terraform configuration files.

- Run the following command in your terminal to get a list of all the resources available under your AWS account:

```bash
aws resourcegroupstaggingapi get-resources --query 'ResourceTagMappingList[].ResourceARN' --output text
```

- The output of the above command will be a list of all the resources in your AWS account. Redirect the output to a file with the following command:

```bash
aws resourcegroupstaggingapi get-resources --query 'ResourceTagMappingList[].ResourceARN' --output text > resources.txt
```

- Run the following command to generate Terraform configuration files for each resource:

```bash
cat resources.txt | while read resource; do
  aws terraform generate-cli-skeleton --resource-type $(echo $resource | awk -F ":" '{print $6}') --output json > $(echo $resource | awk -F ":" '{print $6}').json;
done
```

- The above command will generate a separate JSON file for each resource type, named after the resource type (e.g. "aws_s3_bucket.json" for S3 buckets).

Finally, run the following command to convert the JSON files into Terraform code:

```bash
for file in *.json; do
  terraform import --config $file $(cat $file | jq -r .id) || echo "Unable to import $file";
done
```

- The above command will import all resources into Terraform, and generate a .tfstate file for each resource. These .tfstate files can be used to manage your resources using Terraform.

That's it! You now have Terraform code for all resources under your AWS account. Note that the generated code may need to be modified to fit your specific needs, but this should give you a good starting point.
