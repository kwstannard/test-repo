module Database
  module ApplicationHelper
    def clients_provider_path(clients_provider)
      client_provider_path(clients_provider.client_id, clients_provider.provider_id)
    end
  end
end
