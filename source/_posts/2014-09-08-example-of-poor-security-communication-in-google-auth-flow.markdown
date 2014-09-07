---
layout: post
title: "An Example of Poor Security Communication in the Google Auth Flow"
date: 2014-09-08 12:16:00 -0700
comments: true
categories: [security]
---
## Responsible Disclosure

The issues discussed in this post were [responsibly disclosed](http://en.wikipedia.org/wiki/Responsible_disclosure) to Google Security.  Google triaged the issues, talked to the involved teams, and declined the opportunity to fix before publication.  They gave me written permission to blog about this.

# The Attack

**Summary**: Users are not clearly told that they're authorizing a 3rd party Google Apps Script until it's too late, making social engineering attacks far too easy.  Google shows an authorization screen, but that screen *does not* make it clear who owns the script.  The authorization screen allows any app name and doesn't indicate that it could be a 3rd party.  Worse, Google Apps Scripts are on a Google domain, so even savvy users who look for suspicious domains will be fooled.  After authorization, the script can do something malicious, such as upload the user's email, delete data, or access sensitive personal information via a Google API.

<!-- more -->

**How it works**:  Google Apps Script is a very powerful scripting environment provided by Google that can make authenticated requests against user data inside of Google's properties.

Let's walk through the flow.  Here is a simple Google Apps Script that I made.  Notice the trust-worthy *google.com* domain.  This could also be linked to from another trust-worthy area of Google, such as a Google Drive document.

{% img /images/posts/security/auth-flow/step1.png %}

A malicious person could make an Apps Script that performs almost any action against a user's Google data, then share the link in the guise of a helpful tool.  Since the URL will be to *script.google.com*, it looks legitimate and even savvy users will likely be fooled.  

I named my app "Google Security Upgrader", but it could be called "New Gmail".

Here is an example authorization flow that a victim sees:

{% img /images/posts/security/auth-flow/step2.png %}

The attacker's ability to name the app anything they want is very dangerous.  I named the app "Google Security Upgrader".  Google *in no way* makes it clear that this app was created by a 3rd party, and is not affiliated with Google.

The user approves the app, because it seems completely legit:

{% img /images/posts/security/auth-flow/step3.png %}

Once approved, my particular script actually just makes a new Gmail label, but it could have deleted data, emailed a link to the script to everyone in the user's contact list, manipulated personal information, or stolen data and sent it to a 3rd party.

Effective security communication is really hard, but it's very important to communicate to a user what actions they're taking, especially during an authorization flow.  At minimum, I feel that Google should add a very prominent warning, both at the top of the script page and in the authorization box.

As it is, I feel it is unreasonable to expect that users would understand the possibility that malicious code could be executed while remaining entirely within the Google domain, especially if the script was served via another trusted Google service, such as Google Drive.

Ironically, *after* authorization, Google sends an email explaining that a 3rd party app has been authorized, but at this point it's way, way too late! The app has already accessed the user's data, and has deleted, stolen, or manipulated it.

## Additional details

The test app in this case is called "Google Security Upgrader" and simply contains:

``` javascript
function doGet() {
  GmailApp.createLabel("FOO")
  return HtmlService.createHtmlOutput('We deleted all your email and stuff. Have a nice day!');
}
```

## Google's Response

Google chose not to fix this issue before publication: "The team will take this suggestion into consideration, but per our discussion with them, this is currently working as designed and is not a technical vulnerability.  Thanks again for the report, and good luck in your future bug hunting!"

Unlike my recent [report to Google about a timing attack](/blog/2014/09/04/demasking-google-users-with-a-timing-attack/), I think this particular issue *is* severe and should be fixed.  I hope they do so soon.

## More about web security

More articles I've written about web security and Google:

* [Demasking Google Users with a Timing Attack](/blog/2014/09/04/demasking-google-users-with-a-timing-attack/)
* [Hacking Google for Fun and Profit](/blog/2011/12/14/hacking-google-for-fun-and-profit/)
