module Database
  class Client < ApplicationRecord
    enum(:plan, %w[Premium Basic].then{ _1.zip(_1) }.to_h)
  end
end
