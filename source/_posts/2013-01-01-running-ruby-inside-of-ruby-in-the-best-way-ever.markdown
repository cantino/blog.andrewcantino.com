---
layout: post
title: "Running Ruby inside of Ruby (in the best way ever)"
date: 2013-01-01 13:39
comments: true
categories: [ruby, code, tools, javascript]
---
There are no good Ruby sandboxing options right now.  You can sort of use `$SAFE` levels and [taint checking](http://www.ruby-doc.org/docs/ProgrammingRuby/html/taint.html), you can sort of use [Shikashi](https://github.com/tario/shikashi), you can use the [secure gem](http://rubydoc.info/gems/secure) to run in a separate process, and you can, with much care, use chrooted and jailed virtual machines or [Linux containers](http://lxc.sourceforge.net/).  None of these options met my exacting standards, meaning they're not ridiculous.  Therefore, I'm introducing…

**RubyOnRuby**!

An unholy amalgam of therubyracer's V8 engine and emscripted-ruby to allow a truly sandboxed Ruby-on-Ruby environment.

[Check it out on GitHub!](https://github.com/cantino/ruby_on_ruby)