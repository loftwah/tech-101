# Daily Standup Bot with Ruby, GitHub Actions, and Slack

This guide will walk you through setting up a daily standup bot using Ruby, GitHub Actions, and Slack. The bot will send standup questions to each team member, collect their responses, and post a summary in a dedicated Slack channel. Additionally, it features a mood check question, integration with Jira for task management, and a simple web dashboard for progress tracking and analytics.

## Prerequisites

- Ruby installed on your local machine
- A Slack workspace with the necessary permissions to create and manage bots
- A GitHub account with a new or existing repository

## Setting up the Standup Bot

1. Clone your GitHub repository locally and navigate to the project directory.

2. Create a new file named `standup_bot.rb` and paste the contents of the standup bot script provided in this guide.

3. Create a new file named `questions.json` and paste the contents of the standup questions JSON provided in this guide.

4. Create a new file named `Gemfile` and paste the contents of the Gemfile provided in this guide.

5. Run `bundle install` in your project directory to install the required gems.

6. Set up your Slack bot and obtain the `SLACK_API_TOKEN`. Follow the [official Slack API documentation](https://api.slack.com/start) to create a new bot and add it to your workspace.

7. Set the `SLACK_API_TOKEN` as an environment variable on your local machine or include it in the standup_bot.rb script.

## Setting up GitHub Actions

1. In your GitHub repository, create a new directory named `.github` and a subdirectory named `workflows`.

2. Create a new file named `standup_bot.yml` inside the `workflows` directory and paste the contents of the GitHub Actions workflow provided in this guide.

3. Update the `SLACK_API_TOKEN` in the GitHub Actions workflow file with the correct token value.

4. Commit and push the changes to your GitHub repository.

5. The GitHub Actions workflow will run the standup bot daily at the specified time.

## Setting up the Web Dashboard

1. Start the web dashboard by running `ruby standup_bot.rb` in your project directory.

2. Access the dashboard by navigating to `http://localhost:4567` in your web browser.

## Additional Features

We have additional features:

### Mood Check

The standup bot includes a mood check question in the `questions.json` file. The mood responses are stored in the `public/standup_data.json` file and are used to generate a mood chart on the web dashboard.

### Integration with Jira

To integrate the standup bot with Jira:

1. Add the `jira-ruby` gem to your `Gemfile`.
2. Obtain your Jira API credentials (email and API token) and set them as environment variables or include them in the `standup_bot.rb` script.
3. In the `standup_bot.rb` script, implement the `fetch_assigned_tasks` function to use the Jira API to fetch assigned tasks for a user and display them during the standup.

### Progress Tracking

The standup bot stores standup replies in the `public/standup_data.json` file and posts a summary of the standup updates in the dedicated Slack channel. To set up a dedicated Slack channel:

1. Create a new channel in your Slack workspace, e.g., #standup-summary.
2. Update the `client.chat_postMessage` call in the `standup_bot.rb` script to use the new channel as the `channel` parameter value when posting the standup summary.

### Analytics and Visualization

The standup bot parses the standup replies and uses Chartkick to generate visualizations on the web dashboard. The dashboard displays the user's mood data in a line chart and the standup answers in a table format. You can access the web dashboard by running `ruby standup_bot.rb` in your project directory and navigating to `http://localhost:4567` in your web browser.

Remember to include the `chartkick` and `sinatra` gems in your `Gemfile` and install them by running `bundle install`. The `standup_bot.rb` script includes the necessary code to set up the web dashboard with Chartkick and Sinatra.
