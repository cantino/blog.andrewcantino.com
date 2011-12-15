---
layout: post
title: "Hacking Google for fun and profit"
date: 2011-12-14 20:37
comments: true
categories: security
---
At the end of last year, Google announced their [Vulnerability Reward Program](http://googleonlinesecurity.blogspot.com/2010/11/rewarding-web-application-security.html) which rewards security researchers for reported security and privacy holes in Google properties.  This sounded like an interesting challenge, and I set out to find security holes.  I found three, got paid, and am now in the [Google Security Hall of Fame](http://www.google.com/about/corporate/company/halloffame.html). All and all, a rewarding experience.

Below I describe the three security holes that I found.

## Determining if a user has emailed another user

In my opinion, this is the most subtle, but also the most disturbing, of the three bugs.  As with the other bugs that I found, this was an example of [Cross Site Request Forgery](http://en.wikipedia.org/wiki/Cross-site_request_forgery)- the practice of convincing a user's browser to make a request on their behalf to a remote server.  This type of attack generally only works when the user is logged in to the remote service.  In this case, if a user is already logged into Gmail (and they usually are), a malicious website could make a series of requests for Gmail profile images and, based on the return codes, determine whether or not the visitor had communicated with another Gmail user.  This worked because Gmail, as a well-intentioned privacy measure, would only show profile images to a viewer if they had had mutual contact.  Here is some example code that worked at the time:

``` javascript checkUsername
    function checkUsername(username, callback) {
        var image = new Image();
        image.onload = function() {
  		callback(true);
        };
        image.onerror = function() {
			callback(false);
        };
        image.src = "https://mail.google.com/mail/photos/" + username + "%40gmail.com?1&rp=1&pld=1&r=" + (new Date()).getTime();
    }

    checkUsername("fbi-reports", function(hasEmailed) {
		alert("The current visitor " + (hasEmailed ? "has" : "has not") + " emailed the FBI.");
	});

    checkUsername("wikileaks", function(hasEmailed) {
		alert("The current visitor " + (hasEmailed ? "has" : "has not") + " emailed WikiLeaks.");
```		

It should be clear why this is a serious privacy concern.  If you suspected someone of being a whistleblower, for example, you could make a page that probed a bunch of revealing email addresses and checked to see if any had been contacted.  Luckily, Google reports that they have now fixed this bug.  Cross Site Request Forgery attacks can usually be prevented by adding a [CSRF](http://en.wikipedia.org/wiki/Cross-site_request_forgery#Other_approaches_to_CSRF) token (a unique and user-specific token) to every request.

## Identification of a user's Gmail address

This bug would have allowed a malicious website to determine your Google username if you were simultaneously logged into your Google account and typed anything into a seemingly innocuous web form.  One of the fields in the form would actually be an iframe pointing to a public Google Document.  When the user typed into the field, they would really be entering text into the Google Document, and what appeared to be their cursor in the field would actually be the Google Document insertion point.  When a user typed into the field, the attacker could determine their username (and hence email address) by observing the publicly-displayed list of current document editors.

Again, this is a type of Cross Site Request Forgery, specifically known as [Clickjacking](http://en.wikipedia.org/wiki/Clickjacking), which can be especially hard to prevent.  There are many types of Clickjacking, almost all of which use iframes.  One approach, which I used here, is to artfully display content from a target site in such a way as to look like it's part of the current page. Another approach is to hide the iframe invisibly under the user's cursor, moving it as the cursor moves, and causing the user to click on the other site without realizing it.

Google correctly used the [X-XSS-Protection](http://msdn.microsoft.com/en-us/library/dd565647(v=vs.85).aspx) and [X-Frame-Options](https://developer.mozilla.org/en/The_X-FRAME-OPTIONS_response_header) headers, but some browsers do not honor these.  The solution to this one is tricky, but it is generally to use [frame busting](http://en.wikipedia.org/wiki/Framekiller), to provide appropriate headers, to use CSRF tokens, and to not expose any user information without a direct user interaction.

## Deletion of all future email 

The third bug that I found was a fairly severe security hole that affected a portion of Gmail users.  Due to a missing CSRF token during the first step of the filter creation flow in the HTML-only version of Gmail, a malicious site could trick visitors into creating a Gmail filter that would delete all future received email.  This worked in the current (at the time) version of Firefox, but not in Chrome or Safari due to their correct handling of the x-frame-options header.  I didn't test it in IE.

This security hole was exploitable via a combination of a classic Cross Site Request Forgery with a Clickjacking attack.  First, I discovered that it was possible to submit the first part of the filter creation flow in an iframe using JavaScript because Google had forgotten to include a unique CSRF token in the form.

``` html
	<form id='form' method='POST' target='iframe' action='https://mail.google.com/mail/h/ignored/?v=prf' enctype='multipart/form-data'>
	    <input type=hidden name='cf1_hasnot' value='adfkjhsdf'>
	    <input type=hidden name='s' value='z'>
	    <input type=hidden name='cf2_tr' value='true'>
	    <input type=hidden name='cf1_attach' value='false'>
	    <input type=hidden name='nvp_bu_nxsb' value='Next Step'>
	    <input type='submit' style='display: none'>
	</form>
```

I then positioned the iframe such that the "Create Filter" button on the subsequent page would fill the frame without showing the button border; only the word "Create" was visible.  A fake button was then shown around the iframe with a style that matched the gmail style such that when the user believed they were submitting a form with a submit button entitled "Create," they were really creating a malicious and destructive filter in Gmail.

Google says this has now been fixed.

## Google's Response

In all three cases, Google responded promptly to my security report and fixed the bug within a reasonable amount of time.  I was given two $500 awards for the three bugs.  Google generously doubled these amounts when I chose to donate them to charity, so the [Athens Conservency](http://www.athensconservancy.org/) and the [Buckeye Forest Council](http://www.buckeyeforestcouncil.org/), two of my favorite local charities in Athens, OH, received one thousand dollars each, care of Google.

These were subtle bugs.  They took trial and error to find.  However, in total, I only spent a few spare evenings of my time.  If Google's products- some of the most secure in the world- are suseptible to these sorts of attacks, you can bet many others are as well.  Every programer makes these mistakes sometimes.  Security is too complicated for anyone to get right all of the time.  Check your code!

##Take your security into your own hands... or, why you should hack Google too!

Many companies try to silence security bug reporters through legal threats and sometimes even action, driving discoverers of bugs underground and onto the black market where such knowledge can do real harm.  Google has set an admirable example by creating a program that is enlightened, responsive, and well-run, and I hope other companies move in the same direction.  

I had a great time using [jsFiddle](http://jsFiddle.net) to explore and demonstrate bugs.  You can do the same-- check out their [guidelines](http://googleonlinesecurity.blogspot.com/2010/11/rewarding-web-application-security.html) and do your part to improve the security of products that you love.

Enjoyed this post?  You should <a href="https://twitter.com/intent/follow?original_referer=http%3A%2F%2Fblog.andrewcantino.com%2Fblog%2F2011%2F12%2F14%2Fhacking-google-for-fun-and-profit%2F&region=follow_link&screen_name=tectonic&source=followbutton&variant=2.0">follow me on Twitter</a>.
