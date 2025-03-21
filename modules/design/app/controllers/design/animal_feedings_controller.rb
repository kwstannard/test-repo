module Design
  class AnimalFeedingsController < ApplicationController
    def index
    end

    def create
      animal = Animal.const_get(params[:animal_feeding][:animal_type]).new
      food = Food.const_get(params[:animal_feeding][:food_type]).new

      flash.now[:notice] = AnimalFeeding.new(animal: animal, food: food).call
      render :index
    end
  end
end
