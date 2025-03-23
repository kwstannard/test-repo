module Database
  module ApplicationHelper
    def clients_provider_path(clients_provider)
      client_provider_path(clients_provider.client_id, clients_provider.provider_id)
    end

    def providers_client_path(providers_client)
      provider_client_path(providers_client.provider_id, providers_client.client_id)
    end
  end
end
