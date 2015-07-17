# encoding: utf-8
require 'time'

QUERY = ARGV[0].to_s.strip

require_relative "../lib/conoha"

#begin
#  config = Conoha::Config.new
#rescue Conoha::FileMissingError
  # Create empty config file if it doesn't exist
  # config.save
#end

config = Conoha::Config.new

# 'my' command needs Qiita API Token
#unless config.token
#  Qiita::Alfred.message "RUN: 'qiita setup' command first"
#  exit
#end

regions = ["tyo1","sin1","sjc1"]

#regions.each do |reg|
  data = Conoha::API.fetch(config["name"],config["password"], "tyo1")
  unless data.nil?
    results = Conoha::Alfred.messages(data)
    puts Conoha::Alfred.to_alfred(results)
  else
    results = Conoha::Alfred.message("認証エラーです。")
  end
#end
