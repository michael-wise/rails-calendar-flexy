class PageController < ApplicationController
  def home
  	@showMainCal = true
  	if @showMainCal
  		# render :deadView
  	end
  	setCurrentMonth

  end

  def setCurrentMonth
  	@monthByWeek = Calendar.new.arrayByWeek
  	@monthByDay = Calendar.new.arrayByDay
  	# @nextMonth = Calendar.new(Date.today.months_since(1)).to_a
  	# @firstWeek= [@month[0]]
  end

  def deadView

  end


end
