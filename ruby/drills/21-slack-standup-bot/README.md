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