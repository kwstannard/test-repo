module Design
  class Food
    include ActiveModel::Model
    class << self
      def types
        subclasses.map { _1.model_name.human }
      end
    end

    class DogFood < self; end
    class CatFood < self; end
    class Chicken < self; end
    class Milk < self; end
  end
end
