---
title: Course Units
permalink: /units.html
sidebar:
        nav: "units" 
---

## 01 First Things First
{% for item in site.unit01 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## 02 First Things Second
{% for item in site.unit02 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## 03 Look at Your Data
{% for item in site.unit03 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}
