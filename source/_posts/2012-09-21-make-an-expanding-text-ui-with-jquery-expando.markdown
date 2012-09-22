---
layout: post
title: "Make an expanding text UI with jQuery Expando"
date: 2012-09-21 20:34
comments: true
categories: [ui, javascript]
---
<script src="https://raw.github.com/cantino/expando/master/jquery.expando.js" type="text/javascript"></script>

<script>
  jQuery(function() {
    jQuery("#expando-example").expando();
  });
</script>

<span id="expando-example"><expando><initial>Recently</initial><expanded>Recently, after receiving a couple of <expando><initial>requests</initial><expanded>friendly requests</expanded></expando></expanded></expando>, I extracted the <expando><initial>code</initial><expanded>jQuery code</expanded></expando> powering the <expando><initial>UI</initial><expanded>expanding text UI</expanded></expando> of [andrewcantino.com](http://andrewcantino.com).  You can <expando><initial>get it</initial><expanded>download or fork the source</expanded></expando> on GitHub: [https://github.com/cantino/expando](https://github.com/cantino/expando)</span>