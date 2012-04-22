---
layout: post
title: "Machine Learning Project Ideas"
date: 2012-04-22 15:56
comments: true
categories: [ideas, ruby, machine learning]
---
[Ryan Stout](http://twitter.com/#!/ryanstout) and I are giving a [talk](http://railsconf2012.com/sessions/14) at RailsConf about Machine Learning tomorrow.  To go along with the talk, here is a list of project ideas to get your creative juices flowing:

* Robust email and mailing address typo corrector for web forms.
* Rickroll detector as a browser plugin- it warns you before following a link that will likely result in Rickrolling.  (Rickroll Protection As A Service?)
* Per-user clicktrail analyzer that predicts which links a user is most likely to follow, given their history.  Use this to highlight or promote high-likelihood links.
* User info and usage pattern analyzer that classifies users by likelihood of upgrading to a premium plan.
* RubyGem for classifying user generated content into appropriate, spam, NSFW, etc.
* Along the same lines: nudity detector for uploaded images.
* RubyGem for code optimization based on the current backtrace, possibly using reinforcement learning.  For example:
``` ruby
  # This probabilistically selects a choice based on the
  # current backtrace and the history of reinforcement signals seen.
  optimize do
    choice do
      # some code path that ultimately triggers a "reward" or "punishment"
    end
    choice do
      # some other code path
    end
  end
```
* Story karma predictor that predicts the final score on Hacker News of any article, based on textual content and the poster.
* Make things easier for your users- use default settings selected by users similar to themselves.
* Classify support requests by estimated severity.

Once you know what's possible, it's hard to find a project that doesn't have need for some sort of machine learning intelligence.

Have other ideas?  Want to discuss these?  Post them in the comments and follow [@tectonic](http://twitter.com/tectonic) for updates.