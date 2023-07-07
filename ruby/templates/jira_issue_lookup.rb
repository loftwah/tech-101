module JiraIssueLookup
    def find_jira_issue(jira_ticket_id)
      jira_client.Issue.find(jira_ticket_id)
    rescue JIRA::HTTPError => e
      warn "ERROR: Failed to send command to Jira. Response: #{e.message}"
    end
  
    def jira_ticket_id
      @jira_ticket_id ||= begin
        match = pr.head.ref.match(/^DL-(\d+)-/)
        "DL-#{match[1]}"
      end
    end
  end