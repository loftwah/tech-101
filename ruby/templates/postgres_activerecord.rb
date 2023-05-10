# frozen_string_literal: true

require 'active_record'

class PostgresManager
  def self.call
    new.call
  end

  def call
    # Add your code logic here to work with Postgres databases.
    # For example, you can create, query, or update records.
  end

  private

  def establish_connection
    @establish_connection ||= ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: ENV.fetch('POSTGRES_DATABASE', nil),
      username: ENV.fetch('POSTGRES_USERNAME', nil),
      password: ENV.fetch('POSTGRES_PASSWORD', nil),
      host: ENV.fetch('POSTGRES_HOST', nil),
      port: ENV.fetch('POSTGRES_PORT', 5432)
    )
  end
end

# Run the Postgres Manager
PostgresManager.call
