module Database
  class ClientsProvider < ApplicationRecord
    self.primary_key = [:client_id, :provider_id]
    PLANS = ["Basic", "Premium"]
    enum :plan, PLANS.then { _1.zip(_1) }.to_h, default: "Basic"

    belongs_to :provider
    belongs_to :client

    def self.all
      super.joins(:provider).select('database_providers.*, database_clients_providers.*')
    end

    def other_plan
      PLANS.detect { _1 != plan }
    end
  end
end
