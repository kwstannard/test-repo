module Database
  class Note < ApplicationRecord
    belongs_to :journal
  end
end
