require 'json'

$regions = ["ap-southeast-2", "us-west-1", "eu-west-1", "us-east-1"]
$services = ["EC2", "S3", "ECS", "ECR", "SNS", "SQS", "RDS", "ElastiCache", "SES", "ELBv2", "TargetGroups"]

def create_md_table(data)
  if data.first.is_a?(String)
    table = "- " + data.join("\n- ")  # create markdown list
  else
    headers = data.first.keys
    table = "| #{headers.join(' | ')} |\n"
    table += "| #{Array.new(headers.length, '---').join(' | ')} |\n"

    data.each do |row|
      row.each { |key, value| row[key] = value.is_a?(Array) ? value.join(", ") : value.to_s }  # convert array or hash to string
      table += "| #{row.values.join(' | ')} |\n"
    end
  end
  table
end

def generate_report
  report = "# AWS Services Report\n"
  $regions.each do |region|
    report += "## #{region}\n\n"
    $services.each do |service|
      filename = "#{service}_#{region}.json"
      if File.exist?(filename)
        file = File.read(filename)
        begin
          data = JSON.parse(file)
          if data.is_a?(Array) && !data.empty?
            report += "### #{service}\n\n"
            report += create_md_table(data)
            report += "\n\n"
          end
        rescue JSON::ParserError
          report += "### #{service}\n\n"
          report += "Error: Invalid or empty JSON data in #{filename}\n\n"
        end
      end
    end
  end
  File.write("report.md", report)
end

generate_report
