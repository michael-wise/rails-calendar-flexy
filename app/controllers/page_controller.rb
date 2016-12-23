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
  	# @firstWeek= [@month[0]]
  end

  def deadView

  end


end
