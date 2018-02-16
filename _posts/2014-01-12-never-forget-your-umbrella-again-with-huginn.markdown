---
layout: post
title: "Never Forget Your Umbrella Again, with Huginn"
date: 2014-01-12 10:43
comments: true
categories: [ruby, tools, huginn]
---
[Huginn](https://github.com/cantino/huginn) is a tool that I've been working on, with the support of generous open source collaborators, for about a year.  Huginn is a light-weight infrastructure for building data-gathering and data-reacting tasks for your everyday life.  Think of it as an open source Yahoo! Pipes, IFTTT, or Zapier.  It wouldn't surprise me if, in the future, Huginn evolves into something like Google Now, but without the creepiness factor, because you control and host your own data.

I haven't done a very good job of sharing all of the things that can be built with Huginn, but I'm resolved to start.

So, in this post, a very simple example:

**Problem**: I always forget to check the weather, leave my umbrella at home, and get soaked.<br />
**Solution**: Let Huginn send you an email (or SMS) each morning when rain is expected in your area.

<!--more-->

After having setup Huginn on your server, make a new WeatherAgent:

{% img /images/posts/huginn/new-agent.png %}

You'll just need to give it your zipcode (or location code) and a [free API key for Wunderground](http://www.wunderground.com/weather/api/).  Set the agent to run at 10pm, so that the data it gathers is for tomorrow's weather.

{% img /images/posts/huginn/sf-weather-agent.png %}

Once you've saved your new WeatherAgent, it's time to setup a TriggerAgent.  You'll want to set its source as the WeatherAgent that you just created.

{% img /images/posts/huginn/rain-alert-agent.png %}

TriggerAgents contain a set of rules, all of which must match for the trigger to fire.  In this case, we only need one rule to match against the `conditions` property of the Wunderground API weather events.  We'll do a regular expression (`regex`) match against this property, looking for the words "rain" or "storm".  When the trigger fires, it will output an event with the message "Take an umbrella!  It looks like '&lt;conditions>' tomorrow in '&lt;location>'".  These &lt;...> fields will be filled in by the corresponding properties from the events being filtered-- in this case, just events from your WeatherAgent.  This screenshot shows the Agent's options being edited as JSON so that it's easier for you to read.  You can use either editor mode.

Finally, we just need an Agent to email us the TriggerAgent's events.  We'll use a DigestEmailAgent for this because it queues incoming events until a specific time, then sends them all at once.  You could, however, use a normal EmailAgent to send the email right away, or a TwilioAgent to send an SMS.

Set the agent's schedule to run at 6am, so that you wake up to an email.  Set it's source as the Rain Alert agent you just created.

{% img /images/posts/huginn/digest-email-agent.png %}

And that's it!  You'll now receive an email at 6am any morning when rain is expected in your area.  Stay dry!

I'll be posting more examples soon.  Please let me know what sort of Huginn tutorials you'd like to see!
