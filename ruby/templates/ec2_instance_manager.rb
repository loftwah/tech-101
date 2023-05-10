# frozen_string_literal: true

require 'aws-sdk-ec2'

class EC2InstanceManager
  def self.call
    new.call
  end

  def call
    # Add your code logic here to work with EC2 instances.
    # For example, you can start, stop, or terminate instances.
  end

  private

  def ec2_client
    @ec2_client ||= Aws::EC2::Client.new(
      region: ENV.fetch('AWS_REGION', 'ap-southeast-2'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
  end
end

# Run the EC2 Instance Manager
EC2InstanceManager.call
