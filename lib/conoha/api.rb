# encoding: utf-8

require 'net/https'
require 'uri'
require 'json'

module Conoha
  class API

    def self.GetToken(username, password, region)
      tenantId = username.gsub("gncu","gnct")
      url = "https://identity." + region + ".conoha.io/v2.0/tokens"
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      #https.set_debug_output $stderr
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req.body = '{ "auth": { "passwordCredentials": { "username": "'+ username +'", "password": "'+ password + '"}, "tenantName": "'+ tenantId +'" } }'
      res = https.request(req)
      if res.code == "200"
        json = JSON.parse(res.body)
        json["access"]["token"]
      else
        nil
      end
    end

    def self.GetServers(region, token)
      url = "https://compute." + region + ".conoha.io/v2/" + token["tenant"]["id"] + "/servers/detail"
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      #https.set_debug_output $stderr
      req = Net::HTTP::Get.new(uri.request_uri)
      req["Accept"] = "application/json"
      req["X-Auth-Token"] = token["id"]
      res = https.request(req)
      json = JSON.parse(res.body)
      json
    end

    def self.fetch(apiUserName,apiPassword, region)
      token = []
      token = self.GetToken(apiUserName, apiPassword, region)
      unless token.nil?
        json = self.GetServers(region,token)
        json["servers"]
      end
    end

  end
end
