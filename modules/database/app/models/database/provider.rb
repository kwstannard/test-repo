module Database
  class Provider < ApplicationRecord
    has_many :providers_clients, -> { joins(:client).select('clients.*', 'clients_providers.*') }
    has_many :clients, through: :providers_clients
    has_many :notes, through: :clients
  end
end
