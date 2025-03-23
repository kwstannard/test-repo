module Database
  class ProvidersClientsController < ApplicationController
    def show
      @providers_client = Database::ProvidersClient.find_by(id_params)
      @plan = @providers_client.other_plan
    end

    def update
      @providers_client = Database::ProvidersClient.find_by(id_params)
      @providers_client.update(form_params)
      @plan = @providers_client.other_plan
      render :show
    end

    def id_params
      params.permit(:provider_id, :client_id)
    end

    def form_params
      params.require(:providers_client).permit(:plan)
    end
  end
end
