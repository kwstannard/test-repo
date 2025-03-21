module Design
  class Animal
    include ActiveModel::Model
    class << self
      def types
        subclasses.map { _1.model_name.human }
      end
    end

    class Cat < self; end
    class Dog < self; end
  end
end
