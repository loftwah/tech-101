require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('https://icanhazdadjoke.com/')
request = Net::HTTP::Get.new(uri)
request['Accept'] = 'application/json'

req_options = {
  use_ssl: uri.scheme == 'https',
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

joke_object = JSON.parse(response.body)

puts joke_object['joke']
