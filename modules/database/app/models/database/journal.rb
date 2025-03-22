module Database
  class Journal < ApplicationRecord
    belongs_to :client
  end
end
