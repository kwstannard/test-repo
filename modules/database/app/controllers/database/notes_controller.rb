module Database
  class NotesController < ApplicationController
    def new
      @journal = Journal.find(params[:journal_id])
      @note = @journal.notes.new
    end

    def create
      journal = Journal.find(params[:journal_id])
      note = journal.notes.new(form_params)
      note.save!
      redirect_to client_journal_path(journal.client_id, journal)
    end

    def form_params
      params.require(:note).permit(:text)
    end
  end
end
