---
title: Course Units
permalink: /units.html
sidebar:
        nav: "units" 
---

## Unit 01
{% for item in site.unit01 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## Unit 02
{% for item in site.unit02 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## Unit 03
{% for item in site.unit03 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## Unit 04
{% for item in site.unit04 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}

## Unit 05
{% for item in site.unit05 %}
  <p><a href="{{ item.url | prepend: site.baseurl}}">{{ item.title }}</a></p>
{% endfor %}