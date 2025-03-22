module Database
  class ClientsController < ApplicationController
    def new
      @client = Client.new
    end

    def create
      @client = Client.new(form_params)
      @client.save!
      redirect_to client_path(@client)
    end

    def show
      @client = Client.includes(:providers).find(params[:id])
    end

    def form_params
      params.require(:client).permit(:name, :plan, :email)
    end
  end
end
