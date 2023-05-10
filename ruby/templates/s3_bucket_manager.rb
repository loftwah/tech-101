# frozen_string_literal: true

require 'aws-sdk-s3'

class S3BucketManager
  def self.call
    new.call
  end

  def call
    # Add your code logic here to work with S3 buckets.
    # For example, you can create, delete, or list buckets.
  end

  private

  def s3_client
    @s3_client ||= Aws::S3::Client.new(
      region: ENV.fetch('AWS_REGION', 'ap-southeast-2'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
  end
end

# Run the S3 Bucket Manager
S3BucketManager.call
