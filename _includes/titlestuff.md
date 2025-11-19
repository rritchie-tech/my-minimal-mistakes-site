---
thisurl: titlestuff.html
---
<div class="titlestuff {% if page.cover-img %} big-img {% endif %}">
	{% if page.cover-img or page.title %}
					<div class="container-md">
						<div class="level-{{ page.level }}-heading">
							<h1>{% if page.title %}{{ page.title | strip_html }}{% else %}<br/>{% endif %}</h1>
						{% if page.subtitle %}
							{% if include.type == "page" %}
							<hr class="small">
							<span class="subheading">{{ page.subtitle | strip_html }}</span>
							{% else %}
							<h2 class="subheading">{{ page.subtitle | strip_html }}</h2>
							{% endif %}
						{% endif %}
						  
						{% if include.type == "post" %} 
							{% if page.author %}
									By<strong>{{ page.author | strip_html }}</strong><br>
							{% endif%}
							<span class="post-meta">Posted on {{ page.date | date: date_format }}</span>
							{% if page.last-updated %}
							<span class="post-meta">
								<span class="d-none d-md-inline middot">&middot;</span>
								  Last updated {{ page.last-updated | date: date_format }}
							</span>
							{% endif %}
							{% if page.readtime %}
							  {% include readtime.html %}
							{% endif %}
						{% endif %}
						</div>
					</div>
	{% endif %}
	{% if page.cover-img %}<span class='img-desc'></span>{% endif %}
				</div>