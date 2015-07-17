# encoding: utf-8

QUERY = ARGV[0].to_s.strip

require_relative "../lib/conoha"

credentials = QUERY.split(/\s/)

unless credentials.count == 2
  puts "RUN: conoha setup <USERNAME> <PASSWORD>"
  exit
end

config = Conoha::Config.new :name => credentials.first, :password => credentials.last
config.save

puts "Setup complete"
