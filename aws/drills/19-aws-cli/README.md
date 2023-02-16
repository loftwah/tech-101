# AWS CLI Overview

The AWS Command Line Interface (AWS CLI) is a unified tool that allows you to manage AWS services from the command line. It provides a command line interface to interact with AWS services, and it is available for Windows, Mac, and Linux.

## Installation

To install the AWS CLI, you need to download and install the appropriate version for your operating system. You can download the AWS CLI from the AWS website, and installation instructions are available for each operating system.

## Configuration

Before you can use the AWS CLI, you need to configure it with your AWS access key ID and secret access key. You can do this by running the "aws configure" command and entering your credentials. You can also configure other options, such as the default region and output format.

## Commands

Here are some of the most commonly used AWS CLI commands you should know as a developer:

### General Commands

`aws help`: Displays help information for the AWS CLI.
`aws version`: Displays the version of the AWS CLI.

### EC2 Commands

`aws ec2 describe-instances`: Retrieves information about one or more instances.
`aws ec2 create-instance`: Launches a new instance in the specified subnet.
`aws ec2 start-instances`: Starts one or more stopped instances.
`aws ec2 stop-instances`: Stops one or more running instances.

### S3 Commands

`aws s3 ls`: Lists all the S3 buckets in your account.
`aws s3 mb`: Creates a new S3 bucket.
`aws s3 cp`: Copies a local file or S3 object to another location locally or in S3.
`aws s3 sync`: Syncs directories and S3 prefixes.

### Lambda Commands

`aws lambda list-functions`: Lists all the Lambda functions in your account.
`aws lambda create-function`: Creates a new Lambda function.
`aws lambda update-function-code`: Updates the code for an existing Lambda function.
`aws lambda invoke`: Invokes a Lambda function.

### Output Formats

The AWS CLI supports several output formats, including JSON, text, and table. You can set the default output format using the "aws configure" command, or you can specify the output format for each command using the `--output` option.

## Conclusion

The AWS CLI is a powerful tool that allows you to manage AWS services from the command line. With a solid understanding of the key commands and output formats, you'll be able to manage your AWS resources efficiently and effectively using the AWS CLI.
