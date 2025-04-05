module Database
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    establish_connection(:database)
  end
end
