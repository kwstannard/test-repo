module Database
  class Provider < ApplicationRecord
    has_and_belongs_to_many :clients
  end
end
