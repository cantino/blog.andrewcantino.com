---
layout: post
title: "Machine Learning Project Ideas"
date: 2012-04-22 15:56
comments: true
categories: [ideas, ruby, machine learning]
---
[Ryan Stout](http://twitter.com/#!/ryanstout) and I are giving a [talk](http://railsconf2012.com/sessions/14) at RailsConf about Machine Learning tomorrow.  To go along with the talk, here is a list of project ideas to get your creative juices flowing:

* A robust email and mailing address typo corrector for web forms.
* A Rickroll detecting browser plugin- it warns you before you follow a link that will likely result in Rickrolling.  (Rickroll Protection As A Service?)
* A per-user clicktrail analyzer that predicts which links a user is most likely to follow, given their history.  Use this to highlight or promote high-likelihood links.
* A user info and usage pattern analyzer that classifies users by likelihood of upgrading to a premium plan.
* A RubyGem for classifying user generated content into appropriate, inappropriate, spam, NSFW, etc.
* Along the same lines: a nudity detector for uploaded images.
* A RubyGem for code optimization based on the current backtrace, possibly using reinforcement learning.  For example:
``` ruby
  # This probabilistically selects a choice based on the
  # current backtrace and the history of reinforcement signals seen.
  optimize do
    choice do
      # some code path that ultimately triggers a "reward" or "punishment" signal
    end
    choice do
      # some other code path
    end
  end
```
* A story karma predictor that estimates the final score on Hacker News of any article, based on textual content and the poster's info.
* A system that classifies support requests by their estimated severity.
* Make things easier for your users:
  * given them default settings selected by users similar to themselves
  * default to pages they use often; expand modules they interact with frequently

Once you know what's possible, it's hard to find a project that *wouldn't* benefit from some machine learning.

Have other ideas?  Want to discuss these?  Post them in the comments and follow [@tectonic](http://twitter.com/tectonic) for updates.