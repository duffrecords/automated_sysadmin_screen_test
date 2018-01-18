require 'rspec'
require 'net/http'

def request_to_superstar
  url = URI.parse('http://superstar.admin.com/')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
  res
end

def request_to_connect_php
  url = URI.parse('http://superstar.admin.com/connect.php')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
  res
end
