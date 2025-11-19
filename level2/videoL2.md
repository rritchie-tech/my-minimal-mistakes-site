---
layout: listing
title: Video Services
subtitle: clear witness + caring service
thisurl: videoL2/index.html
level: 2
parent: Online Services
gh-repo: daattali/beautiful-jekyll
gh-badge: [star, fork, follow]
tags: [test]
comments: true
mathjax: true
author: Rick Ritchie
---
{% assign LitCalDates_string = "June 8, 2025|June 15, 2025|June 22, 2025|June 29, 2025|July 6, 2025|July 13, 2025|July 20, 2025|July 27, 2025|August 3, 2025|August 10, 2025|August 17, 2025|August 24, 2025" %}
{% assign LitCalDates_Array = LitCalDates_string | split: "|" %}
{% assign LitCalTitles_string = "The Day of Pentecost,
The Second Sunday after Pentecost,
The Third Sunday after Pentecost,
The Fourth Sunday after Pentecost,
The Fifth Sunday after Pentecost,
The Sixth Sunday after Pentecost,
The Seventh Sunday after Pentecost,
The Eighth Sunday after Pentecost,
The Ninth Sunday after Pentecost,
The Tenth Sunday after Pentecost,
The Eleventh Sunday after Pentecost" %}
{% assign LitCalTitles_Array = LitCalTitles_string | split: "," %}
{% assign today_timestamp = site.time | date: '%s' %}
{% assign DayToday = site.time | date: '%a' %}
{% assign Weekdays_string = "Sun,Mon,Tue,Wed,Thu,Fri,Sat" %}
{% assign Weekdays_Array = Weekdays_string | split: ',' %}
{% assign previd = "site.data.service_videos.iframes" %}
{% assign weekseconds = 604800 %}
{% for dy in Weekdays_Array %}
	{% if dy == DayToday %}
		{% if dy == "Sun" %}
			{% assign DayNo = 0 %}
			{% assign seconds = 0 %}
			{% assign firstSunday_timestamp = today_timestamp %}
			{% assign firstSunday_date = today_timestamp | date: "%m/%d/%Y" %}
			{% assign firstSunday_long = today_timestamp | date: "%B %-d, %Y" %}
		{% else %}
			{% assign DayNo = forloop.index | minus: 1 %}
			{% assign seconds = DayNo | times: 24 | times: 60 | times: 60 %}
			{% assign firstSunday_timestamp = today_timestamp | minus: seconds %}
			{% assign firstSunday_date = firstSunday_timestamp | date: "%m/%d/%Y" %}
			{% assign firstSunday_long = firstSunday_timestamp | date: "%B %-d, %Y" %}
		{% endif %}
		{% assign nextSunday_timestamp = firstSunday_timestamp | plus: weekseconds %}
		{% break %}
	{% endif %}
{% endfor %}
{% assign priorSunday_timestamp = nextSunday_timestamp %}
{% for item in LitCalDates_Array %}
	{% assign short_dat = item | date: "%m/%d/%Y" %}
	{% if short_dat == firstSunday_date %}
		{% assign SunNum = forloop.index %}
	{% break %}
	{% endif %}
    {% unless forloop.last %}
	{% endunless %}
{% endfor %}
<div class="site-vidlinks">
{% for i in (2..7) %}
	{% assign priorSunday_timestamp = priorSunday_timestamp | minus: weekseconds %}
	{% assign priorSunday_long = priorSunday_timestamp | date: "%B %-d, %Y" %}
	{% assign priorSunday_short = priorSunday_timestamp | date: "%m%d%y" %}
	{% assign datindex = SunNum | minus: i %}
	<BR><BR>
	<span>
	<h3>Divine Service – {{ priorSunday_long }}</h3>
	<p>{{ LitCalTitles_Array[ datindex ] }}  (8:00am livestream)</p>
	{% assign dat_url = priorSunday_short | append: ".html" %}
	<!-- At this point I need to decide how to handle Sunday day videos. -->
	<!-- Before 1pm, I think I should just post the standard url -->
	<!-- After that time, I should check for the new one -->
	<!-- But I could have the files preloaded with the standard one. -->
	
	{% for service in site.data.service_videos.services %}
		{% if priorSunday_short == service.date %}
    {{ service.iframe }}
	<BR>
	<BR>
			{% assign thisSunBulletinDate = priorSunday_timestamp | date: "%-m-%-d-%Y" %}
			{% assign thisSunBulletinYear = priorSunday_timestamp | date: "%Y" %}
			{% assign thisSunBulletinMonth = priorSunday_timestamp | date: "%m" %}
			{% assign thisPDF1 = thisSunBulletinYear | append: "/" %}
			{% assign thisPDF2 = thisSunBulletinMonth | append: "/" %}
			{% assign thisPDF3 = thisSunBulletinDate | append: "-" %}
			{% assign thisPDF4 = LitCalTitles_Array[ datindex ] | strip | replace: "The ","" | replace: " ","-" %}
			{% assign thisPDF = "https://redeemer-lutheran.net/wp-content/uploads/" | append: thisPDF1 | append: thisPDF2 | append: thisPDF3 | append: thisPDF4 | append: ".pdf" %}                 
	<a href="{{ thisPDF }}">Service Bulletin: {{ thisPDF4 }}.pdf</a>
	<BR><BR>
	</span>
		{% break %}
        {% endif %}
	{% endfor %}
{% endfor %}
</div>