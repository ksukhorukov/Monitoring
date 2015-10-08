#!/usr/bin/env ruby

############### How to run in background and on boot ###########
################################################################
## crontab -e                                                 ##
## @reboot /Users/kirill/workspace/crossover/agent/agent.rb   ##
## run in background: nohup ./agent.rb > /dev/null 2>&1 &     ##
################################################################

require 'httparty'
require 'pp'
require 'json'

require_relative './lib/digest'
require_relative './lib/metrics'

class Partay
  include HTTParty
  base_uri Settings.api_url
  format :json
end

while true do 
  options = {
    body: {
      statistics: { 
        server_id: Settings.server_id, 
        disk_usage: disk_usage,
        cpu_usage: cpu_usage,
        number_of_cores: number_of_cores,
        total_disk: total_disk,
        process_running: process_running,
        
      }
    }
  }

  options[:body][:statistics][:digest] = digest(Settings.api_key, options[:body][:statistics])

  result = Partay.post('/', options).body
  result = JSON.parse(result)

  if result['code'] != 'OK'
    File.open('./logs/log.txt', 'a') do |f| 
      f.write("[#{Time.now.strftime("%d/%m/%Y %H:%M")}] Alert! #{result['message']}\n")
    end
  end

  sleep(5)

end


