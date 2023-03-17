# Automated AWS Ruby Sync Tool for GitHub and Confluence Documentation

This guide will walk you through the steps to set up an automated tool that syncs documentation between a GitHub repository and a Confluence instance hosted on AWS using Ruby. The tool is designed to allow you to write documentation in Markdown format in a GitHub repository and then sync it to Confluence. This helps to maintain consistency and ensure that your documentation is up to date and accessible to all relevant stakeholders.

## Prerequisites

Before you begin, you will need the following:

* A GitHub account
* An AWS account
* Ruby (version 2.7 or later)
* AWS CLI (version 2 or later)
* Git

## Step 1: Create a GitHub repository

The first step is to create a GitHub repository to store your documentation. You can create a new repository or use an existing one. Make sure that the repository is set to public or that you have given access to the relevant Confluence users.

## Step 2: Clone the repository to your local machine

Next, clone the GitHub repository to your local machine using the following command:

```bash
git clone https://github.com/<your-username>/<your-repo>.git
```

Replace `<your-username>` with your GitHub username and `<your-repo>` with the name of your repository.

## Step 3: Install the required Ruby gems

In your terminal, navigate to the root of the cloned repository and run the following command to install the required Ruby gems:

```bash
bundle install
```

This will install the `confluence-ruby` and `octokit` gems, which are required for the sync tool.

## Step 4: Set up the AWS CLI

You will need to set up the AWS CLI with your access key ID and secret access key. If you haven't done so already, follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) to install and configure the AWS CLI.

## Step 5: Create a Confluence API token

Next, you will need to create a Confluence API token. Follow the instructions [here](https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html) to create a token.

## Step 6: Create a `.env` file

Create a `.env` file in the root of the cloned repository and add the following environment variables:

```bash
CONFLUENCE_URL=<your-confluence-url>
CONFLUENCE_SPACE=<your-confluence-space>
CONFLUENCE_PARENT_PAGE_ID=<your-confluence-parent-page-id>
CONFLUENCE_API_TOKEN=<your-confluence-api-token>
GITHUB_REPOSITORY=<your-github-repository>
```

Replace the values in the angle brackets with your own values.

* `CONFLUENCE_URL`: The URL of your Confluence instance.
* `CONFLUENCE_SPACE`: The space key where you want the documentation to be stored.
* `CONFLUENCE_PARENT_PAGE_ID`: The ID of the parent page where you want the documentation to be stored.
* `CONFLUENCE_API_TOKEN`: Your Confluence API token.
* `GITHUB_REPOSITORY`: The name of your GitHub repository (e.g. "my-repo").

## Step 7: Create an AWS Lambda function

In this step, we will create an AWS Lambda function that will sync your GitHub repository with Confluence.

1. Log in to your AWS account and navigate to the Lambda console.
2. Click the "Create function" button.
3. Choose "Author from scratch".
4. Enter a name for your function, choose Ruby as the runtime, and select "Create a new role with basic Lambda permissions" for the execution role.
5. Click "Create function".
6. In the function code section, delete the existing code and copy the contents of the `sync.rb` file from your local repository into the code editor.
7. In the "Environment variables" section, add the same environment variables that you added to the `.env` file in your local repository.
8. Scroll down to the "Basic settings" section and set the timeout to a value that allows the sync to complete (e.g. 5 minutes).
9. Scroll down to the "Permissions" section and click "Add trigger".
10. Choose "API Gateway" as the trigger type.
11. Select "Create a new API" and choose "REST API".
12. Choose "Open with API Gateway API Key" for security.
13. Click "Add".
14. In the "API Gateway" section, click the URL next to "Invoke URL". This will open the API Gateway console.
15. Click "Create Method" and choose "POST".
16. Click "Integration type" and choose "Lambda Function".
17. Choose the Lambda function you created in step 4.
18. Click "Save" and "OK" to confirm.
19. Click "Deploy API" and choose a deployment stage.
20. Copy the URL for the API endpoint.

## Step 8: Configure the GitHub repository webhook

In this step, we will configure a webhook in your GitHub repository to trigger the AWS Lambda function whenever changes are made to the repository.

1. In your GitHub repository, click "Settings" and then "Webhooks".
2. Click "Add webhook".
3. In the "Payload URL" field, paste the URL for the API endpoint that you copied in step 7.
4. Set the content type to "application/json".
5. In the "Secret" field, enter a random string that will be used to validate the webhook payload.
6. Under "Which events would you like to trigger this webhook?", choose "Just the push event".
7. Click "Add webhook".

## Step 9: Test the sync tool

In this step, we will test the sync tool by making changes to the documentation in your GitHub repository and verifying that they are synced to Confluence.

1. Make a change to one of the Markdown files in your GitHub repository.
2. Commit the change and push it to the repository.
3. Wait a few minutes for the webhook to trigger the Lambda function and sync the changes to Confluence.
4. Log in to your Confluence instance and verify that the changes have been synced.

## Conclusion

By following these steps, you have set up an automated tool that syncs documentation between a GitHub repository and a Confluence instance hosted on AWS using Ruby. This tool allows you to write documentation in Markdown format in a GitHub repository and then sync it to Confluence, helping to maintain consistency and ensure that your documentation is up to date and accessible to all relevant stakeholders.
