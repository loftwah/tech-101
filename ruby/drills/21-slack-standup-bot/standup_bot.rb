require 'slack-ruby-client'
require 'sinatra'
require 'chartkick'
require 'sinatra/chartkick'
require 'json'

def format_summary_message(user_id, question, answer)
  "*#{question}*\n#{answer}\n"
end

def store_standup_data(user_id, answers)
  standup_data_file = 'public/standup_data.json'

  standup_data = if File.exist?(standup_data_file)
    JSON.parse(File.read(standup_data_file))
  else
    {}
  end

  mood = answers.find { |a| a[:question].include?('On a scale of 1 to 5') }[:answer].to_i
  standup_data[user_id] ||= []
  standup_data[user_id] << { date: Time.now.utc.to_s, answers: answers, mood: mood }

  File.write(standup_data_file, JSON.dump(standup_data))
end

if __FILE__ == $0
  Slack.configure do |config|
    config.token = ENV['SLACK_API_TOKEN']
  end

  client = Slack::Web::Client.new
  users = client.users_list['members'].select { |u| !u['is_bot'] && !u['deleted'] }

  users.each do |user|
    user_id = user['id']

    questions = JSON.parse(File.read('questions.json'))
    answers = []

    questions.each do |question|
      response = client.chat_postEphemeral(
        channel: user['id'],
        user: user['id'],
        text: question,
        attachments: [
          {
            fallback: 'Please provide your response.',
            callback_id: 'standup_response',
            actions: [
              {
                name: 'response',
                type: 'textarea',
                placeholder: 'Enter your response here...'
              }
            ]
          }
        ]
      )

      # Wait for the user's response
      loop do
        sleep 5
        action_result = client.actions_result(response['message_ts'], user['id'])

        if action_result['actions'].any?
          answer = action_result['actions'].first['value']
          answers << { question: question, answer: answer }
          break
        end
      end
    end

    # Post the summary of standup updates in the #standup-summary channel
    summary = answers.map { |a| format_summary_message(user_id, a[:question], a[:answer]) }.join
    client.chat_postMessage(channel: '#standup-summary', text: "Standup Summary for <@#{user_id}>:\n\n#{summary}")

    # Store standup data
    store_standup_data(user_id, answers)
  end
end

# Web dashboard
get '/' do
  standup_data_file = 'public/standup_data.json'
  standup_data = if File.exist?(standup_data_file)
    JSON.parse(File.read(standup_data_file))
  else
    {}
  end

  erb :index, locals: { standup_data: standup_data }
end

__END__

@@ layout
<!DOCTYPE html>
<html>
<head>
  <title>Standup Dashboard</title>
  <%= Chartkick.stylesheets %>
</head>
<body>
  <%= yield %>
  <%= Chartkick.javascripts %>
</body>
</html>

@@ index
<h1>Standup Dashboard</h1>

<% standup_data.each do |user_id, user_standup_data| %>
  <h2>Standup Data for <%= user_id %></h2>

  <% mood_data = user_standup_data.map { |s| [s['date'], s['mood']] } %>
  <%= line_chart mood_data, min: 1, max: 5, height: "400px", xtitle: "Date", ytitle: "Mood (1-5)", library: { curve: false } %>

  <table>
    <thead>
      <tr>
        <th>Date</th>
        <th>Question</th>
        <th>Answer</th>
      </tr>
    </thead>
    <tbody>
      <% user_standup_data.each do |standup| %>
        <% standup['answers'].each do |answer| %>
          <tr>
            <td><%= standup['date'] %></td>
            <td><%= answer['question'] %></td>
            <td><%= answer['answer'] %></td>
          </tr>
        <% end %>
      <% end %>
    </tbody>
  </table>
<% end %>
