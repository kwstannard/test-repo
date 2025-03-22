module Database
  class Client < ApplicationRecord
    has_many :clients_providers, -> { joins(:provider).select('database_providers.*', 'database_clients_providers.*') }
    has_many :providers, through: :clients_providers
  end
end
