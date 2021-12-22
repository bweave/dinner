class SuggestionsController < ApplicationController
  def show
    @suggestions = Dinner.order(:last_suggested_at).limit(10).shuffle.take(4)
  end
end
