---
layout: post
title: "How to make your Rails app tweet the Twitter"
alias: "/post/5438091418/how-to-make-your-rails-app-tweet-the-twitter"
date: 2011-05-12 17:35
comments: true
categories: [rails, ruby]
---

<p>

Suppose you want to build a Rails application for tracking popular links, and you want it to post the most popular links to Twitter automatically.  This quick tutorial will show you how to do that using the newest version of the Ruby <a href="https://github.com/jnunemaker/twitter">twitter gem</a>.  A little while ago I added the ability for <a href="http://absurdlycool.com">Freebies Finder</a> to tweet popular freebies.  I recently had to do this for another site and decided that a tutorial was in order.

</p>



<h2>Setup the accounts</h2>



<p>

We&#8217;ll pretend that our website is called AwesomeLinks.com.  <a href="https://twitter.com/signup" target="_blank">Signup for two Twitter accounts</a>, AwesomeLinks and AwesomeLinksDev.  We need to create a Twitter application through which our website can post to these accounts.  Do this by logging into AwesomeLinks and visiting <a href="https://dev.twitter.com/apps/new"><a href="https://dev.twitter.com/apps/new">https://dev.twitter.com/apps/new</a></a>.  Select &#8216;Client&#8217; as the Application Type, skip the Callback URL, and select Read &amp; Write access.  Twitter will give you a OAuth Consumer key and secret, which you will soon need.

</p>



<h2>Getting your OAuth Token and Secret</h2>



<p>

Now you need to authorize your new Twitter Application to post on both of your Twitter accounts.  For this, we use a script:

</p>



<script src="https://gist.github.com/969776.js?file=get_token.rb"></script><p style="font-size: 0.8em">(If you used the Twitter gem in the past, you may have used <code>authorize_from_access</code> for this, but that no longer works.  We now have to require and use oauth separately.)</p>



<p>

Fill in your Twitter Application&#8217;s Consumer key and secret and run the script.  You will be prompted to visit a URL and then to enter the PIN that Twitter provides.  Do this for both of your new Twitter accounts and record the results in <code>config/twitter.yml</code>, like so:

</p>



<script src="https://gist.github.com/969776.js?file=twitter.yml"></script><h2>Initializing the Twitter gem</h2>



<p>

Now, create an initializer in <code>config/initializers/twitter.rb</code> and again include your Twitter App&#8217;s key and secret:

</p>



<script src="https://gist.github.com/969776.js?file=twitter_initializer.rb"></script><p style="font-size: 0.8em">

(If you want to Tweet to multiple accounts, you can do this differently and instead make separate Twitter::Client object, each with their own OAuth tokens.)

</p>



<h2>Tweeting the Twitter</h2>



<p>

Finally, it&#8217;s time to augment our Link model so that it can send tweets.  I decided to have it tweet the link&#8217;s description and a shortened version of its URL using the following code:

</p>



<script src="https://gist.github.com/969776.js?file=link.rb"></script><p>

The rest is up to you.  You could write a cronjob to automatically call <code>tweet!</code> on every link, or only on those with enough popularity.  Have fun!

</p>
