# README
This rails application uses a Ruby Calendar class with several methods, and a view which shows the calendar in the sidebar as a list, or conditionally, in the main section in the typical calendar month layout. It is based on the RBY.IO #3 tutorial by Jim OKelly (https://www.youtube.com/watch?v=lzav4zcDvgw&), with the layout converted to CSS3 flex. I've since rewrote much of calendar.rb to integrate it into another project which uses Devise, Facebook Oauth, database models (for users & voting), and ajax for the calendar. It may be available soon as a separate repository (current date 1-16-17). 

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

#### views/page/home.html.erb
Checks if @showMainCal is true or false, conditionally creating `content_for :mainCalendar`. The section would be titled with `<%= @monthByWeek[1][3][0].strftime('%B') %>` which displays the name of the current month (according to the 4th day of the 2nd week). It renders the partials `views/page/_headers.htmlerb` and `views/page/_week`, the latter of which is rendered 5 times due to `<%= render partial: 'week', collection: @monthByWeek %>`
#### views/page/headers.html.erb
```Ruby
#_headers.html.erb
<div class="calRow">
	<div class="calCol">Sunday</div>
	<div class="calCol">Monday</div>
	<div class="calCol">Tuesday</div>
	<div class="calCol">Wednesday</div>
	<div class="calCol">Thursday</div>
	<div class="calCol">Friday</div>
	<div class="calCol">Saturday</div>
</div>
```
#### views/page/_week.html.erb
```Ruby
#_week.html.erb
<div class="week calRow">
	<%= render partial: "day", collection: week %>
</div>
```
The `_week.html.erb` partial is in-turn rendered 7 times `<%= render partial: "day", collection: week %>`
#### views/page/_day.html.erb
```Ruby
<div data-date="<%= day[0].strftime('%d') %>" class="day calCol <%= day[1] %>">
</div>
```
The `_day.html.erb` partial creates divs containing the css classes generated in `calendar.rb` and data attributes i.e. `data-date=14` to later be hooked into or displayed using css `content: attr(data-data)` (in `app/assets/stylesheets/mainCalendar.scss`).
#### views/page/_sideBarDay.html.erb
`_sideBarDay.html.erb` is a partial that is unconditionally rendered from `home.html.erb` and iterates over the `collection: @monthByDay`. It inserts a div designating the month name if the appropriate month name has not yet been predicated. The first case is trivial and happens for the first day of any month `(sideBarDay[0].strftime('%e').to_i == 1)`. The second case `(@countVar==nil)` titles the last several days of the last month, which almost always occur on a calendar page (that is, Sunday Nov 27th 2016 needs to be titled November for the monthview of December 2016).
```Ruby
<% content_for :sideBarDay do %>
	
	<% if (sideBarDay[0].strftime('%e').to_i == 1) or (@countVar==nil)  %>
		<% @countVar ||= 1 %>
		<div class="month">
			<%= sideBarDay[0].strftime('%B %Y') %>
		</div>
	<%end%> 
	
	<div data-month="<%= sideBarDay[0].strftime('%B') %>" 
		class="day <%= sideBarDay[1] %>">
		<span class="left"><%= sideBarDay[0].strftime('%a %d') %></span>
		<span class="dayContent right">
			<%= "-static content-" %>
		</span>

	</div>
<% end %>
```


* ...
