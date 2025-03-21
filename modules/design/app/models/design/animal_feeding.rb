module Design
  class AnimalFeeding
    include ActiveModel::Model
    attr_accessor :animal, :food
    validates_presence_of :animal, :food

    def call
      animal.feed(food)
    end
  end
end
