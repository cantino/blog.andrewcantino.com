---
layout: post
title: "Multiple profiles in Chrome on Ubuntu"
alias: "/post/423694926/multiple-profiles-in-chrome"
date: 2010-03-02 18:03
comments: true
categories: tools
---
If you&#8217;re running Chrome on Ubuntu (likely elsewhere too), you can run multiple copies of Chrome with fully different profiles by launching it with the <code>--user-data-dir</code> option.  For example, I run two copies of Chrome like so:

    /opt/google/chrome/google-chrome --user-data-dir=~/.config/google-chrome-work &amp;
    /opt/google/chrome/google-chrome --user-data-dir=~/.config/google-chrome-personal &amp;
