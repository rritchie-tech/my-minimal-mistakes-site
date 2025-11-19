---
layout: listing
title: YAML test
subtitle: clear witness + caring service
thisurl: yamlL2/index.html
level: 2
parent: Online Services
gh-repo: daattali/beautiful-jekyll
gh-badge: [star, fork, follow]
tags: [test]
comments: true
mathjax: true
author: Rick Ritchie
---
<h1>Members</h1>
<ul>
    {% for service in site.data.service_videos.services %}
        <li>{{ service.name }} - {{ service.iframe }}</li>
    {% endfor %}
</ul>
