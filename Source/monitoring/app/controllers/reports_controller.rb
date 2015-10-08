class ReportsController < ApplicationController

  def show
      respond_to do |format|
        format.pdf do
          @server = Server.find(params[:id])
          @statistics = Statistic.where(server_id: params[:id])
          render pdf: 'show', layout: 'print', orientation: :portrait, 
                      :footer => { :right => '[page] of [topage]' }
        end
      end
  end
  
end
