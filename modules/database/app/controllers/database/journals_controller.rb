module Database
  class JournalsController < ApplicationController
    def new
      @journal = Journal.new
      @client = Client.new(id: params[:client_id])
    end

    def create
      journal = Client.find(params[:client_id]).journals.new(form_params)
      journal.save!
      redirect_to new_journal_note_path(journal)
    end

    def show
      @journal = Journal.find(params[:id])
    end

    def form_params
      params.require(:journal).permit(:name)
    end
  end
end
