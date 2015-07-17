# encoding: utf-8

require 'rexml/document'

module Conoha
  module Alfred
    def self.to_alfred(array)
      raise "Argument must be an Array" unless array.kind_of? Array

      doc = REXML::Document.new
      root = doc.add_element("items")

      array.each do |entry|
        item = root.add_element("item")

        entry.each do |key, value|
          if [:uid, :arg, :valid, :autocomplete].include?(key)
            item.attributes[key.to_s] = value.to_s
          else
            element = item.add_element(key.to_s)
            element.text = value ? value.to_s : ""
          end
        end
      end
      doc.to_s
    end

   def self.jpnStatus(msg)
      case msg
      when "ACTIVE"
        "起動中"
      when "REBOOT"
        "再起動中"
      when "SHUTOFF"
        "停止中"
      else
        msg
      end        
    end

    def self.messages(texts_array)
      results = []
      texts_array.each do |q|
        subtitle = q.to_s
        #subtitle = q['stock_count'].to_s + " Stocks, " + q['comment_count'].to_s + " Comments, " + Time.parse(q['created_at']).strftime("%Y/%m/%d %H:%M:%S") + " Created"
        url = "https://manage.conoha.jp/VPS/Detail/tyo1/"+q["id"]+"/"
        if q["OS-EXT-STS:vm_state"] == "active"
          icon_img = "icon-active.png"
        else
          icon_img = "icon-stop.png"          
        end
        item = {
          :uid => q["id"],
          :arg => url,
          :title => q["metadata"]["instance_name_tag"],
          :subtitle => jpnStatus(q["status"]),
          :icon => icon_img
        }
        results << item
      end
      return results
    end
 
    def self.message(str)
      puts Conoha::Alfred.to_alfred([{
        :uid => 0,
        :arg => nil,
        :title => str,
        :subtitle => nil,
        :icon => 'icon.png'
      }])
    end
  end
end
