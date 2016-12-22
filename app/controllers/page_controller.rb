class PageController < ApplicationController
  def home
  	docalendar
  end

  def docalendar
  	@month = Calendar.new.to_a
  	# @nextMonth = Calendar.new(Date.today.months_since(1)).to_a
  	@firstWeek= [@month[0]]

  end

end
