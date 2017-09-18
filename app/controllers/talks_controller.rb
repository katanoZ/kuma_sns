class TalksController < ApplicationController
  def show
    @talks = Talk.all
  end
end
