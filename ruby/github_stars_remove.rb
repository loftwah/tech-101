require 'octokit'

# Replace this with your GitHub personal access token
ACCESS_TOKEN = '<your-token>'

# GitHub username
USERNAME = '<your-username>'

# Create a GitHub client
client = Octokit::Client.new(access_token: ACCESS_TOKEN)

# Start with the first page of starred repositories
page_number = 1

loop do
  # Fetch the current page of starred repositories for the user
  stars = client.starred(USERNAME, page: page_number)

  # Break the loop if there are no more starred repositories
  break if stars.empty?

  # Iterate through the starred repositories on the current page
  stars.each do |star|
    # Unstar the repository
    client.unstar(star.full_name)
    puts "Unstarred repository: #{star.full_name}"
  end

  # Increment the page number for the next iteration
  page_number += 1

  # Sleep for 1 second to avoid hitting rate limits
  sleep(1)
end

puts "Unstarring process complete."
