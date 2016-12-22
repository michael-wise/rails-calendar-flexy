# require 'active_support/core_ext/date'
# require 'active_support/core_ext/time'
# require 'active_support/core_ext/array'
# irb -I . -r calendar.rb

#Calendar.new.to_a Data Examples:

#Calendar.new.to_a is an array of Weeks[].
	#-> [[[Sun, 27 Nov 2016, "past otherMonth"], [Mon, 28 Nov 2016, "past otherMonth"], [Tue, 29 Nov 2016, "past otherMonth"], [Wed, 30 Nov 2016, "past otherMonth"], [Thu, 01 Dec 2016, "past"], [Fri, 02 Dec 2016, "past"], [Sat, 03 Dec 2016, "past"]], [[Sun, 04 Dec 2016, "past"], [Mon, 05 Dec 2016, "past"], [Tue, 06 Dec 2016, "past"], [Wed, 07 Dec 2016, "past"], [Thu, 08 Dec 2016, "past"], [Fri, 09 Dec 2016, "past"], [Sat, 10 Dec 2016, "past"]], [[Sun, 11 Dec 2016, "past"], [Mon, 12 Dec 2016, "past"], [Tue, 13 Dec 2016, "past"], [Wed, 14 Dec 2016, "past"], [Thu, 15 Dec 2016, "past"], [Fri, 16 Dec 2016, "past"], [Sat, 17 Dec 2016, "past"]], [[Sun, 18 Dec 2016, "past"], [Mon, 19 Dec 2016, "past"], [Tue, 20 Dec 2016, "past"], [Wed, 21 Dec 2016, "today"], [Thu, 22 Dec 2016, "future"], [Fri, 23 Dec 2016, "future"], [Sat, 24 Dec 2016, "future"]], [[Sun, 25 Dec 2016, "future"], [Mon, 26 Dec 2016, "future"], [Tue, 27 Dec 2016, "future"], [Wed, 28 Dec 2016, "future"], [Thu, 29 Dec 2016, "future"], [Fri, 30 Dec 2016, "future"], [Sat, 31 Dec 2016, "future"]]]
#Calendar.new.to_a[0] is an array of Days[].
	#-> [[Sun, 27 Nov 2016, "past otherMonth"], [Mon, 28 Nov 2016, "past otherMonth"], [Tue, 29 Nov 2016, "past otherMonth"], [Wed, 30 Nov 2016, "past otherMonth"], [Thu, 01 Dec 2016, "past"], [Fri, 02 Dec 2016, "past"], [Sat, 03 Dec 2016, "past"]]
#Calendar.new.to_a[0][0] is an array of DateObject, "css strings".
	#-> [Sun, 27 Nov 2016, "past otherMonth"]


class Calendar
	def initialize(date=Date.today)
		@date=date
	end

	def arrayByDay
		MakeMonth.new(@date).byDays.map do |date|
			[date, DayStyles.new(date).to_s]
		end
	end

	def arrayByWeek
		MakeMonth.new(@date).byWeeks.map do |week|
			week.map do |date|
				[date, DayStyles.new(date).to_s]
			end
		end
	end
end

class DayStyles
	def initialize(date)
		@date = date
	end

	def to_s
		[past, today, future, otherMonth].compact.join(" ")
	end
private
	def past
		"past" if @date < Date.today
	end
	def today
		"today" if @date == Date.today
	end
	def future
		"future" if @date > Date.today
	end
	def otherMonth
		"otherMonth" if @date.month != Date.today.month
	end
end

class MakeMonth
 	def initialize(date=Date.today)
 		@date=date
 	end

 	def byDays
 		(first_calendar_day..last_calendar_day).to_a
 	end
 	def byWeeks
 		byDays.in_groups_of(7)
 	end


private

	def first_calendar_day 
		@date.beginning_of_month.beginning_of_week(:sunday)
	end
	def last_calendar_day 
		@date.end_of_month.end_of_week(:sunday)
	end

 end

