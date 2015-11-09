class LandingsController < ApplicationController

  def recuit
  end

  def about
  end

  def qa
  end

  def contact
    @feedback = Feedback.new
  end

end
