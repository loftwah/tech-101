require 'dotenv'
Dotenv.load

require 'logger'
require 'octokit'
require 'jira-ruby'
require_relative 'jira_issue_lookup'

class JiraGitHubIntegration
  include JiraIssueLookup

  def self.call
    new.call
  end

  def call
    return unless valid_jira_and_issue?

    handle_actions
  rescue Octokit::Error, JIRA::HTTPError => e
    logger.error "An error occurred: #{e.message}"
  end

  private

  def valid_jira_and_issue?
    jira_ticket_id && jira_issue
  end

  def handle_actions
    # your action here
  end

  def logger
    @logger ||= Logger.new($stdout)
  end

  def pr
    @pr ||= github_client.pull_request(ENV.fetch('GITHUB_REPOSITORY', nil), ENV['GITHUB_PR_NUMBER'].to_i)
  end

  def jira_issue
    @jira_issue ||= find_jira_issue(jira_ticket_id)
  end

  def jira_issue_labels
    @jira_issue_labels ||= jira_issue.labels
  end

  def gh_labels_from_env
    raw_labels = JSON.parse(ENV.fetch('GITHUB_PR_LABELS', nil))
    raw_labels.map { |label| label['name'] }
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

# Run the integration
JiraGitHubIntegration.call