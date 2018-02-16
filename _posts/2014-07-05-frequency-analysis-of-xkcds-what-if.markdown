---
layout: post
title: "Frequency Analysis of XKCD's 'What If?'"
date: 2014-07-05 09:06:16 -0700
comments: true
categories: 
---
I thought it'd be fun to do a word frequency analysis of XKCD author Randall Munroe's wonderful ["What If?"](https://what-if.xkcd.com/) series.

<!-- more -->

After tokenizing all current 102 "What If?" entries and removing common [stop words](http://en.wikipedia.org/wiki/Stop_words), the following words were some of the most common:

    speed - 181 occurrences
    surface - 143 occurrences
    energy - 125 occurrences
    meters - 119 occurrences
    second - 119 occurrences
    space - 91 occurrences
    pressure - 81 occurrences
    still - 81 occurrences
    million - 80 occurrences
    moon - 80 occurrences
    average - 80 occurrences

Okay, that's fun, but not super surprising.  To dig deeper, I switched to counting the number of *different* entries that a given word shows up in, instead of just the total occurrence count.

It starts with some equivocation

    probably - 73 entries
    around - 69 entries
    might - 63 entries

then moves on to physics and time

    earth - 56 entries
    world - 51
    hard - 50
    years - 50
    speed - 46
    surface - 45
    meters - 44
    air - 43
    speed - 43
    water - 42
    ground - 35
    problem - 35
    energy - 34
    atmosphere - 33
    matter - 33
    space - 33
    billion - 32
    force - 30
    gravity - 22
    sea - 21

then to unfortunate outcomes

    impact - 21 entries
    unfortunately - 18
    surprisingly - 18
    roughly - 17
    die - 17
    destroy - 16
    population - 16
    rapidly - 16
    weird - 16
    experience - 16

Then I decided to see how this compares to what we know and love about XKCD.

Well, 'dinosaur(s)' only show up in 9 entries.  Of those, the favorites are tyrannosaurus, sauropods, and spinosaurus, but each of those only shows up in one entry.  Very surprisingly, raptors never show up except in illustrations!

Other popular topics include spacecraft (14 entries), baseball (9 entries), asteroids and meteors (both 9 entries, but not always the same ones), explosions and vaporization (7 entries), nuclear (13) & radiation (7), and hurricanes (8).  Here are some more common topics:

    orbit - 19 entries
    mountain - 19
    moon - 16
    island - 14
    rocket - 14
    spacecraft - 14
    oxygen - 12
    satellite - 11
    atmospheric - 11
    launch - 11
    lifetime - 10
    war - 10
    weapon - 9
    mach - 9
    government - 9
    blast - 9
    bullet - 8
    airplane - 8
    hurricane - 8
    hydrogen - 8
    molecule - 7
    trigger - 6
    extinction - 6

I think I'm seeing a trend.  Now back to reading *What If?*!