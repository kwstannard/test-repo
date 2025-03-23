module Database
  class ProvidersClient < ApplicationRecord
    self.table_name = 'clients_providers'
    include ClientsProvider::Foo

    def self.all
      old_all.joins(:client).select('clients.*, clients_providers.*')
    end
  end
end
