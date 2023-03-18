# Guide: Syncing GitHub and Jira using Ruby and AWS with Pull Request Label Updates

This guide will help you set up synchronization between GitHub and Jira using Ruby and AWS services. The new functionality will move a Jira issue to a specified column when a specific label is added to a pull request in GitHub.

## Prerequisites

1. A GitHub account with a repository.
2. A Jira Cloud account with an API token.
3. Ruby installed on your system.
4. An AWS account with access to AWS Lambda and AWS API Gateway.

## Step 1: Set up a Ruby script

Create a new Ruby script `github_jira_sync.rb` that will be responsible for handling the synchronization between GitHub and Jira.

```ruby
require 'httparty'
require 'json'

class GithubJiraSync
  attr_accessor :github_access_token, :jira_access_token, :jira_email

  def initialize(github_access_token, jira_access_token, jira_email)
    @github_access_token = github_access_token
    @jira_access_token = jira_access_token
    @jira_email = jira_email
  end

  # Add methods for syncing tasks here
end
```

## Step 2: Implement methods for synchronization

Add methods to the `GithubJiraSync` class for fetching and syncing issues between GitHub and Jira, and handling the pull request label event.

```ruby
# Add to GithubJiraSync class

def fetch_github_issues(repo_owner, repo_name)
  # Implement GitHub API calls to fetch issues
end

def fetch_jira_tickets(project_key)
  # Implement Jira API calls to fetch tickets
end

def sync_issues_to_jira(github_issues, project_key)
  # Create/update Jira tickets based on GitHub issues
end

def sync_tickets_to_github(jira_tickets, repo_owner, repo_name)
  # Create/update GitHub issues based on Jira tickets
end

def update_jira_issue_based_on_pr_label(pr_event, label_name, column_name)
  return unless pr_event['action'] == 'labeled' && pr_event['label']['name'] == label_name

  jira_ticket_key = extract_jira_ticket_key(pr_event)
  return unless jira_ticket_key

  move_jira_ticket_to_column(jira_ticket_key, column_name)
end

def extract_jira_ticket_key(pr_event)
  pr_title = pr_event['pull_request']['title']
  pr_description = pr_event['pull_request']['body']
  jira_ticket_key_regex = /([A-Z]+-\d+)/

  jira_ticket_key = pr_title[jira_ticket_key_regex] || pr_description[jira_ticket_key_regex]
  jira_ticket_key
end

def move_jira_ticket_to_column(jira_ticket_key, column_name)
  # Implement Jira API calls to move the ticket to the specified column
end
```

Refer to the [GitHub API documentation](https://docs.github.com/en/rest/) and [Jira API documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/) for details on implementing the above methods.

## Step 3: Create an AWS Lambda function

Create a new Lambda function in the AWS Management Console.

1. Sign in to the AWS Management Console and open the AWS Lambda service.
2. Click on "Create function" and choose "Author from scratch."
3. Provide a name for your function (e.g., `github_jira_sync`).
4. Choose the "Ruby 2.7" runtime.
5. In the "Function code" section, upload a zip file containing the `github_jira_sync.rb` script and any dependencies.
6. Click "Create function."

## Step 4: Configure environment variables

Add environment variables for your GitHub access token, Jira API token, and Jira email in the Lambda function configuration.

1. In your Lambda function's "Configuration" tab, click on "Environment variables."
2. Add the following key-value pairs:

* `GITHUB_ACCESS_TOKEN`: _your GitHub access token_
* `JIRA_API_TOKEN`: _your Jira API token_
* `JIRA_EMAIL`: _your Jira account email_

## Step 5: Create an AWS API Gateway trigger

Create an API Gateway trigger for your Lambda function to expose a REST API endpoint.

1. In your Lambda function's "Designer" section, click on "Add trigger."
2. Choose "API Gateway" as the trigger type.
3. Select "Create an API" and choose "REST API."
4. Click "Add."

Take note of the API endpoint URL, as you will need it to configure your GitHub webhook.

## Step 6: Configure a GitHub webhook

Create a webhook in your GitHub repository to send events to your AWS API Gateway endpoint.

1. Navigate to your GitHub repository and click on the "Settings" tab.
2. In the left sidebar, click on "Webhooks."
3. Click the "Add webhook" button.
4. In the "Payload URL" field, enter the API endpoint URL from your AWS API Gateway trigger.
5. Choose "application/json" as the content type.
6. Select the events you want to trigger the webhook, such as "Issues," "Issue comments," and "Pull requests."
7. Click "Add webhook."

Now, whenever there is an event in your GitHub repository, a request will be sent to your API Gateway endpoint, which will trigger your Lambda function to synchronize the GitHub issues with Jira tickets and move the Jira issue to the specified column when a specific label is added to a pull request in GitHub.

## Step 7: Test and verify

To test and verify the synchronization:

1. Create a new issue in your GitHub repository.
2. Check your Jira project for a new ticket that matches the GitHub issue.
3. Update the issue in GitHub and verify the changes are reflected in the corresponding Jira ticket.
4. Create a new ticket in Jira and verify that a new issue is created in your GitHub repository.
5. Create a pull request in your GitHub repository and add the specific label to it.
6. Verify that the corresponding Jira issue is moved to the specified column.

If the synchronization is working as expected, you have successfully set up GitHub and Jira integration using Ruby and AWS with the new pull request label update functionality.
