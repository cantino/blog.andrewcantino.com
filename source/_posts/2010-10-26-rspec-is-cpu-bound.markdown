---
layout: post
title: "Rails RSpec tests are CPU bound"
alias: "/post/1411733593/rspec-is-cpu-bound"
date: 2010-10-26 18:03
comments: true
categories: [ruby, rails, testing]
---
<p>Today I experimented with running a large Rails RSpec test suite on a RAM disk.  My hope was that by hosting either the MySQL server or the Rails project directory on the RAM disk, the test execution would be significantly increased.  If this were the case, I would feel (more) compelled to buy a <a href="http://www.apple.com/macbookair/">certain new device with a solid-state disk drive</a>.  Unfortunately, while I now have some slick scripts to bring up a RAM disk with either my Rails project or MySQL running on it, the improvements were on the order of 10 seconds over a 10 minute test run (the load time of Rails).  Thus, it is clear that these tests are CPU bound, not disk IO bound, and a SSD wouldn&#8217;t help.</p>

<p>If you have an SSD, can you corroborate this?</p>

<p><span style="color: #bbb">(Tests were performed on a brand new Quad-Core Intel Core i7 iMac.)</span></p>
