module Database
  class Journal < ApplicationRecord
    belongs_to :client
    has_many :notes
  end
end
