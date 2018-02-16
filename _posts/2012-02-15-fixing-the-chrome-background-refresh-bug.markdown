---
layout: post
title: "Fixing the Chrome background refresh bug"
date: 2012-02-15 11:55
comments: true
categories: [chrome, javascript]
---
There is a [bug in the current version of Chromium](http://code.google.com/p/chromium/issues/detail?id=111218#makechanges) (hence Google Chrome) that sometimes fails to redraw CSS background images when they're hidden and then re-shown.  This issue appeared on [Mavenlink's Tour](http://mavenlink.com/tour) page.  Thomas Fuchs [discusses some possible solutions](http://mir.aculo.us/2011/12/07/the-case-of-the-disappearing-element/), but none of those worked for us.  Here is our ugly solution:

{% gist 1838523 %}

Please let me know if you find something better!