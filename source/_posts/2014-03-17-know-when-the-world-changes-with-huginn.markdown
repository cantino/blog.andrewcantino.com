---
layout: post
title: "Know when the world changes-- with Huginn"
date: 2014-03-17 14:04:09 -0700
comments: true
categories: [ruby, tools, huginn]
---
This is my second post about [Huginn](https://github.com/cantino/huginn), a tool that I've been working on with the generous support of other open source collaborators. Huginn is a light-weight platform for building data-gathering and data-reacting tasks for everyday life. Think of it as an open source Yahoo! Pipes, IFTTT, or Zapier.

In this post I will show you how to setup standing alerts about the world; basically, your Huginn will be able to answer arbitrary requests like "Tell me when the date of the next Superbowl is announced", "Tell me when we discover gravity waves", or "Tell me when there is a tsunami headed toward San Francisco".

**Problem**: I often think of events that I'd like to be alerted of, but frequently miss them in the news.<br />
**Solution**: Let Huginn watch the news (via Twitter) and alert you when there are spikes of interest around topics that you care about.

{% img /images/posts/huginn/gravity-waves-detected.png %}

<!--more-->

After having [setup Huginn on your server](https://github.com/cantino/huginn), you will need to create some Twitter credentials. Follow [these instructions on the Huginn Wiki](https://github.com/cantino/huginn/wiki/Configuring-OAuth-applications) to register a Twitter Application and install it in your Huginn instance by editing the `.env` file.

Now that you've finished setting up a Twitter Application and have restarted your Huginn instance, you should visit the Services page and click "Authenticate with Twitter".  Twitter will ask you to login and authorize your new Twitter Application.  When you do this, you should see a new Service in Huginn with your Twitter username.

Now, finally, you're ready to make a TwitterStreamAgent! _"The TwitterStreamAgent follows the Twitter stream in real time, watching for certain keywords, or filters, that you provide."_  For this article, we're going to use a new TwitterStreamAgent to watch keywords of interest on Twitter and to tell us, every 30 minutes, how many times each keyword has been seen. This technique works great for common keywords, but not very well for rare ones. If you want to track rare keywords, like a unique product name, you could make a second TwitterStreamAgent and set it to generate `events` instead of `counts`, and then have these emailed to you whenever they occur.

Okay, so set your new TwitterStreamAgent to run every `30 minutes`, keep events for `7 days`, and generate `counts`.  For the `filters` section you could enter `superbowl date announced`, `gravity waves detected`, and `huginn open source`.  Your Agent will keep track of each of these terms independently.

Your screen should now look something like this:

{% img /images/posts/huginn/new-twitter-stream-agent.png %}

Next, let's setup a new PeakDetectorAgent. A PeakDetectorAgent is used to detect rising edges in a stream of data. In our case, we want to look for spikes in the Twitter event counts. The only change from the default here is to put "std\_multiple" to `5` instead of `3`. This is up to you, and just tunes how sensitive the agent will be, with higher numbers requiring larger spikes before detection. If you get too many or too few alerts, you can customize this value.  (Here `std` stands for Standard Deviation.  Your data is likely not actually Gaussian, but STD still makes a nice tuning factor.)

{% img /images/posts/huginn/new-peak-detector-agent.png %}

If you let your Huginn run for a while, wait for some scientific revolutions to occur, and then click "Show", you might see something like this:

{% img /images/posts/huginn/gravity-waves-detected.png %}

If you want, you can stop here. This is technically all you need! Just send the output of your new PeakDetectorAgent to an email or email digest agent, and you'll receive alerts as interest spikes on Twitter. However, I recommend adding one more Agent to the flow in order to improve readability: an EventFormattingAgent.

{% img /images/posts/huginn/new-event-formatting-agent.png %}

This Agent will format the JSON output from the peak detector into a more readable format with a link to search Twitter and see what the commotion is about. Now, connect this to an email agent, and you're done!

{% img /images/posts/huginn/afternoon-digest-agent.png %}

This example Huginn Agent flow has a medium response time-- it responds 30-60 minutes after an interest spike starts on Twitter. Some topics demand a faster response time, like "san francisco tsunami warning", "flash ticket sale", or "stock market crashing". To handle alerts like these, I run a different TwitterStreamAgent and PeakDetectorAgent, with the TwitterStreamAgent checking every 2 minutes, the PeakDetectorAgent set to do immediate propagation.  Resulting peaks are sent directly to an email or SMS agent instead of a email digest, so that I get alerted right away.

For more ideas and updates around Huginn, please [get involved](https://github.com/cantino/huginn) and [follow me on Twitter](https://twitter.com/tectonic)!