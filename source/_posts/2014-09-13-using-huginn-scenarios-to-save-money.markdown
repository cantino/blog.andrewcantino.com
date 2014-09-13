---
layout: post
title: "Using Huginn Scenarios to Save Money"
date: 2014-09-13 11:19:40 -0700
comments: true
categories: 
---
This is my fourth post about [Huginn](https://github.com/cantino/huginn), a tool that I've been working on with the generous support of other open source collaborators. Huginn is a light-weight platform for building data-gathering and data-reacting tasks for everyday life. Think of it as an open source Yahoo! Pipes, IFTTT, or Zapier.

In this post I will show you how to setup money-saving deal alerts with Huginn, and then share those alerts with other Huginn users using our new Scenarios system.

**Problem**: I love deal sites, but don't want to check them every day.<br />
**Solution**: I'll let Huginn keep an eye on deal sites, and alert me when new interesting deals are available.

<!--more-->

Since we're planning to share this alert with our friends, let's start by making a new Huginn Scenario.  In Huginn, Scenarios are useful for two things: 1) grouping sets of Huginn Agents for easy navigation, and 2) sharing sets of Agents.

Here are some of my Scenarios:

{% img /images/posts/huginn/slickdeals-post/some-scenarios.png %}

Okay, let's make a new shared Scenario to hold Agents that monitor Slickdeals.

{% img /images/posts/huginn/slickdeals-post/new-scenario.png %}

Now, make a new RssAgent to consume the Slickdeals data.  For the `url`, use `http://feeds.feedburner.com/SlickdealsnetFP?format=atom`.

{% img /images/posts/huginn/slickdeals-post/new-rss-agent.png %}

I set my RssAgent to consume the Slickdeals RSS feed once an hour, emitting new events for each entry.  I only keep the events for 7 days, since it will save space, and I doubt I'll want to look back at them.  Notice that I put the new Agent in the Scenario that I had just created.

I clicked "Run" on the new RssAgent and gave it a moment to create its first batch of events.  I clicked on the Events link in the Agent and viewed one of the new events:

{% img /images/posts/huginn/slickdeals-post/slickdeals-event.png %}

Based on this, let's now make a TriggerAgent to watch the RSS feed for interesting items:

{% img /images/posts/huginn/slickdeals-post/new-trigger-agent.png %}

For the options, I did something like this:

{% raw %}
``` json
{
  "expected_receive_period_in_days": "30",
  "rules": [
    {
      "type": "regex",
      "value": "skyrim|fandango",
      "path": "title"
    }
  ],
  "message": "{{title}}: {{urls | first}}"
}
```
{% endraw %}

This configuration should trigger on any title that has the word "skyrim" or "fandango" in it.  I did this because I'm looking for a deal on the Skyrim game, and also for discounted movie ticket deals.  You can do anything you'd like here!  Notice that I used the Liquid syntax `{% raw %}{{urls | first}}{% endraw %}` to grab the first url from the event, based on the fact (visible in the Event image above) that it contains an array of urls.

Finally, I wired this to an email Agent so that I receive quick emails when new deals show up:

{% img /images/posts/huginn/slickdeals-post/email-agent.png %}

Happy with this new Scenario, I copied the URL from the "Share" page of the Scenario and sent it to my friends! :)

Questions?  [Follow me on Twitter](https://twitter.com/tectonic)!