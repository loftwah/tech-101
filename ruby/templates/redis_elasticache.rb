# frozen_string_literal: true

require 'dalli'

class RailsCacheManager
  def self.call
    new.call
  end

  def call
    # Add your code logic here to work with Rails cache using Elasticache.
    # For example, you can read, write, or delete cache entries.
  end

  private

  def cache
    @cache ||= Dalli::Client.new(
      ENV.fetch('ELASTICACHE_ENDPOINT', 'localhost:11211'),
      username: ENV.fetch('ELASTICACHE_USERNAME', nil),
      password: ENV.fetch('ELASTICACHE_PASSWORD', nil)
    )
  end
end

# Run the Rails Cache Manager
RailsCacheManager.call
