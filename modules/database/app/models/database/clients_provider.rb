module Database
  class ClientsProvider < ApplicationRecord
    module Foo
      extend ActiveSupport::Concern

      included do
        self.primary_key = [:client_id, :provider_id]
        PLANS = ["Basic", "Premium"]
        enum :plan, PLANS.then { _1.zip(_1) }.to_h, default: "Basic"

        belongs_to :provider
        belongs_to :client

        singleton_class.alias_method :old_all, :all
        def self.all
          old_all.joins(:provider).select('providers.*, clients_providers.*')
        end

        def other_plan
          PLANS.detect { _1 != plan }
        end
      end
    end

    include Foo
  end
end
