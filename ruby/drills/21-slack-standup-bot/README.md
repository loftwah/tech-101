# Building a Daily Standup Bot with Ruby, GitHub Actions, and Slack

In this guide, we'll walk you through the process of creating a daily standup bot using Ruby, GitHub Actions, and Slack. The bot will automate the process of collecting daily updates from team members in a designated Slack channel. This will help teams stay aligned and informed about each other's progress and blockers.

## Table of Contents

- [Building a Daily Standup Bot with Ruby, GitHub Actions, and Slack](#building-a-daily-standup-bot-with-ruby-github-actions-and-slack)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Setting up the Slack bot](#setting-up-the-slack-bot)
  - [Creating a Ruby script for the standup bot](#creating-a-ruby-script-for-the-standup-bot)
  - [Setting up GitHub Actions](#setting-up-github-actions)
  - [Standup Meeting](#standup-meeting)
  - [More](#more)

## Prerequisites

Before we start, make sure you have the following:

1. A Slack workspace where you have admin access.
2. A GitHub account.
3. A text editor or integrated development environment (IDE) for writing Ruby code.

## Setting up the Slack bot

First, let's set up the Slack bot that will collect and send daily standup messages.

1. Visit the [Slack API](https://api.slack.com/apps) page and sign in with your account.
2. Click on "Create New App," give your app a name, and choose the workspace you want to develop it in.
3. Navigate to the "Bot Users" section, click on "Add a Bot User," and give your bot a display name.
4. Save your changes and install the bot to your workspace by visiting the "Install App" section.
5. Copy the "Bot User OAuth Access Token" for later use.

## Creating a Ruby script for the standup bot

Now, let's create a Ruby script that will handle sending daily standup messages to your team.

1. Create a new directory for your project and navigate to it in your terminal.
2. Create a new file called `standup_bot.rb` and open it in your text editor.
3. Install the `slack-ruby-client` gem by running `gem install slack-ruby-client` in your terminal.
4. In `standup_bot.rb`, add the following code:

```ruby
require 'slack-ruby-client'

# Configure the Slack client
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

# Initialize the Slack client
client = Slack::Web::Client.new

# Send a message to the standup channel
client.chat_postMessage(channel: '#standup', text: 'Daily Standup Time! Please share your updates:')
```

Replace `#standup` with the name of the channel where you want the bot to send daily standup messages.

## Setting up GitHub Actions

To automate the standup bot, we'll use GitHub Actions to run the Ruby script daily.

1. In your project directory, create a new folder called `.github`, and inside it, another folder called `workflows`.
2. Create a new file called `standup_bot.yml` inside the `workflows` folder.
3. Open the `standup_bot.yml` file in your text editor and add the following code:

```yaml
name: Standup Bot

on:
  schedule:
    - cron: '0 14 * * 1-5' # Runs at 14:00 UTC, Monday to Friday

jobs:
  send_standup_message:
    runs-on: ubuntu-latest

    steps:
    - name: Check out repository
      uses: actions/checkout@v2

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.0

    - name: Install dependencies
      run: |
        gem install bundler
        gem install slack-ruby-client

    - name: Run standup bot
      run: ruby standup_bot.rb
      env:
        SLACK_API_TOKEN: ${{ secrets.SLACK_API_TOKEN }}
```

This workflow file sets up a GitHub Action to run the standup bot script at 14:00 UTC, Monday to Friday.

4. Commit and push your changes to a new GitHub repository.
5. In the GitHub repository settings, navigate to the "Secrets" section and add a new secret named `SLACK_API_TOKEN` with the value of the "Bot User OAuth Access Token" that you obtained earlier.

Now, GitHub Actions will automatically run the standup bot script at the specified schedule.

## Standup Meeting

To ask a series of questions during the standup, we'll modify the Ruby script to load questions from a JSON file and send them sequentially. Follow these steps:

1. Create a new file called `questions.json` in your project directory and add your standup questions as an array of strings:

```json
[
  "1. What did you work on yesterday?",
  "2. What are you working on today?",
  "3. Are there any blockers or impediments?"
]
```

2. Modify the `standup_bot.rb` script to load questions from the JSON file and send them one by one:

```ruby
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
```

3. Commit and push the changes to your GitHub repository.

Now, the standup bot will send the questions from the `questions.json` file to the designated Slack channel, pausing for 5 seconds between each question.

You can update the `questions.json` file anytime to change the standup questions. The bot will pick up the new questions the next time it runs.

## More

There are several additional features and improvements that can be explored with this standup bot to make it more useful and interactive. Some ideas include:

Threaded responses: Modify the bot to collect team members' updates as threaded replies to the standup questions. This will help keep the channel organized and make it easier to review updates.

Reminders: Implement reminders for team members who haven't provided their updates within a certain time frame. The bot could send a direct message to the team member as a gentle reminder.

Customizable standup schedule: Allow team members to set their preferred standup times, so the bot sends questions individually based on their time zones or working hours.

Integration with task management tools: Integrate the bot with project management tools like Trello, Asana, or GitHub Issues. The bot could automatically fetch and display the tasks assigned to team members and update their status based on the standup responses.

Progress tracking: Store the standup responses in a database or a dedicated channel, so it's easy to track team progress over time and generate reports.

Analytics and visualization: Implement an analytics dashboard that visualizes team performance metrics based on the standup data, such as completed tasks, blockers, and team velocity.

Mood check: Add an optional mood check question to gauge team members' well-being and monitor team morale.

Adaptive questioning: Make the bot smarter by having it ask follow-up questions based on team members' responses. For example, if someone mentions a blocker, the bot could ask for more information or offer assistance.

By exploring these ideas and more, you can create a more versatile and efficient standup bot that caters to your team's needs and helps improve overall team communication and productivity.

1. **Threaded responses**

Modify the `standup_bot.rb` script to send the questions as threaded messages:

```ruby
# ... (previous code)

# Send a message to the standup channel
initial_message = client.chat_postMessage(channel: '#standup', text: 'Daily Standup Time! Please share your updates:')

# Send questions one by one as threaded messages
questions.each do |question|
  client.chat_postMessage(channel: '#standup', text: question, thread_ts: initial_message['ts'])
  sleep 5 # Pause for 5 seconds between questions
end
```

Now, the standup questions will be sent as threaded messages, encouraging team members to reply within the thread.

2. **Reminders**

To implement reminders, first, fetch the list of users in the channel and store their user IDs. Then, send a reminder message to those who haven't replied in the thread after a specified amount of time.

Add the following code at the end of the `standup_bot.rb` script:

```ruby
# ... (previous code)

# Fetch the list of users in the channel
channel_info = client.conversations_info(channel: '#standup')
channel_members = channel_info['channel']['members']

# Set reminder time (in seconds)
reminder_time = 3600 # 1 hour

# Wait for the reminder time
sleep reminder_time

# Fetch the replies in the thread
replies = client.conversations_replies(channel: '#standup', ts: initial_message['ts'])

# Collect user IDs of those who replied in the thread
replied_user_ids = replies['messages'].map { |message| message['user'] }.uniq

# Send reminder messages to those who haven't replied
(channel_members - replied_user_ids).each do |user_id|
  client.chat_postMessage(channel: user_id, text: "Friendly reminder: Please share your standup updates in the #standup channel.")
end
```

Now the bot will send reminder messages to the users who haven't replied in the standup thread after the specified reminder time.

3. **Customizable standup schedule**

To implement customizable standup schedules, you can store user-specific schedules in a JSON file, update the GitHub Actions workflow to run more frequently, and modify the Ruby script to check each user's schedule before sending standup messages.

1. Create a new file called `schedules.json` in your project directory and add user-specific standup schedules in the following format:

```
jsonCopy code
{
  "U12345678": "14:00",
  "U87654321": "16:00"
}
```

Replace `U12345678` and `U87654321` with actual Slack user IDs, and set the desired standup times in 24-hour format.

2. Update the `.github/workflows/standup_bot.yml` file to run the GitHub Actions workflow more frequently. Change the `cron` schedule to run every hour, Monday to Friday:

```yaml
on:
  schedule:
    - cron: '0 * * * 1-5' # Runs every hour, Monday to Friday
```

3. Modify the `standup_bot.rb` script to load user schedules from the JSON file and send standup messages based on individual schedules:

```ruby
require 'json'
require 'slack-ruby-client'

# Load questions and schedules from JSON files
questions_file = File.read('questions.json')
questions = JSON.parse(questions_file)

schedules_file = File.read('schedules.json')
schedules = JSON.parse(schedules_file)

# Configure the Slack client
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

# Initialize the Slack client
client = Slack::Web::Client.new

# Get the current UTC time in 24-hour format
current_utc_time = Time.now.utc.strftime('%H:%M')

# Check each user's schedule
schedules.each do |user_id, standup_time|
  # If the current UTC time matches the user's standup time
  if current_utc_time == standup_time
    # Send a direct message to the user to start the standup
    initial_message = client.chat_postMessage(channel: user_id, text: 'Daily Standup Time! Please share your updates:')

    # Send questions one by one as threaded messages
    questions.each do |question|
      client.chat_postMessage(channel: user_id, text: question, thread_ts: initial_message['ts'])
      sleep 5 # Pause for 5 seconds between questions
    end
  end
end
```

Now, the standup bot will check each user's schedule and send personalized standup messages based on their preferred standup times.

Remember to update the `schedules.json` file with the correct Slack user IDs and desired standup times. You can add or remove users and adjust their standup times as needed, and the bot will automatically adapt to the changes.

To integrate the standup bot with Jira, you'll need to fetch assigned tasks using the Jira API and display them during the standup. First, you need to create an API token for your Jira account.

1. Go to <https://id.atlassian.com/manage/api-tokens> and create an API token.
2. Add the following environment variables to the `.github/workflows/standup_bot.yml` file to store your Jira email, API token, and domain:

```yaml
- name: Run standup bot
  run: ruby standup_bot.rb
  env:
    SLACK_API_TOKEN: ${{ secrets.SLACK_API_TOKEN }}
    JIRA_EMAIL: ${{ secrets.JIRA_EMAIL }}
    JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
    JIRA_DOMAIN: ${{ secrets.JIRA_DOMAIN }}
```

3. In your GitHub repository settings, navigate to the "Secrets" section and add new secrets for `JIRA_EMAIL`, `JIRA_API_TOKEN`, and `JIRA_DOMAIN`.
4. Install the `jira-ruby` gem by adding the following line to your `standup_bot.rb` script:

```ruby
require 'jira-ruby'
```

5. Create a function in the `standup_bot.rb` script to fetch assigned tasks for a user:

```ruby
def fetch_assigned_tasks(email, domain, api_token)
  options = {
    username: email,
    password: api_token,
    site: "https://#{domain}.atlassian.net",
    context_path: '',
    auth_type: :basic,
    read_timeout: 120
  }

  client = JIRA::Client.new(options)

  # Replace `assignee` with the Jira user field that matches the user's email
  issues = client.Issue.jql("assignee = '#{email}' AND status != 'Done'")

  issues.map { |issue| "#{issue.key}: #{issue.summary}" }
end
```

6. Modify the `standup_bot.rb` script to fetch assigned tasks for each user and display them before sending standup questions:

```ruby
# ... (previous code)

# Check each user's schedule
schedules.each do |user_id, standup_time|
  # If the current UTC time matches the user's standup time
  if current_utc_time == standup_time
    # Fetch the user's Slack profile to get their email
    user_info = client.users_info(user: user_id)
    user_email = user_info['user']['profile']['email']

    # Fetch assigned tasks from Jira
    assigned_tasks = fetch_assigned_tasks(user_email, ENV['JIRA_DOMAIN'], ENV['JIRA_API_TOKEN'])

    # Send a direct message to the user to start the standup
    initial_message = client.chat_postMessage(channel: user_id, text: 'Daily Standup Time! Please share your updates:')

    # Display assigned tasks
    task_message = "Here are your assigned tasks:\n" + assigned_tasks.join("\n")
    client.chat_postMessage(channel: user_id, text: task_message, thread_ts: initial_message['ts'])

    # Send questions one by one as threaded messages
    questions.each do |question|
      client.chat_postMessage(channel: user_id, text: question, thread_ts: initial_message['ts'])
      sleep 5 # Pause for 5 seconds between questions
    end
  end
end
```

Make sure to update the Jira user field in the `fetch_assigned_tasks` function to match the email address of the assignee in your Jira instance. The field may be different depending on your Jira configuration.

Now, the standup bot will fetch assigned tasks from Jira for each user and display them during the standup. By integrating the bot with Jira, you can help team members keep track of their tasks and better facilitate discussions around their progress during standup meetings.
