module Database
  class ClientsController < ApplicationController
    def new
      @client = Client.new
    end

    def create
      @client = Client.new(form_params)

      @client.save!

      new
    end

    def form_params
      params.require(:client).permit(:name, :plan, :email)
    end
  end
end
