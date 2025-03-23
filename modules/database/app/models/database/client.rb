module Database
  class Client < ApplicationRecord
    has_many :clients_providers, -> { joins(:provider).select('providers.*', 'clients_providers.*') }
    has_many :providers, through: :clients_providers
    has_many :journals
    has_many :notes, through: :journals
  end
end
