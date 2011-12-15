---
layout: post
title: "Why plug computers are a security nightmare"
alias: "/post/3565673304/why-plug-computers-are-a-security-nightmare"
date: 2011-02-28 18:03
comments: true
categories: security
---
The increasing availability of low profile &#8220;wall-wart&#8221; plug computers like the <a href="http://www.plugcomputer.org/">SheevaPlug</a> can be viewed as an emerging threat to physical network security.  For $99, a budding industrial espionagist could buy the SheevaPlug developer kit or the consumer <a href="http://www.tonidoplug.com/">TonidoPlug</a>, install some easily-available network intrusion testing software, and illicitly &#8220;test&#8221; the security of a competitor&#8217;s network.

While many of these techniques have been known for a while, the low form factor of plug computers and consumer netbooks, coupled with their rapidly decreasing price, could enable disposable intrusion tools and open new avenues for attack.  The current $99 SheevaPlug has no wireless capability and limited storage, but the manufacture has <a href="http://www.prnewswire.com/news-releases/marvell-unveils-plug-computer-30-with-integrated-wireless-and-built-in-hard-drive-80693037.html">just announced</a> an expanded model with wifi, bluetooth, and an internal hard drive.  Even without these advances, current generation plug computers can easily be expanded with a USB memory stick or external USB hard drive, USB wireless interface, and more.  For little more than $100 one could make a practically undetectable wireless bug that can be deployed in seconds.

In fact, soon you may be able to just buy an all-in-one penetration plug computer, the <a href="http://theplugbot.com/">PlugBot</a>.

<strong>edit</strong>: as was pointed out to me after posting this article, the described device already exists and can tunnel out over <strong>3G</strong>.  <a href="http://pwnieexpress.com/pwnplug3g.html">http://pwnieexpress.com/pwnplug3g.html</a>

With two wireless adapters and some simple software, a plug computer becomes a wireless bridge capable of automatically cracking wireless networks in range (both WEP and WPA are vulnerable these days; see <a href="http://www.aircrack-ng.org/">aircrack</a>).  Most locations have multiple 3rd party networks overlapping their physical space, which, if cracked, could be used as back channels for the plug computer to phone home.  The attacker could then tunnel into the company network undetected and completely bypass the company&#8217;s external defenses by routing through an available 3rd party wireless network.  From the perspective of the attacked network, even if the intrusion is noticed, it appears to come from within their own physical space.

A number of other uses come to mind for such devices:
	
* Passive sniffing of internal network traffic using dsniff and sending it back to an attacker.  Many networks aren&#8217;t sufficiently secured once you&#8217;re past the perimeter firewalls.
* Physically connect two ethernet interfaces and use the plug computer as a man-in-the-middle proxy to sniff all traffic entering and leaving a workstation.
* Attach a camera or other sensor payload and use as an over-the-internet video bug.

Again, much of this has been possible for a while, but form factor is everything.  Also, I haven&#8217;t seen people talking about the possibility of bridging multiple available wireless networks together for attack obfuscation and to avoid connecting through a company&#8217;s edge network.  I don&#8217;t think companies pay enough attention to passive physical monitoring and intrusion threats like this, especially given the insecurity of wireless encryption standards.  What do you think?