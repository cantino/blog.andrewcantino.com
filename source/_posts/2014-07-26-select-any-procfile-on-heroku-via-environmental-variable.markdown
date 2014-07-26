---
layout: post
title: "Select any Procfile on Heroku via Environmental Variable"
date: 2014-07-26 13:45:53 -0700
comments: true
categories: [heroku, tools]
---
I couldn't figure out a way to customize which Procfile is run on Heroku, so I made a very simple buildpack that moves your preferred Procfile into position on deploy.

https://github.com/cantino/heroku-selectable-procfile
