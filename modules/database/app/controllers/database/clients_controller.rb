module Database
  class ClientsController < ApplicationController
    def new
      @client = Client.new
      @providers = Provider.all
    end

    def create
      @client = Client.new(form_params)
      @client.save!
      redirect_to client_path(@client)
    end

    def show
      @client = Client.find(params[:id])
        .tap(&:clients_providers) # preloading association. includes was not working
    end

    def edit
      @client = Client.find(params[:id])
        .tap(&:clients_providers) # preloading association. includes was not working
      @providers = Provider.all
    end
    
    def update
      @client = Client.find(params[:id])
      @client.update!(form_params)
      redirect_to client_path(@client)
    end

    def index
      @clients = Client.all
    end

    def form_params
      params.require(:client).permit(:name, :plan, :email, provider_ids: [])
    end
  end
end
