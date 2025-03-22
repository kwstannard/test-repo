module Database
  class ClientsProvidersController < ApplicationController
    def show
      @clients_provider = Database::ClientsProvider.find_by(id_params)
      @plan = @clients_provider.other_plan
    end

    def update
      @clients_provider = Database::ClientsProvider.find_by(id_params)
      @clients_provider.update(form_params)
      render :show
    end

    def id_params
      params.permit(:client_id, :provider_id)
    end

    def form_params
      params.require(:clients_provider).permit(:plan)
    end
  end
end
