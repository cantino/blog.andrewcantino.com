---
layout: post
title: "Adding RSS feeds to any site with Huginn"
date: 2014-04-13 11:28:15 -0700
comments: true
categories: [ruby, tools, huginn]
---
This is my third post about [Huginn](https://github.com/cantino/huginn), a tool that I've been working on with the generous support of other open source collaborators. Huginn is a light-weight platform for building data-gathering and data-reacting tasks for everyday life. Think of it as an open source Yahoo! Pipes, IFTTT, or Zapier.

In this post I will show you how to create an RSS feed for a website that doesn't have one, using Huginn.

**Problem**: Many sites don't have RSS feeds.<br />
**Solution**: Let Huginn watch the site for changes and build a feed for you.

<!--more-->

Let's use (the amazing webcomic) [XKCD](http://xkcd.com) as an example.  XKCD doesn't have an RSS feed, so let's create one.

{% img /images/posts/huginn/xkcd-agent.png %}

(If you setup Huginn and ran `rake db:seed`, you'll already have this Agent.)

Now, let's make a DataOutputAgent to convert events from the XKCD Agent into a RSS feed.

{% img /images/posts/huginn/xkcd-rss-agent.png %}

(When you make a new DataOutputAgent, the default options are actually this example.)

Finally, visit the Agent to see the new RSS URL for your XKCD feed.

{% img /images/posts/huginn/xkcd-rss-agent-show.png %}

And that's it!  Now you have an RSS feed of recent XKCD comics, even though xkcd.com doesn't provide such a feed on its own.  Let this run for a while and a full RSS feed will be built.

If you found this interesting, you should also read my [previous posts on Huginn](http://blog.andrewcantino.com/blog/categories/huginn/).