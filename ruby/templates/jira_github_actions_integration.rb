# frozen_string_literal: true

require 'octokit'
require 'jira-ruby'
require 'dotenv'

class JiraGitHubActionsIntegration
  def self.call
    new.call
  end

  def call
    # Add your custom logic here

    # Example: Update Jira issue status based on the GitHub PR state
    # update_issue_status
  end

  private

  # Add your custom methods here

  def pr
    @pr ||= github_client.pull_request(ENV.fetch('GITHUB_REPOSITORY', nil), ENV['GITHUB_PR_NUMBER'].to_i)
  end

  def jira_ticket_id
    @jira_ticket_id ||= pr.title.match(/(?<=\b)[A-Za-z]+-\d+/)
  end

  def jira_issue
    @jira_issue ||= find_jira_issue_with_retries
  end

  def find_jira_issue_with_retries
    retry_count = 0
    max_retries = 3
    begin
      jira_client.Issue.find(jira_ticket_id[0])
    rescue JIRA::HTTPError => e
      raise e unless retry_count < max_retries

      retry_count += 1
      sleep 5
      retry
    end
  end

  def github_client
    @github_client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN', nil))
  end

  def jira_client
    @jira_client ||= JIRA::Client.new(jira_options)
  end

  def jira_options
    {
      username: ENV.fetch('JIRA_EMAIL', nil),
      password: ENV.fetch('JIRA_API_TOKEN', nil),
      site: ENV.fetch('JIRA_URL', nil),
      context_path: '',
      auth_type: :basic,
      read_timeout: 120
    }
  end
end

# Load environment variables from .env file
Dotenv.load

# Run the Jira and GitHub Actions Integration
JiraGitHubActionsIntegration.call
