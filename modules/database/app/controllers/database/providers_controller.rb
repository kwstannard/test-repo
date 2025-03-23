module Database
  class ProvidersController < ApplicationController
    def new
      @provider = Provider.new
      @clients = Client.all
    end

    def create
      @provider = Provider.new(form_params)
      @provider.save!
      redirect_to provider_path(@provider)
    end

    def show
      @provider = Provider.includes(:clients).find(params[:id])
    end

    def edit
      @provider = Provider.includes(:clients).find(params[:id])
      @clients = Client.all
    end

    def update
      @provider = Provider.find(params[:id])
      @provider.update!(form_params)
      redirect_to provider_path(@provider)
    end

    def index
      @providers = Provider.all
    end

    def form_params
      params.require('provider').permit(:name, :email, client_ids: [])
    end
  end
end
