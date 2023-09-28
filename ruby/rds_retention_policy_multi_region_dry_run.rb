# rds_retention_policy_multi_region_dry_run.rb
require 'aws-sdk-rds'
require 'date'

def dry_run_retention_policy
  regions = ['ap-southeast-2', 'us-west-1', 'eu-west-1']

  regions.each do |region|
    rds_client = Aws::RDS::Client.new(region: region)

    # List all DB snapshots
    snapshots = rds_client.describe_db_snapshots.db_snapshots

    puts "=== Checking RDS snapshots in region: #{region} ==="

    snapshots.each do |snapshot|
      created_at = snapshot.snapshot_create_time
      day = created_at.to_date
      today = Date.today

      # Convert into age in days for better comparisons
      age_in_days = (today - day).to_i

      action = "KEEP"

      if age_in_days <= 30
        action = "KEEP"
      elsif age_in_days > 30 && age_in_days <= 120
        action = [1, 15].include?(day.mday) ? "KEEP" : "DELETE"
      elsif age_in_days > 120 && age_in_days <= 180
        action = day.mday == 1 ? "KEEP" : "DELETE"
      else
        action = "KEEP (older than 180 days)"
      end

      puts "Snapshot Identifier: #{snapshot.db_snapshot_identifier}, Created At: #{created_at}, Action: #{action}"
    end
  end
end

dry_run_retention_policy
