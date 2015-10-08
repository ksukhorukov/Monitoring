class ServersController < ApplicationController

  def index
    @servers = Server.all
  end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:success] = "New server created!"
      redirect_to @server
    else
      render 'new'
    end
  end

  def edit
    @server = Server.find(params[:id])
  end

  def update
    @server = Server.find(params[:id])
    if @server.update_attributes(server_params)
      flash[:success] = "Server updated"
      redirect_to @server
    else 
      render 'edit'
    end
  end

  def show
    @server = Server.find(params[:id])
  end

  def destroy
    Server.find(params[:id]).destroy
    flash[:success] = "Server deleted"
    redirect_to servers_url
  end

  private 
    def server_params
      params.require(:server).permit(:name, :description, :api_key)
    end

end
