require 'octokit'

# Replace this with your GitHub personal access token
ACCESS_TOKEN = '<your-token>'

# GitHub username
USERNAME = '<your-username>'

# Set to true for a dry run (no actual deletions)
DRY_RUN = false

# Create a GitHub client
client = Octokit::Client.new(access_token: ACCESS_TOKEN)

# Start with the first page of repositories
page_number = 1

loop do
  # Fetch the current page of repositories for the user
  repos = client.repos(USERNAME, page: page_number)

  # Break the loop if there are no more repositories
  break if repos.empty?

  # Iterate through the repositories on the current page
  repos.each do |repo|
    # Get the updated_at date (already a Time object)
    updated_at = repo.updated_at

    # Check if the repository was updated before 2021
    if updated_at.year < 2021
      if DRY_RUN
        # Print the repository name without deleting (dry run)
        puts "Would delete repository: #{repo.full_name}"
      else
        # Delete the repository if not updated in 2023
        client.delete_repo(repo.full_name)
        puts "Deleted repository: #{repo.full_name}"
      end
    end
  end

  # Increment the page number for the next iteration
  page_number += 1
end
