---
layout: post
title: "Parsing Bash in JavaScript in Chrome with Browserify"
date: 2014-02-28 22:21:48 -0800
comments: true
categories: [JavaScript, tools]
---
For a side project, I wanted to be able to use [js-shell-parse](https://github.com/grncdr/js-shell-parse) to parse complex Bash commands in JavaScript, in a Chrome extension.  (More on this craziness in a future post!)

The js-shell-parse library is targeted at node, and it makes frequent use of `require` and of various npm packages.  Being a node noob, I hadn't used [Browserify](http://browserify.org/) before, but it turned out to be exactly what I needed: a tool to bundle complex dependency chains of node packages for the browser.  Here are the steps to convert js-shell-parse into a single, compiled bundle:

``` sh
# Clone the repo
git clone https://github.com/grncdr/js-shell-parse.git

# Install the various npm dependencies and browserify (you may need to use sudo)
npm install -g pegjs pegjs-override-action isarray array-map browserify

# Run the included build script
node build.js > js-shell-parse.js

# Create a very simple loader script called 'loader.js' that contains one line
echo "window.jsShellParse = require('./js-shell-parse');" > loader.js

# Run browserify on the loader, which will parse the AST and bundle all dependencies
browserify loader.js -o compiled-js-shell-parse.js
```

Finally, you can include the output in any website!

``` html
<script src="compiled-js-shell-parse.js"></script>
```

and try this in the console:

``` javascript
var structure = jsShellParse('echo "The date is: `date`" > output');
console.log(JSON.stringify(structure));
"[{"type":"command","command":{"type":"literal","value":"echo"},"args":[{"type":"concatenation","pieces":[{"type":"literal","value":"The date is: "},{"type":"command-substitution","commands":[{"type":"command","command":{"type":"literal","value":"date"},"args":[],"redirects":[],"env":{},"control":";","next":null}]}]}],"redirects":[{"type":"redirect-fd","fd":1,"op":">","filename":{"type":"literal","value":"output"}}],"env":{},"control":";","next":null}]"
```

If you're playing with js-shell-parse, [the tests](https://github.com/grncdr/js-shell-parse/tree/master/tests) are helpful to see what kinds of shell/bash commands it can parse.  (Pretty much everything!)
