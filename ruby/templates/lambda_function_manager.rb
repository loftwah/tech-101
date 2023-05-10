# frozen_string_literal: true

require 'aws-sdk-lambda'

class LambdaFunctionManager
  def self.call
    new.call
  end

  def call
    # Add your code logic here to work with Lambda functions.
    # For example, you can create, update, or invoke functions.
  end

  private

  def lambda_client
    @lambda_client ||= Aws::Lambda::Client.new(
      region: ENV.fetch('AWS_REGION', 'ap-southeast-2'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
  end
end

# Run the Lambda Function Manager
LambdaFunctionManager.call
