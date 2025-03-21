module Design
  class Animal
    include ActiveModel::Model
    class_attribute :likes, :talk

    class << self
      def types
        subclasses.map { _1.model_name.human }
      end
    end

    def feed(food)
      case food
      when *likes
        talk
      end
    end

    class Cat < self
      self.likes = [Food::CatFood, Food::Chicken]
      self.talk = "Meow"
    end
    class Dog < self
      self.likes = []
      self.talk = "Bark"
    end
  end
end
