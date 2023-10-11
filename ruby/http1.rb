require "http"

http = HTTP.accept(:json)
response = http.get('https://icanhazdadjoke.com/')

puts response.parse['joke']
