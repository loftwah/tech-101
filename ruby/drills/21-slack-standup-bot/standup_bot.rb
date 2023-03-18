require 'json'
require 'slack-ruby-client'

# Load questions from the JSON file
questions_file = File.read('questions.json')
questions = JSON.parse(questions_file)

# Configure the Slack client
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

# Initialize the Slack client
client = Slack::Web::Client.new

# Send a message to the standup channel
client.chat_postMessage(channel: '#standup', text: 'Daily Standup Time! Please share your updates:')

# Send questions one by one
questions.each do |question|
  client.chat_postMessage(channel: '#standup', text: question)
  sleep 5 # Pause for 5 seconds between questions
end
