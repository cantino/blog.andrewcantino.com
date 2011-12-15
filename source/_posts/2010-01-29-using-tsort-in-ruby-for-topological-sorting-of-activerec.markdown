---
layout: post
title: "Using TSort in Ruby for Topological Sorting of ActiveRecord Models"
alias: "/post/360067015/using-tsort-in-ruby-for-topological-sorting-of-activerec"
date: 2010-01-29 18:03
comments: true
categories: ruby
---
<p>Recently, I was building a project list application in Rails and I needed to be sure that sub-projects showed up in the list somewhere below their parents.</p>

<p>A <a title="topolocal sorting" href="http://en.wikipedia.org/wiki/Topological_sorting">topological sort</a> does just what I needed, and I was pleased to discover that Ruby ships with a <a title="TSort" href="http://ruby-doc.org/stdlib/libdoc/tsort/rdoc/classes/TSort.html">TSort</a> module.  Here is how I extended Array to allow sorting of Projects:</p>

{% gist 290045 %}

<span style="font-size: 0.8em">(Aside: I later post-processed the list to indent sub-projects and position them just below their parents.  This post-processing was made easier by the fact that all sub-projects were already somewhere below their parents in the list.)</span>
