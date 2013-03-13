---
layout: post
title: "Archive a PDF of your Posterous blog"
date: 2013-03-12 23:23
comments: true
categories: tools, archival
---
My wife and I had a private travel blog on Posterous.  Unfortunately, Posterous got aquihired by Twitter and is shutting down, so I spent a few minutes figuring out how to save a PDF of the blog.  Chrome and Firefox did pretty poorly at saving a decent looking PDF for my long blog so I installed wkhtmltopdf and made one myself.  Here's how.

Install [wkhtmltopdf](http://code.google.com/p/wkhtmltopdf/), then run:

    wkhtmltopdf --enable-plugins --margin-bottom 0 --margin-top 0 --margin-left 0 --margin-right 0 "http://yourblog.com" archive.pdf

If your blog has a password, log in with a browser and copy the cookie.  Firefox makes this easy in the Developer Toolbar by entering `cookie list`.

    wkhtmltopdf --cookie cookiename cookievalue ...
 
Finally, if you're on a Mac and used the pre-built wkhtmltopdf disk image, you can still use the command line.

    /path/to/wkhtmltopdf.app/Contents/MacOS/wkhtmltopdf ...
