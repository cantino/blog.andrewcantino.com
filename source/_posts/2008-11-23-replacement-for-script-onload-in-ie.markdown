---
layout: post
title: Replacement for script onload in IE
alias: "/post/211671748/replacement-for-script-onload-in-ie"
date: 2008-11-23 18:03
comments: true
categories: javascript
---

<p><i>This is an old post from my last blog.</i></p>

<p>Firefox and Safari support an onload event for SCRIPT elements.  That is, you can dynamically add a new script to a page, set its onload event to fire a callback, and know when the script has been successfully loaded.  You would want to do this because when you include a bunch of new SCRIPT tags in a page, there are no guarantees in what order the browser will decide to evaluate them, thus making dependencies among the scripts difficult to resolve.  Using onload to chain the script additions is one solution to this, however, Internet Explorer doesn&#8217;t seem to support onload in SCRIPT tags.</p>



<p><i>Update: Owen in the comments says: Thanks for your post, but I have since found a more efficient way to do this and thought I might share with you. As you said you can use an onload event in Firefox, but in IE you can use the onreadystatechange event. Works from at least IE6. Haven’t tested earlier.</i></p>

<p>My solution:</p>

<pre>  function importJS(src, look_for, onload) {

   var s = document.createElement('script');

   s.setAttribute('type', 'text/javascript');

   s.setAttribute('src', src);

   if (onload) wait_for_script_load(look_for, onload);

   var head = document.getElementsByTagName('head')[0];

   if (head) {

     head.appendChild(s);

   } else {

     document.body.appendChild(s);

   }

 }



 function importCSS(href, look_for, onload) {

   var s = document.createElement('link');

   s.setAttribute('rel', 'stylesheet');

   s.setAttribute('type', 'text/css');

   s.setAttribute('media', 'screen');

   s.setAttribute('href', href);

   if (onload) wait_for_script_load(look_for, onload);

   var head = document.getElementsByTagName('head')[0];

   if (head) {

     head.appendChild(s);

   } else {

     document.body.appendChild(s);

   }

 }



 function wait_for_script_load(look_for, callback) {

   var interval = setInterval(function() {

     if (eval("typeof " + look_for) != 'undefined') {

       clearInterval(interval);

       callback();

     }

   }, 50);

 }



 (function(){

   importCSS('some_stylesheet.css');

   importJS('jquery-1.2.6.js', 'jQuery', function() {

     importJS('some_script_that_uses_jquery.js');

     importJS('another_one.js', 'SomeClassOrVariableSetByTheScript',

       function() {

         importJS('a_script_that_uses_that_class_or_variable.js');

       });

   });

 })();</pre>
