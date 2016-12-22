class PageController < ApplicationController
  def home
  	docalendar
  end

  def docalendar
  	@month = Calendar.new.arrayByWeek
  	@monthByDay = Calendar.new.arrayByDay
  	# @nextMonth = Calendar.new(Date.today.months_since(1)).to_a
  	@firstWeek= [@month[0]]

  end

end
