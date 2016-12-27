# README
This rails application uses a Ruby Calendar class with several methods, and a view which shows the calendar in the sidebar as a list, or conditionally, in the main section in the typical calendar month layout. 

## The interesting parts
#### lib/assets/calendar.rb
This file is initialized in config/initializers/assets.rb.

Contains a few Ruby classes which piecewise construct arrays containing days of the month.
The arrayByWeek method produces an array of weeks, where each week is an array of days, where each day is an array of [date object, "logic-driven css classes"]. 
The arrayByDay method produces all of the days above without being grouped into weeks.
```Ruby 
Calendar.new.arrayByWeek #is an array of Weeks.
=begin 
  [[[Sun, 27 Nov 2016, "past otherMonth"], [Mon, 28 Nov 2016, "past otherMonth"], [Tue, 29 Nov 2016, "past otherMonth"], [Wed, 30 Nov 2016, "past otherMonth"], [Thu, 01 Dec 2016, "past"], [Fri, 02 Dec 2016, "past"], [Sat, 03 Dec 2016, "past"]],
    [[Sun, 04 Dec 2016, "past"], [Mon, 05 Dec 2016, "past"], [Tue, 06 Dec 2016, "past"], [Wed, 07 Dec 2016, "past"], [Thu, 08 Dec 2016, "past"], [Fri, 09 Dec 2016, "past"], [Sat, 10 Dec 2016, "past"]],
    [[Sun, 11 Dec 2016, "past"], [Mon, 12 Dec 2016, "past"], [Tue, 13 Dec 2016, "past"], [Wed, 14 Dec 2016, "past"], [Thu, 15 Dec 2016, "past"], [Fri, 16 Dec 2016, "past"], [Sat, 17 Dec 2016, "past"]],
    [[Sun, 18 Dec 2016, "past"], [Mon, 19 Dec 2016, "past"], [Tue, 20 Dec 2016, "past"], [Wed, 21 Dec 2016, "today"], [Thu, 22 Dec 2016, "future"], [Fri, 23 Dec 2016, "future"], [Sat, 24 Dec 2016, "future"]],
    [[Sun, 25 Dec 2016, "future"], [Mon, 26 Dec 2016, "future"], [Tue, 27 Dec 2016, "future"], [Wed, 28 Dec 2016, "future"], [Thu, 29 Dec 2016, "future"], [Fri, 30 Dec 2016, "future"], [Sat, 31 Dec 2016, "future"]]]
=end
Calendar.new.arrayByDay #is an array of all days in a month without being grouped into weeks.
Calendar.new.arrayByDay[0] #would give [Sun, 27 Nov 2016, "past otherMonth"]
```
For quick testing/dev in irb without rails, Calendar.rb has the necessary active_support core extensions (commented out).

#### controllers/page_controller.rb
Contains `@showMainCal= true` for showing or hiding the main calendar view. SideBar calendar list is currently always displayed. 
The (root) home action calls the method setCurrentMonth to instantiate calendar.rb.

#### views/layouts/application.html.erb
Uses a partial to render the nav `views/page/_nav.html.erb` and yields it `yield :navigation` (btw, the navbar is Materialize CSS).
  Yields `yield :sideBarDay`.
  And conditionally  yields `yield :mainCalendar`.


* ...
