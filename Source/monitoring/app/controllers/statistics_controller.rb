
class StatisticsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include StatisticsHelper

  def digest(api_key, params = {})
    query_string = ''
    params.keys.sort.each do |key|
      query_string += key.to_s + '=' + params[key].to_s + '&'
    end
    query_string.chop!
    hashkey = Digest::SHA1.hexdigest (query_string + '&' + api_key)
  end

  def signature_is_vaild(signature)
    server = Server.find(stats_params[:server_id])
    return false if server.nil?
    digest(server.api_key, stats_params.except(:digest)) == signature
  end

  def create

    if signature_is_vaild(stats_params[:digest]) 
      @stats = Statistic.new(stats_params.except(:digest))
      if @stats.save
        if runing_out_of_disk_space(skip_gigs(@stats.disk_usage), skip_gigs(@stats.total_disk)) 
          puts "Running out of disk space!!!"
          render json: "{ 'code': 'Alert!', 'message': 'Disk usage is to high: #{@stats.disk_usage} out of #{@stats.total_disk}!' }"
        elsif high_cpu_usage(@stats.cpu_usage, @stats.number_of_cores)
          render json: "{ 'code': 'Alert!', 'message': 'CPU usage is to high: #{@stats.cpu_usage}!' }"
        else 
          render json: '{ "code": "OK", "message": "Statistics updated!" }'
        end
      else
        render json: '{ "code": "Error", "message": "Something went wrong!" }'
      end
    else 
      render json: '{ "code": "Error", "message": "Invalid signature!" }'
    end

  end

  def index
    @servers = Server.all
    @statistics = Statistic.all
  end

  private 
    
    def stats_params
      params.require(:statistics).permit(:server_id, :cpu_usage, :disk_usage, 
                                         :total_disk,  :number_of_cores, 
                                         :process_running, :digest)
    end


end

